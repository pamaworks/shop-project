package com.prinhashop.domain;

import java.util.List;

// OrderReadDetailVOList를 리스트로 만드는 VO
public class OrderReadDetailVOList {
	
	// OrderReadDetailVO 10개를 1개의 리스트로 만들기
	private List<OrderReadDetailVO> orderReadDetailVO;

	public List<OrderReadDetailVO> getOrderReadDetailVO() {
		return orderReadDetailVO;
	}

	public void setOrderReadDetailVO(List<OrderReadDetailVO> orderReadDetailVO) {
		this.orderReadDetailVO = orderReadDetailVO;
	}

	@Override
	public String toString() {
		return "OrderReadDetailVOList [orderReadDetailVO=" + orderReadDetailVO + "]";
	}

	
	
	
}
