package com.prinhashop.service;

import java.util.List;
import java.util.Map;

import com.prinhashop.domain.AdOrderVO;
import com.prinhashop.util.SearchCriteria;

public interface AdOrderService {

	// 회원 주문 목록 (공통)
	public List<AdOrderVO> orderInfo()throws Exception;
	
	// 검색 조건 포함 주문 목록
	public List<AdOrderVO> searchListProduct(SearchCriteria cri) throws Exception;
	
	// 검색조건에 맞는 상품 개수
	public int searchListCount(SearchCriteria cri)throws Exception;
	
	// 배송상태 변경
	public void delivery(Map<String,Object> map)throws Exception;
}
