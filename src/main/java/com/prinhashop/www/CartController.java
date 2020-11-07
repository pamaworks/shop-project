package com.prinhashop.www;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.prinhashop.domain.CartVO;
import com.prinhashop.dto.MemberDTO;
import com.prinhashop.service.CartService;

@Controller
@RequestMapping(value="/cart/*")
public class CartController {

	@Inject
	private CartService service;
	
	// 웹 프로젝트 영역 외부에 파일을 저장할 때 사용할 경로
	@Resource(name="uploadPath")
	private String uploadPath; // servlet-context.xml
	
	private static final Logger logger = LoggerFactory.getLogger(CartController.class);

	
	// 1) 장바구니 목록
	@RequestMapping(value = "list",method = RequestMethod.GET)
	public void listCartGET(Model model,HttpSession session)throws Exception{
		
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		model.addAttribute("cartProductList",service.getCart(dto.getMem_id()));
	
	}
	

	// 2) 장바구니에 추가 - [상품 1개 / 수량 1개 추가] REST POST
	// 상품 리스트에서 장바구니 추가
	@ResponseBody
	@RequestMapping(value = "add", method = RequestMethod.POST)
	public ResponseEntity<String> addCart(int pdt_num, HttpSession session){
		
		logger.info("-- 장바구니에 상품 추가(상품1개, 수량 1개)");
		logger.info("-- 상품번호 pdt_num : "+pdt_num);
		
		ResponseEntity<String> entity = null;
		
		CartVO vo = new CartVO();
		MemberDTO dto = (MemberDTO)session.getAttribute("user");
		
		vo.setMem_id(dto.getMem_id());
		vo.setPdt_num(pdt_num);
		vo.setCart_amount(1);
		
		logger.info("-- CartVO vo : "+vo.toString());
		
		try {
			// 장바구니에 상품 추가
			service.addCart(vo);
			logger.info("-- CartVO vo2 : "+vo.toString());
			entity = new ResponseEntity<String>(HttpStatus.OK);
	
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	// 3) 장바구니에 추가 - [상품 1개 / 수량 여러개 추가] REST POST
	// 상품 상세페이지에서 장바구니 추가 
	@ResponseBody
	@RequestMapping(value = "addMany", method = RequestMethod.POST)
	public ResponseEntity<String> addManyCart(int pdt_num, 
											  int pdt_amount, 
											  HttpSession session){
		
		logger.info("-- 장바구니에 상품 추가(상품1개, 수량 1개)");
		logger.info("-- 상품번호 pdt_num : "+pdt_num);
		
		ResponseEntity<String> entity = null;
		
		CartVO vo = new CartVO();
		
		// 세션으로부터 로그인 정보 참조
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		
		vo.setMem_id(dto.getMem_id());
		vo.setPdt_num(pdt_num);
		vo.setCart_amount(pdt_amount);
		
		// 세가지 파라미터를 vo에 담아서 vo로 파라미터 사용
		// vo에 해당하는 클래스의 필드가 많은 경우에는 3개의 파라미터 사용을 권장
		logger.info("-- CartVO vo : "+vo.toString());
		
		try {
			service.addCart(vo);
			entity = new ResponseEntity<String>(HttpStatus.OK);
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	// 4) 장바구니 삭제
	@ResponseBody
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	public ResponseEntity<String> deleteCart(int cart_code)throws Exception{
		
		logger.info("-- 장바구니 삭제");
		
		ResponseEntity<String> entity = null;
		
		try {
			logger.info("-- 장바구니 코드 : "+cart_code);
			service.deleteCart(cart_code); // 장바구니 삭제
			entity = new ResponseEntity<String>(HttpStatus.OK);
			
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	

	// 5) 장바구니 선택 삭제
	/*
		ajax로 넘어온 데이터 파라미터로 받기 @RequestParam("checkArr[]")
		키는 checkArr이지만 받는 파라미터는 [] 추가 꼭 해주기!!!!
		List<Integer> -> 기본타입 (int) 금지 -> 클래스 사용하기(Integer)
	*/
	@ResponseBody
	@RequestMapping(value = "deleteChecked", method = RequestMethod.POST)
	public ResponseEntity<String> deleteChecked(
			@RequestParam("checkArr[]") List<Integer> checkArr)throws Exception{
		
		logger.info("-- 장바구니 선택 삭제");
		
		ResponseEntity<String> entity = null;
		
		try {
			for(int cart_code : checkArr) {
				service.deleteCart(cart_code);
			}
			
			entity = new ResponseEntity<String>(HttpStatus.OK);
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	// 6) 장바구니 수량 수정
	@ResponseBody
	@RequestMapping(value = "modify", method = RequestMethod.POST)
	public ResponseEntity<String> modifyCart(int cart_code, int cart_amount){
		
		logger.info("-- 장바구니 수량 수정");
		logger.info("-- cart_code : "+cart_code);
		logger.info("-- cart_amount : "+cart_amount);
		
		ResponseEntity<String> entity = null;
		
		// cart_code와 cart_amount map으로 묶기
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cart_code", cart_code);
		map.put("cart_amount", cart_amount);
		
		try {
			service.updateCart(map); // 장바구니 수량 수정
			entity = new ResponseEntity<String>(HttpStatus.OK);
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
}
