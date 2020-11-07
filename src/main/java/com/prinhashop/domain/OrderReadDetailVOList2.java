package com.prinhashop.domain;

import java.util.List;

// OrderReadDetailVOList를 리스트로 만드는 VO
public class OrderReadDetailVOList2 {
	
	// OrderReadDetailVO 10개를 1개의 리스트로 만들기
	private List<OrderReadDetailVOList> orderReadDetailVO2;

	public List<OrderReadDetailVOList> getOrderReadDetailVOList() {
		
		return orderReadDetailVO2;
	}

	public void setOrderReadDetailVOList(List<OrderReadDetailVOList> orderReadDetailVO2) {
		this.orderReadDetailVO2 = orderReadDetailVO2;
	}

	@Override
	public String toString() {
		return "OrderReadDetailVOList2 [orderReadDetailVO2=" + orderReadDetailVO2 + "]";
	}

	
}
