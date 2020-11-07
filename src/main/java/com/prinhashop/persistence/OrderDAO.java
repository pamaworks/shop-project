package com.prinhashop.persistence;

import java.util.List;

import com.prinhashop.domain.OrderDetailVO;
import com.prinhashop.domain.OrderListVO;
import com.prinhashop.domain.OrderReadDetailVO;
import com.prinhashop.domain.OrderVO;

public interface OrderDAO {

	// 핸드폰 번호 가져오기
	public String buyPhoneCheck(String mem_id)throws Exception;
	
	// 주문코드 시퀀스 가져오기
	public int readOrderCode()throws Exception;
	
	// 주문 내역 추가
	public void addOrderDetail(OrderDetailVO vo)throws Exception;
	
	// 주문 정보 추가
	public void addOrder(OrderVO vo)throws Exception;
	
	// 주문 목록 / 주문 조회
	public List<OrderListVO> orderList(String mem_id)throws Exception;
	
	// 주문 상세 정보
	public List<OrderReadDetailVO> readOrder(int ord_code) throws Exception;
	
	// 주문자 정보
	public OrderVO getOrder(int ord_code)throws Exception;
}
