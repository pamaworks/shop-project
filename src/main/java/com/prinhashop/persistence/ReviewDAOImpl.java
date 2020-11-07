package com.prinhashop.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.prinhashop.domain.ReviewVO;

@Repository
public class ReviewDAOImpl implements ReviewDAO {

	@Inject
	private SqlSession session;
	
	public final static String NS = "com.prinhashop.mappers.reviewMapper";

	// 상품번호에 따른 상품 후기 총 개수
	@Override
	public int countReview(int pdt_num) throws Exception {
		
		return session.selectOne(NS+".countReview",pdt_num);
	}

	// 상품 후기 등록
	@Override
	public void writeReview(ReviewVO vo) throws Exception {

		session.insert(NS+".writeReview",vo);
	}

	// 상품 후기 수정
	@Override
	public void modifyReview(ReviewVO vo) throws Exception {

		session.update(NS+".modifyReview",vo);
	}

	// 상품 후기 삭제
	@Override
	public void deleteReview(int rv_num) throws Exception {

		session.delete(NS+".deleteReview",rv_num);
	}

	// 상품 후기 리스트(페이지 포함)
	@Override
	public List<ReviewVO> listReview(Map<String, Object> map) throws Exception {
		
		return session.selectList(NS+".listReview",map);
	}
	
}
