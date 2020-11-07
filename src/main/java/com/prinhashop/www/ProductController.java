package com.prinhashop.www;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.prinhashop.domain.CategoryVO;
import com.prinhashop.domain.ProductVO;
import com.prinhashop.service.ProductService;
import com.prinhashop.service.ReviewService;
import com.prinhashop.util.Criteria;
import com.prinhashop.util.FileUtils;
import com.prinhashop.util.PageMaker;
import com.prinhashop.util.SearchCriteria;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	@Inject
	ProductService service;
	
	@Inject
	ReviewService reviewService; // 상세페이지에 리뷰 작업
	
	// 웹 프로젝트 영역 외부에 파일을 저장할 때 사용하는 경로
	@Resource(name="uploadPath")
	private String uploadPath; // servlet-context.xml에 설정
	
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	
	// 1) 각 카테고리에 해당하는 상품 리스트 출력 GET
	// 추후 조잡한 코드들 정리해주기
	@RequestMapping(value = "list",method = RequestMethod.GET)
	public String list(@ModelAttribute("cri") Criteria cri,
					   @ModelAttribute("cate_code") String cate_code,
					   Model model ) throws Exception{

		logger.info("-- 각 카테고리에 해당하는 상품 리스트 출력");
		
		// 공통작업-------------------------------------------------
		
		// PageMaker 생성
		PageMaker pm = new PageMaker();
		pm.setCri(cri);

		// 페이징하기위한 정보와 같이 넘기기 위해 Map 작업
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rowStart", cri.getRowStart());
		map.put("rowEnd", cri.getRowEnd());
		
		//------------------------------------------------------
		
		
		// 카테고리 코드 체크
		int check = service.cateCodeCheck(cate_code);
		// 0보다 크면 1차 카테고리 , 0이면 2차 카테고리
		if(check>0) {
			
			// 1차 카테고리 이름 / 코드
			model.addAttribute("cate_name_prt", service.getCGName(cate_code));
			model.addAttribute("cate_code_prt", cate_code);

			
			// 1차 카테고리에 의한 2차 카테고리의 cate_code 가져오기
			//String subCode = service.getCGCode(cate_code);
			//model.addAttribute("cate_code_sub", subCode);
			//map.put("cate_code", subCode);
			
			// 1차 카테고리에 대한 2차 카테고리 출력 -> subCGList 모델 작업
			List<CategoryVO> subCGList = service.subCGList(cate_code);
			model.addAttribute("subCGList", subCGList);
	
			map.put("cate_code_prt", cate_code);
			
			// 1차 카테고리에 의한 2차 카테고리 모두의 상품리스트 모델 작업
			List<ProductVO> allProductList = service.allProductListCG(map);
			model.addAttribute("productList", allProductList);
			
			int count = service.productCountAll(cate_code);
			pm.setTotalCount(count);
			
			//logger.info("allProductList"+allProductList.toString());
			//logger.info("allProductList count"+count);
			
		}else {
			
			// 1차 카테고리 가져오기
			String cate_code_prt = service.mainCGCode(cate_code);
			
			model.addAttribute("cate_code_prt", cate_code_prt);
			model.addAttribute("cate_name_prt",service.getCGName(cate_code_prt));
			
			// 2차 카테고리 코드
			model.addAttribute("cate_code_sub", cate_code);
			
			List<CategoryVO> subCGList = service.subCGList(cate_code_prt);
			model.addAttribute("subCGList", subCGList);
		
			map.put("cate_code", cate_code);

			// 2차 카테고리에 대한 상품리스트 모델 작업
			List<ProductVO> productList = service.productListCG(map);
			model.addAttribute("productList", productList);
			
			int count = service.productCount(cate_code);
			pm.setTotalCount(count);
			
			//logger.info("productList"+productList.toString());
			//logger.info("productList count"+count);
		}
	
		// 페이징 정보 공통 부분 모델 작업
		model.addAttribute("pm",pm);
		
		return "/product/list";
	}	
	
	
	
	// 2) 파일출력(displayFile) GET
	@ResponseBody
	@RequestMapping(value = "displayFile", method = RequestMethod.GET)
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception {
		
		return FileUtils.getFile(uploadPath, fileName);
	}
	
	
	// 3) 검색조건에 해당하는 상품 리스트 출력 GET
	@RequestMapping(value="listSearch",method = RequestMethod.GET)
	public void listSearch(@ModelAttribute("scri") SearchCriteria scri,
							Model model)throws Exception{
		
		logger.info("-- 상품 검색");
		logger.info("-- cri : "+scri.toString());
		
		// 검색에 맞는 상품이 있으면 상품 담기
		List<ProductVO> list = service.productListSearch(scri);
		model.addAttribute("productList", list);
		
		// PageMaker 생성
		PageMaker pm = new PageMaker();
		pm.setCri(scri);
		
		// 검색조건에 해당하는 상품 개수
		int count = service.productCountSearch(scri.getKeyword());
		pm.setTotalCount(count);
	
		model.addAttribute("pm", pm);
	}
	
	
	// 5) 카테고리 선택 -> 상품 상세정보 페이지 읽기 GET (Criteria를 파라미터로 받음)
	@RequestMapping(value = "read",method = RequestMethod.GET)
	public void productReadGET(@ModelAttribute("cri") Criteria cri,
							   @RequestParam("pdt_num") int pdt_num,
							   Model model)throws Exception{
		
		logger.info("-- 상품 상세정보 읽기(카테고리 선택)");
		
		// pdt_num으로 해당 상품 정보 받아오기
		ProductVO vo = service.readProduct(pdt_num);
		
		// 선택한 상품 정보의 이미지를 썸네일에서 원본으로 변경
		vo.setPdt_img(FileUtils.thumbToOriginName(vo.getPdt_img()));
	
		logger.info("-- 받아온 상품 정보(ProductVO)출력 : "+vo.toString());
		
		// 상품정보 model 작업
		model.addAttribute("vo", vo);
		
		// PageMaker 생성 -> 상품 목록으로 돌아가기 클릭하고 이동할때 필요
		PageMaker pm = new PageMaker();
		pm.setCri(cri);

		model.addAttribute("pm", pm);
		
		// 해당 상품에 달린 상품 후기 개수를 함께 보냄
		model.addAttribute("totalReview", reviewService.countReview(vo.getPdt_num()));
	}
	
	

	// 6) 검색 리스트 -> 상품 상세정보 페이지 읽기 GET (SearchCriteria를 파라미터로 받음)
	@RequestMapping(value = "readSearch",method = RequestMethod.GET)
	public void productReadSearch(@ModelAttribute("scri") SearchCriteria scri,
								  @RequestParam("pdt_num") int pdt_num,
								  Model model)throws Exception{
		
		logger.info("-- 상품 상세정보 읽기(검색)");
		
		// pdt_num으로 해당 상품 정보 받아오기
		ProductVO vo = service.readProduct(pdt_num);
				
		// 선택한 상품 정보의 이미지를 썸네일에서 원본으로 변경
		vo.setPdt_img(FileUtils.thumbToOriginName(vo.getPdt_img()));
			
		logger.info("-- 받아온 상품 정보(ProductVO)출력 : "+vo.toString());
		
		// 상품정보 model 작업
		model.addAttribute("vo", vo);
		
		// PageMaker 생성 -> 상품 목록으로 돌아가기 클릭하고 이동할때 필요
		PageMaker pm = new PageMaker();
		pm.setCri(scri);
		
		model.addAttribute("pm", pm);
		
		// 해당 상품에 달린 상품 후기 개수를 함께 보내기
		model.addAttribute("totalReview", reviewService.countReview(vo.getPdt_num()));
		
	}
	

}
