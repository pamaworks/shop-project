package com.prinhashop.www;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.prinhashop.domain.MemberVO;
import com.prinhashop.domain.OrderDetailVOList;
import com.prinhashop.domain.OrderListVO;
import com.prinhashop.domain.OrderVO;
import com.prinhashop.domain.ProductVO;
import com.prinhashop.dto.MemberDTO;
import com.prinhashop.service.MemberService;
import com.prinhashop.service.OrderService;
import com.prinhashop.service.ProductService;

@Controller
@RequestMapping(value = "/order/")
public class OrderController {
	
	@Inject
	private OrderService service;
	
	@Inject
	private ProductService productService;

	@Inject
	private MemberService memberService;

	private static final Logger logger = LoggerFactory.getLogger(OrderController.class);

	// 0) top부분 order 클릭 -> 구매 페이지
	@RequestMapping(value = "buyTOP",method = RequestMethod.GET)
	public String buyTOP(String mem_id) {
		
		
		return "/order/buy";
	}
	
	
	// 1) 상품 상세 & 리스트 -> 구매 페이지
	// (구매 or 바로 구매)
	// 상품리스트, 수량리스트, 구매자 정보 전달
	@RequestMapping(value = "buy", method = RequestMethod.GET)
	public void buyGET(@RequestParam int ord_amount,
					   @RequestParam int pdt_num,
					   Model model,
					   HttpSession session)throws Exception{
		
		logger.info("-- 상품상세&리스트에서 -> 구매 페이지 buyGET");
		
		List<ProductVO> productList = new ArrayList<ProductVO>();
		List<Integer> amountList = new ArrayList<Integer>();
		
		// 구매하는 상품 상세정보 읽어오기
		productList.add(productService.readProduct(pdt_num));
		// 구매하는 상품 수량
		amountList.add(ord_amount);
	
		model.addAttribute("productList",productList);
		model.addAttribute("amountList",amountList);
		
		// 로그인한 세션정보 dto에 저장
		MemberDTO dto = (MemberDTO)session.getAttribute("user");
		model.addAttribute("user",memberService.userInfo(dto.getMem_id()));
		
		// 핸드폰 번호 가져오기 - 로그인 DTO인 MemberDTO에 없음
		model.addAttribute("mem_phone",service.buyPhoneCheck(dto.getMem_id()));
	}
	
	
	
	// 2) 장바구니 -> 구매(단일 상품) 
	// 주소가 같아도 get방식(단일상품), post방식(다수상품) 구분하기
	@RequestMapping(value = "buyFromCart", method = RequestMethod.GET)
	public String buyFromCartGET(@RequestParam int ord_amount,
								 @RequestParam int pdt_num,
								 Model model,
								 HttpSession session)throws Exception{
		
		logger.info("-- 장바구니에서 단일상품 구매 buyFromCartGET");
		
		List<ProductVO> productList = new ArrayList<ProductVO>();
		List<Integer> amountList = new ArrayList<Integer>();
		
		// 상품 정보 읽어오기
		productList.add(productService.readProduct(pdt_num));
		amountList.add(ord_amount);
		
		model.addAttribute("productList", productList);
		model.addAttribute("amountList", amountList);
		
		// 로그인한 세션정보 dto에 저장
		MemberDTO dto = (MemberDTO)session.getAttribute("user");
		model.addAttribute("user",memberService.userInfo(dto.getMem_id()));
		
		// 핸드폰 번호 가져오기 - 로그인 DTO인 MemberDTO에 없음
		model.addAttribute("mem_phone",service.buyPhoneCheck(dto.getMem_id()));
		
		return "/order/buyFromCart";
	}
	
	
	
