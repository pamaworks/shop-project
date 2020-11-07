package com.prinhashop.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.prinhashop.domain.OrderDetailVO;
import com.prinhashop.domain.OrderDetailVOList;
import com.prinhashop.domain.OrderListVO;
import com.prinhashop.domain.OrderReadDetailVO;
import com.prinhashop.domain.OrderVO;
import com.prinhashop.persistence.OrderDAO;

@Service
public class OrderServiceImpl implements OrderService {

	@Inject
	private OrderDAO dao;
	
	@Inject
	private CartService cartService;

	// 핸드폰 번호 가져오기
	@Override
	public String buyPhoneCheck(String mem_id) throws Exception {
		
		return dao.buyPhoneCheck(mem_id);
	}

	
	
	// ORDER_TBL - 주문테이블 : 주문자, 수령인의 정보
	// ORDER_DETAIL_TBL - 주문 상세 테이블(주문번호+상품코드) : 상품 정보 저장
	// 상품구매 완료 페이지 (상품 상세 & 리스트 )
	// 트랜잭션 1.주문정보 추가  2.주문상세정보 추가
	@Override
	@Transactional
	public void addOrder(OrderVO order, OrderDetailVOList orderDetailList) throws Exception {

		// 시퀀스를 처리하는 방법 2가지
		// 주문코드 시퀀스 가져오기 -> 주문정보, 주문상세정보에 동일한 주문코드 사용
		int ord_code = dao.readOrderCode(); 
		System.out.println("ord_code : "+ord_code);
		// 주문 정보 추가
		order.setOrd_code(ord_code); // 주문번호할당
		dao.addOrder(order); // 1. 주문정보  추가(주문테이블에 데이터 삽입)
		System.out.println("ord_code2 : "+ord_code);
		List<OrderDetailVO> list = orderDetailList.getOrderDetailList();
		
		// 주문 상세 건수 만큼 반복
		for(int i=0; i<list.size(); i++) { // 주문 개수
			
			OrderDetailVO orderDetail = list.get(i);
			orderDetail.setOrd_code(ord_code); // 주문번호할당
			dao.addOrderDetail(orderDetail); // 2. 주문상세정보 추가
		}
		
	}


	// 상품구매 완료 페이지 (장바구니)
	// 장바구니에서 넘어온 경우, 장바구니 테이블에서 해당 상품 삭제 -> 바로 구매와 다른 점
	// 트랜잭션 1.주문정보 추가  2.주문상세정보 추가
	@Transactional
	@Override
	public void addOrderCart(OrderVO order, OrderDetailVOList orderDetailList, String mem_id) throws Exception {

		// 시퀀스를 처리하는 방법 2가지
		// 주문코드 시퀀스 가져오기 -> 주문정보, 주문상세정보에 동일한 주문코드 사용
		int ord_code = dao.readOrderCode(); 
		System.out.println("ord_code : "+ord_code);
		// 주문 정보 추가
		order.setOrd_code(ord_code); // 주문번호할당
		dao.addOrder(order); // 1. 주문정보  추가(주문테이블에 데이터 삽입)
		
		List<OrderDetailVO> list = orderDetailList.getOrderDetailList();
		
		// 주문 상세 건수 만큼 반복
		for(int i=0; i<list.size(); i++) { // 주문 개수
			
			OrderDetailVO orderDetail = list.get(i);
			orderDetail.setOrd_code(ord_code); // 주문번호할당
			dao.addOrderDetail(orderDetail); // 2. 주문상세정보 추가
			
			
			// 해당 장바구니 테이블에서 주문 상품 삭제
			//
			// 1)
			// 구매페이지에서 장바구니의 내역을 보여주고 진행이 된다면 -> for문 사용x
			// 굳이 리스트 필요없고 장바구니 테이블에서 사용자 아이디만 있으면 장바구니 테이블 모두 삭제(자신의 상품정보 삭제)
			//
			// 2)
			// 구매페이지에서 체크박스에 의한 선택 기능이 포함된 장바구니의 내역을 보여주고 진행이 된다면
			// 선택에 의하여 주문 결제를 한다고 할경우 -> for문 사용
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("mem_id", mem_id);
			map.put("pdt_num", orderDetail.getPdt_num());
			
			System.out.println("장바구니삭제map : "+map.toString());
			// 장바구니 삭제!! deleteCartOrder
			cartService.deleteCartOrder(map);
			
		}
	}


	// 주문 목록 / 주문 조회
	@Override
	public List<OrderListVO> orderList(String mem_id) throws Exception {
		
		return dao.orderList(mem_id);
	}

	// 주문 상세 정보
	@Override
	public List<OrderReadDetailVO> readOrder(int ord_code) throws Exception {
		
		return dao.readOrder(ord_code);
	}

	// 주문자 정보
	@Override
	public OrderVO getOrder(int ord_code) throws Exception {
		
		return dao.getOrder(ord_code);
	}
	
	
	
}
