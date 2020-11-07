package com.prinhashop.persistence;

import java.util.List;
import java.util.Map;

import com.prinhashop.domain.ReviewVO;

public interface ReviewDAO {

	// 상품번호에 따른 상품 후기 총 개수
	public int countReview(int pdt_num)throws Exception;

	// 상품 후기 등록
	public void writeReview(ReviewVO vo)throws Exception;
	
	// 상품 후기 수정
	public void modifyReview(ReviewVO vo)throws Exception;
	
	// 상품 후기 삭제
	public void deleteReview(int rv_num)throws Exception;
	
	// 상품 후기 리스트(페이지 포함)
	public List<ReviewVO> listReview(Map<String, Object> map)throws Exception;
}
