package com.prinhashop.domain;

import java.util.List;

//  OrderDetail을 리스트로 만드는 VO
public class OrderDetailVOList {

	// OrderDetail 10개를 1개의 리스트로 만들기
	private List<OrderDetailVO> orderDetailList;

	public List<OrderDetailVO> getOrderDetailList() {
		return orderDetailList;
	}

	public void setOrderDetailList(List<OrderDetailVO> orderDetailList) {
		this.orderDetailList = orderDetailList;
	}

	@Override
	public String toString() {
		return "OrderDetailVOList [orderDetailList=" + orderDetailList + "]";
	}
	
}
