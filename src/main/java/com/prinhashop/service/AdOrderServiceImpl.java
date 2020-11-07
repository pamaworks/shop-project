package com.prinhashop.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.prinhashop.domain.AdOrderVO;
import com.prinhashop.persistence.AdOrderDAO;
import com.prinhashop.util.SearchCriteria;

@Service
public class AdOrderServiceImpl implements AdOrderService {

	@Inject
	private AdOrderDAO dao;

	// 회원 주문 목록(공통)
	@Override
	public List<AdOrderVO> orderInfo() throws Exception {
		
		return dao.orderInfo();
	}

	// 검색 조건 포함 주문 리스트
	@Override
	public List<AdOrderVO> searchListProduct(SearchCriteria cri) throws Exception {
		
		return dao.searchListProduct(cri);
	}

	// 검색 조건에 맞는 상품 개수
	@Override
	public int searchListCount(SearchCriteria cri) throws Exception {
		
		return dao.searchListCount(cri);
	}

	// 배송 상태 변경
	@Override
	public void delivery(Map<String,Object> map) throws Exception {

		dao.delivery(map);
	}


}
