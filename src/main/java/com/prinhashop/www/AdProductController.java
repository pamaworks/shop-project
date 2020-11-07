package com.prinhashop.www;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.prinhashop.domain.CategoryVO;
import com.prinhashop.domain.ProductVO;
import com.prinhashop.service.AdProductService;
import com.prinhashop.util.FileUtils;
import com.prinhashop.util.PageMaker;
import com.prinhashop.util.SearchCriteria;

@Controller
@RequestMapping("/admin/product/*")
public class AdProductController {
	
	@Inject
	private AdProductService service;
	
	// 웹프로젝트 영역 외부에 파일을 저장할 때 사용할 경로
	@Resource(name="uploadPath")
	private String uploadPath; // servlet-context.xml

	private static final Logger logger = LoggerFactory.getLogger(AdProductController.class);
	 
	
	// 1) 1차 카테고리에 따른 2차 카테고리 출력 - jsp 파일 주소 반환 X
	/*
	  	@Params
	  	@PathVariable("cate_code") : path로 들어온 1차 카테고리
	  	
	  	@return ResponseEntity<List<CategoryVO>> : REST방식에 따른 HttpStatus를 같이 보내줌
	  	
	  	return값 JSON으로 사용
	*/
	@ResponseBody
	@RequestMapping(value = "/subCGList/{cate_code}",method = RequestMethod.GET)
	public ResponseEntity<List<CategoryVO>> subCGListPOST(@PathVariable("cate_code") String cate_code){
		
		logger.info("-- 카테고리 리스트 출력");
		
		// 2차 카테고리 리스트
		ResponseEntity<List<CategoryVO>> entity = null;
		try {
			entity = new ResponseEntity<List<CategoryVO>>(service.subCGList(cate_code),HttpStatus.OK);
			
		}catch (Exception e) {
			
			entity = new ResponseEntity<List<CategoryVO>>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return entity;
	}
	
	
	// 2) 파일 출력(저장된 파일을 가져와 반환) - jsp 파일 주소 반환 X
	@ResponseBody
	@RequestMapping(value = "displayFile",method = RequestMethod.GET)
	public ResponseEntity<byte[]> displayFile(String fileName)throws Exception{
		
		return FileUtils.getFile(uploadPath, fileName);
	}
	
	
	// 3) 이미지 파일 삭제  - jsp 파일 주소 반환 X
	public void deleteFile(String fileName) {
		logger.info("delete FileName : "+fileName);
		
		FileUtils.deleteFile(uploadPath, fileName);
	}
	
	
	// 4) 상품 등록 뷰 GET
	@RequestMapping(value = "insert", method = RequestMethod.GET)
	public void productInsertGET(Model model) throws Exception{
		// 1차 카테고리 리스트 전송 -> 1,2차 카테고리 출력
		model.addAttribute("cateList", service.mainCGList());
	}
	
	
	// 5) 상품 상세 CK-EDITOR(파일 업로드)
	/*
		웹 프로젝트 영역 상위 폴더에 업로드
		
		@Params
		MultipartFile upload : 이미 지정된 이름 (바꾸면 안됌)
	*/
	@RequestMapping(value = "imgUpload",method = RequestMethod.POST)
	public void imgUpload(HttpServletRequest req, HttpServletResponse res, MultipartFile upload) {
		
		logger.info("-- CK-Editor 이미지 업로드..");
		
		OutputStream out = null;
		PrintWriter printWriter = null;
		
		// 업로드가 된 서버측의 경로를 클라이언트에게 전송
		// 1) 클라이언트 설정
		res.setCharacterEncoding("utf-8");
		res.setContentType("text/html;charset=utf-8");
		
		try {
			
			// 전송할 파일 정보 가져오기
			String fileName = upload.getOriginalFilename();
			byte[] bytes = upload.getBytes();
			
			// 폴더 경로 설정
			String uploadPath = req.getSession().getServletContext().getRealPath("/");
			uploadPath = uploadPath + "resources\\upload\\" + fileName;
			
			logger.info("-- uploadPath : "+uploadPath);
			
			// 출력 스트림 생성
			out = new FileOutputStream(new File(uploadPath));
			// 파일 쓰기
			out.write(bytes);
			
			// 2) 클라이언트 설정
			printWriter = res.getWriter();
			String fileUrl = "/upload/" + fileName;
			
			// CK-Editor4에서 제공하는 형식
			printWriter.println("{\"filename\":\"" + fileName + "\", \"uploaded\":1,\"url\":\"" + fileUrl + "\"}");
			printWriter.flush(); // 전송!!(return과 같은 의미-> 클라이언트에게 보냄)
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(out!=null) { // 출력 스트림 종료
				try {out.close();}catch(Exception e) {e.printStackTrace();}
			}
			if(printWriter!=null) { // printWriter 종료
				try {printWriter.close();}catch(Exception e) {e.printStackTrace();}
			}
		}
		
	}
	
	
	
	// 상품 등록POST
	@RequestMapping(value = "insert", method = RequestMethod.POST)
	public String productInsertPOST(ProductVO vo, RedirectAttributes rttr)throws Exception{
		
		logger.info("-- 상품 등록");
		logger.info("상품정보 / vo : "+vo.toString());
		
		// pdt_img를 업로드된 이미지 파일로 설정
		vo.setPdt_img(FileUtils.uploadFile(uploadPath,vo.getFile1().getOriginalFilename(),vo.getFile1().getBytes()));
		
		// 상품테이블 데이터 삽입
		service.insertProduct(vo);
		rttr.addFlashAttribute("msg", "INSERT_SUCCESS");
		
		return "redirect:/admin/product/list";
	}
	
	
	
	// 7) 상품 리스트(페이징, 검색조건 포함)
	/*
	  	 # jsp로 전달
	  	 1. 검색 조건에 해당하는 상품 리스트
	  	 2. PageMaker
	  	 
	  	 url이 처음 요청 받았을 경우 SearchCriteria cri의 기본값을 가지게 됨
	  	 기본값 ->  page=1; 현재 페이지 번호  / perPageNum=10; 한페이지에 출력하는 게시물 개수  / searchType=null; /  keyword=null;
	 */
	@RequestMapping(value = "list",method = RequestMethod.GET)
	public void productList(@ModelAttribute("cri") SearchCriteria cri, Model model)throws Exception{
		
		logger.info("-- 관리자 상품 리스트");
		logger.info("-- cri : "+cri.toString()); // SearchType, keyword
		
		// 기능(query mapper) - 1.searchListProduct(리스트) / 2.searchListCount(개수) / 3.검색조건 쿼리(두 개의 기능에 include)
		
		// 페이징 기능이 적용된 상품데이터 (검색 기능은 선택)
		model.addAttribute("productList",service.searchListProduct(cri));
		
		// PageMaker 생성
		PageMaker pm = new PageMaker(); // 1 2 3 4 5
		pm.setCri(cri); // 페이지정보, 검색정보 세팅
		
		// 검색 조건에 맞는 상품 개수
		int count = service.searchListCount(cri);
		
		logger.info("-- 검색 조건에 일치하는 상품 개수 : "+count);
		pm.setTotalCount(count);
		
		model.addAttribute("pm", pm);
	}
	
	

	// 8) 상품 상세정보 페이지 읽기
	@RequestMapping(value = "read",method = RequestMethod.GET)
	public void productReadGET(@ModelAttribute("cri") SearchCriteria cri,
								@RequestParam("pdt_num") int pdt_num,
								Model model) throws Exception {
		
		logger.info("-- 관리자 상품 상세페이지");
		
		// 선택한 상품 정보 읽어오기
		ProductVO vo = service.productRead(pdt_num);

		logger.info("-- 썸네일이미지 이름 변경 전 상품 상세 : "+vo.toString());

		// 썸네일 원본(완전 원본은 아니고 UUID+원본파일명) 가져오기
		String name = FileUtils.thumbToOriginName(vo.getPdt_img());
		model.addAttribute("name", name);
		
		// 썸네일 파일 이름 수정
		vo.setPdt_img(vo.getPdt_img().substring(vo.getPdt_img().lastIndexOf("_")+1));
		
		logger.info("-- 썸네일이미지 이름 변경 후 상품 상세 : "+vo.toString());
		
		model.addAttribute("vo", vo);
		
		// 상품 목록으로 돌아가기 클릭시 페이징 정보 가져가기
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		
		model.addAttribute("pm", pm);
	}

	
	
	// 9) 상품 수정 뷰 GET
	/*
	  	#JSP로 전달 하는 것들
		1. 선택한 상품 정보
		2. 1차 카테고리 리스트
		3. 현재 선택된 2차 카테고리 리스트
		4. PageMaker
		5. 원래 저장되어있던 파일명
	*/
	@RequestMapping(value = "edit",method = RequestMethod.GET)
	public void productEditGET(@ModelAttribute("cri")SearchCriteria cri,
								@RequestParam("pdt_num") int pdt_num,
								Model model)throws Exception{
		
		logger.info("-- 상품 수정 뷰");
		
		// 선택한 상품의 데이터 얻기
		ProductVO vo = service.productRead(pdt_num);
		
		logger.info("-- 선택 상품 정보 : "+vo.toString());
		
		List<CategoryVO> subCateList = service.subCGList(vo.getCate_code_prt());
		
		// 썸네일의 원본 파일명
		String originFile = vo.getPdt_img().substring(vo.getPdt_img().lastIndexOf("_")+1);
		
		
		model.addAttribute("vo", vo);
		model.addAttribute("originFile", originFile);
		model.addAttribute("cateList", service.mainCGList());
		model.addAttribute("subCateList", service.subCGList(vo.getCate_code_prt()));

		// PageMaker 생성 -> 상품목록으로 돌아가기 클릭 시 페이징 정보 가져가기
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		
		model.addAttribute("pm", pm);
	}
	

	
	// 10) 상품 수정POST
	@RequestMapping(value = "edit",method = RequestMethod.POST)
	public String productEditPOST(ProductVO vo, SearchCriteria cri, RedirectAttributes rttr)throws Exception{
		
		logger.info("-- 상품 수정 post");
		logger.info("수정 전 데이터 : "+vo.toString());
		logger.info("검색페이징정보 : "+cri.toString());
		
		// 파일 사이즈 비교하여 새로운 파일 등록 여부 확인
		// 파일을 새로 등록하지 않은 경우에는, null이 아닌 비어있는 쓰레기 파일이 넘어옴
		if(vo.getFile1().getSize() > 0) {
			// 파일이 변경된 경우, pdt_img를 업로드된 파일로 변경
			vo.setPdt_img(FileUtils.uploadFile(uploadPath, 
							vo.getFile1().getOriginalFilename(), 
							vo.getFile1().getBytes()));
		}
		logger.info("-- 수정 후 데이터 : "+vo.toString());
		
		// 상품 업데이트(수정)
		service.productEdit(vo);
		
		rttr.addFlashAttribute("cri", cri);
		rttr.addFlashAttribute("msg", "EDIT_SUCCESS");
		
		
		return "redirect:/admin/product/list";
	}
	
	
	
	// 11) 상품 삭제POST
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	public String productDeletePOST(SearchCriteria cri,
									@RequestParam("pdt_num") int pdt_num,
									@RequestParam("pdt_img") String pdt_img,
									RedirectAttributes rttr)throws Exception{
		
		logger.info("-- 상품 삭제");
		logger.info("삭제되는 상품 pdt_num : "+pdt_num);
		logger.info("삭제되는 상품 이미지 : "+pdt_img);
		
		deleteFile(pdt_img); // 이미지 삭제
		
		// 상품 삭제
		service.productDelete(pdt_num);
		
		rttr.addFlashAttribute("cri", cri);
		rttr.addFlashAttribute("msg", "DELETE_SUCCESS");
		
		return "redirect:/admin/product/list";
	}
	
	
	
	// 12) 선택된 상품 수정 -- DB연동 에러 있음
	// (+최종 수정일 업데이트)
	/*
	  @RequestParam("checkArr[]") List<Integer> checkArr - 체크한 상품 개수
	  @RequestParam("amountArr[]") List<Integer> amountArr - 수량
	  @RequestParam("buyArr[]") List<String> buyArr - 판매 여부
	*/
	@ResponseBody
	@RequestMapping(value = "editChecked", method = RequestMethod.POST)
	public ResponseEntity<String> editChecked(@RequestParam("checkArr[]") List<Integer> checkArr,
											  @RequestParam("amountArr[]") List<Integer> amountArr,
											  @RequestParam("buyArr[]") List<String> buyArr){
		logger.info("선택 상품 수정");
		
		logger.info(checkArr.toString());
		logger.info(amountArr.toString());
		logger.info(buyArr.toString());
		
		ResponseEntity<String> entity = null;
		try {
			Map<String,Object> map = new HashMap<String, Object>();
			
			for(int i=0; i<checkArr.size();i++) { // 체크한 상품 개수만큼 반복
				
				map.put("put_num",checkArr.get(i));
				map.put("pdt_amount", amountArr.get(i));
				map.put("pdt_buy",buyArr.get(i));
				
				// 선택 상품 수정
				service.editChecked(map);
			}
			
			
			logger.info("선택상품 수정 성공");
			entity = new ResponseEntity<String>(HttpStatus.OK);
			
		}catch(Exception e) {
			logger.info("선택상품 수정 실패");
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		entity = new ResponseEntity<String>(HttpStatus.OK);
		return entity;
	}
	
	
	// 13) 선택된 상품 삭제
	@ResponseBody
	@RequestMapping(value = "deleteChecked", method = RequestMethod.POST)
	public ResponseEntity<String> deleteChecked(@RequestParam("checkArr[]") List<Integer> checkArr,
												@RequestParam("imgArr[]") List<String> imgArr){
		
		logger.info("-- 선택 상품 삭제");
		
		ResponseEntity<String> entity = null;
		
		logger.info("checkArr"+checkArr.toString());
		logger.info("imgArr"+imgArr.toString());
		
		try {
			// 체크된 상품의 이미지와 상품 삭제
			for(int i=0; i< checkArr.size(); i++) {
				deleteFile(imgArr.get(i));
				service.productDelete(checkArr.get(i));
			}
			
			entity = new ResponseEntity<String>(HttpStatus.OK);
			
		}catch(Exception e) {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	


}