	// 3) 장바구니 -> 체크상품 구매(다수 상품)
	/*
	 *  form 전송 
		체크박스에는 value=장바구니코드
		
		ex) 장바구니 리스트에 3개가 있는데, 체크박스 2개 선택시
		@RequestParam("check") List<Integer> checkList : 체크박스 / 선택했던 체크박스 2개의 정보(장바구니코드)
		@RequestParam("pdt_num") List<Integer> pdt_numList : 상풐코드
		@RequestParam("cart_amount") List<Integer> cart_amountList : 수량
		@RequestParam("cart_code") List<Integer> cart_codeList : 장바구니코드 / 3개중에 2개에 해당되는 코드만 참조
	
	*/
	@RequestMapping(value = "buyFromCart", method = RequestMethod.POST)
	public void buyFromCartPOST(@RequestParam("check") List<Integer> checkList,
								@RequestParam("pdt_num") List<Integer> pdt_numList,
								@RequestParam("cart_amount") List<Integer> cart_amountList,
								@RequestParam("cart_code") List<Integer> cart_codList,
								Model model,
								HttpSession session)throws Exception{
		
		logger.info("-- 장바구니에서 체크상품(다수)구매 buyFromCartPOST");
		
		// 선택된 2개의 상품코드, 수량정보 작업
		// 상품 정보를 저장하기 위한 컬렉션 객체 생성 -> 체크박스에 선택된 행의 상품코드의 정보를 db에서 가져와서 저장
		List<ProductVO> productList = new ArrayList<ProductVO>();
		List<Integer> amountList = new ArrayList<Integer>();
		
		// 장바구니 목록에서 체크된 값을 선택해서 List에 추가
		for(int i=0; i<cart_codList.size(); i++) { // 3개
			for(int j=0; j<checkList.size(); j++) { // 2개
				
				if(cart_codList.get(i) == checkList.get(j)) { // 전체 3번 중 2번 true
					
					// 선택된 행의 상품코드를 db에서 가져와 컬렉션에 추가
					productList.add(productService.readProduct((int)pdt_numList.get(i)));
					
					// cart_amountList.get(i) : 선택된 행의 변경된 수량
					amountList.add(cart_amountList.get(i)); // 데이터 추가
					
					continue; // 제어가 안쪽 for문의 j++으로
					
				}else {
					continue;
				}
			}
		}
		
		// 선택된 상품의 구매페이지에서 필요한 Model 작업
		model.addAttribute("productList",productList);
		model.addAttribute("amountList",amountList);
		
		MemberDTO dto = (MemberDTO)session.getAttribute("user");
		model.addAttribute("user",memberService.userInfo(dto.getMem_id()));
		
		// 핸드폰 번호 가져오기 - 로그인 DTO인 MemberDTO에 없음
		model.addAttribute("mem_phone",service.buyPhoneCheck(dto.getMem_id()));		
		
	}
	
	
	
	// 4) 구매완료 페이지 (상품 상세 & 리스트 ) - 실제 DB 작업
	/*
	  	1:N 관계
	  	OrderDetailVOList  orderDtailList - List 컬렉션 파라미터로 받는 방법
	  	-> jsp에서 여러개가 들어오는 작업이 되어있어야함 (buy.jsp)
	  	<input type="hidden" id="amount_${productVO.pdt_num}" name="orderDetailList[${i.index}].ord_amount" value="${amountList[i.index]}" />
		<input type="hidden" name="orderDetailList[${i.index}].pdt_num" value="${productVO.pdt_num}" />
		<input type="hidden" name="orderDetailList[${i.index}].ord_price" value="${productVO.pdt_discount}" />
	  	
	  	OrderVO order : 주문정보 1개
	  	OrderDetailVOList  orderDtailList : 주문 상세정보 여러개
	  	
	*/
	@RequestMapping(value = "order", method = RequestMethod.POST)
	public String orderPOST(OrderVO order,
							OrderDetailVOList orderDetailList,
							HttpSession session)throws Exception{
		
		logger.info("-- 구매완료 페이지 (상품 상세 & 리스트 ) orderPOST");
		
		logger.info("-- OrderVO(주문자 정보) : "+order.toString());
		logger.info("-- OrderDetail(주문 내역) : "+orderDetailList.toString());
		
		// 주문 전송
		service.addOrder(order, orderDetailList);
		
		return "/order/orderComplete";
	}
	
	
	
	// 5) 구매완료 페이지(장바구니 -> 구매) - 실제 DB 작업
	// check 파라미터 작업이 없는 상태, 체크가 됐든 안됐든 작업에 포함되지않음
	@RequestMapping(value = "orderFromCart", method = RequestMethod.POST)
	public String orderFromCartPOST(OrderVO order,
									OrderDetailVOList orderDetailList,
									Model model,
									HttpSession session)throws Exception{
		
		logger.info("-- 구매완료 페이지 (장바구니) orderFromPOST");
		
		logger.info("-- OrderVO(주문자 정보) : "+order.toString());
		logger.info("-- OrderDetail(주문 내역) : "+orderDetailList.toString());
		
		MemberDTO dto = (MemberDTO)session.getAttribute("user");
		service.addOrderCart(order, orderDetailList, dto.getMem_id()); // 주문 전송	
		
		return "/order/orderComplete";
	}
	
	
	
	// 6) 주문 조회 작업
	@RequestMapping(value = "list",method = RequestMethod.GET)
	public void listGET(Model model, HttpSession session)throws Exception{
		
		logger.info("-- 주문 조회");

		MemberDTO dto = (MemberDTO)session.getAttribute("user");
		List<OrderListVO> list = service.orderList(dto.getMem_id());
		
		model.addAttribute("orderList",list);
	}
	
	
	
	// 7) 주문 상세 조회
	@RequestMapping(value = "read", method = RequestMethod.GET)
	public void readGET(int ord_code, Model model, HttpSession session)throws Exception{
		
		logger.info("-- 주문 상세 조회");
		
		// 주문 상세 정보
		model.addAttribute("orderList",service.readOrder(ord_code));
		
		// 주문자 정보
		model.addAttribute("order",service.getOrder(ord_code));
	}
	
	
}
