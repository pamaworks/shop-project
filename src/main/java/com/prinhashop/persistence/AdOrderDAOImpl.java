package com.prinhashop.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.prinhashop.domain.AdOrderVO;
import com.prinhashop.util.SearchCriteria;

@Repository
public class AdOrderDAOImpl implements AdOrderDAO {

	@Inject
	private SqlSession session;
	
	public final static String NS = "com.prinhashop.mappers.adOrderMapper";

	// 회원 주문 목록(공통)
	@Override
	public List<AdOrderVO> orderInfo() throws Exception {
		
		return session.selectList(NS+".orderInfo");
	}

	// 검색 조건 포함 주문 목록
	@Override
	public List<AdOrderVO> searchListProduct(SearchCriteria cri) throws Exception {
	
	
		return session.selectList(NS+".searchListProduct",cri);
	}

	// 검색 조건에 맞는 상품 개수
	@Override
	public int searchListCount(SearchCriteria cri) throws Exception {
		
		return session.selectOne(NS+".searchListCount",cri);
	}

	// 배송상태변경
	@Override
	public void delivery(Map<String,Object> map) throws Exception {

		session.update(NS+".delivery",map);
	}

}
