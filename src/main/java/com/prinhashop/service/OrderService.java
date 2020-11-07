package com.prinhashop.service;

import java.util.List;

import com.prinhashop.domain.OrderDetailVOList;
import com.prinhashop.domain.OrderListVO;
import com.prinhashop.domain.OrderReadDetailVO;
import com.prinhashop.domain.OrderVO;

public interface OrderService {
	
	// 핸드폰 번호 가져오기
	public String buyPhoneCheck(String mem_id)throws Exception;
	
	// 주문코드 시퀀스 가져오기
	//public int readOrderCode()throws Exception;
	
	// 상품구매 완료 페이지 (상품 상세 & 리스트 )
	// 주문 내역과 주문정보 추가
	public void addOrder(OrderVO order, OrderDetailVOList orderDetailList)throws Exception;
	
	// 상품구매 완료 페이지 (장바구니)
	public void addOrderCart(OrderVO orer, OrderDetailVOList orderDetailList, String mem_id)throws Exception;

	// 주문 목록 / 주문 조회
	public List<OrderListVO> orderList(String mem_id)throws Exception;
	
	// 주문 상세 정보
	public List<OrderReadDetailVO> readOrder(int ord_code) throws Exception;
	
	// 주문자 정보
	public OrderVO getOrder(int ord_code)throws Exception;
}
