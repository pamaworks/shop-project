package com.prinhashop.www;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.prinhashop.domain.AdOrderVO;
import com.prinhashop.domain.OrderListVO;
import com.prinhashop.domain.OrderReadDetailVO;
import com.prinhashop.domain.OrderReadDetailVOList;
import com.prinhashop.domain.OrderReadDetailVOList2;
import com.prinhashop.service.AdOrderService;
import com.prinhashop.service.OrderService;
import com.prinhashop.util.PageMaker;
import com.prinhashop.util.SearchCriteria;

@Controller
@RequestMapping("/admin/order/*")
public class AdOrderController {
	
	@Inject
	private AdOrderService service;
	
	@Inject
	private OrderService orderService;

	private static final Logger logger = (Logger) LoggerFactory.getLogger(AdOrderController.class);

	// 1) 주문 리스트  (검색 조건 포함)
	@RequestMapping(value = "list",method = RequestMethod.GET)
	public void orderList( @ModelAttribute("cri") SearchCriteria cri,
						   Model model, HttpSession session)throws Exception{
		
		logger.info("-- 회원 주문 정보 조회");
		
		if(cri.getSearchType()==null) {
			logger.info("cri.getSearchType() 널 입니다");
			
		}else if("".equals(cri.getSearchType())) {
			logger.info("\"\".equals(cri.getSearchType()) 공백 값 널 입니다");
			cri.setSearchType(null);
		}else {
			logger.info("cri.getSearchType() 널 아닙니다");
			
		}
		
		
		// List<AdOrderVO> vo = service.orderInfo(); 
		// logger.info(vo.toString());
		
		// 주문정보조회 (검색 x/페이징x)
		// model.addAttribute("orderInfo",vo);
		
		// 페이징,검색 기능이 적용된 주문 데이터
		model.addAttribute("orderInfo", service.searchListProduct(cri));
		
		// PageMaker 생성
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		
		// 검색 조건에 맞는 상품 개수
		int count = service.searchListCount(cri);
		
		pm.setTotalCount(count);
		
		model.addAttribute("pm", pm);
		
		/*
		List<OrderReadDetailVO> order = new ArrayList<OrderReadDetailVO>();  
	
		List<List<OrderReadDetailVO>> orderList = new ArrayList<List<OrderReadDetailVO>>(); 
		
		for(int i=0; i<vo.size();i++) {
			int ord_code = vo.get(i).getOrd_code();
			order= orderService.readOrder(ord_code);
			orderList.add(order);
		}
		model.addAttribute("orderList",orderList);
		*/
	}
	
	
	// 2) 배송 상태 변경
	@ResponseBody
	@RequestMapping(value = "delivery",method = RequestMethod.POST)
	public ResponseEntity<String> delivery(
										   @RequestParam("ord_delivery") String ord_delivery,
										   @RequestParam("ord_code") int ord_code){
		
		logger.info("-- 배송상태변경");
		
		ResponseEntity<String> entity = null;
		
		logger.info("delivery : "+ord_delivery);
		
		try {
			
			Map<String,Object> map = new HashMap<String, Object>();
			
			
			map.put("ord_delivery", ord_delivery);
			map.put("ord_code",ord_code);
			
			// 배송 상태 변경
			service.delivery(map);
			
			entity = new ResponseEntity<String>(HttpStatus.OK);
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	
	// 3) 주문 상세 조회
	@RequestMapping(value = "read",method = RequestMethod.GET)
	public void readGET(int ord_code, Model model)throws Exception{
		
		logger.info("-- 관리자 주문 상세조회");
		
		// 주문 상세 정보
		model.addAttribute("orderList",orderService.readOrder(ord_code));
		
		// 주문자 정보
		model.addAttribute("order",orderService.getOrder(ord_code));
	}
	
}
