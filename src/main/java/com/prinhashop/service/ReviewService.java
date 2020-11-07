package com.prinhashop.service;

import java.util.List;
import java.util.Map;

import com.prinhashop.domain.ReviewVO;
import com.prinhashop.util.Criteria;

public interface ReviewService {

	// 상품번호에 따른 상품 후기 총 개수
	public int countReview(int pdt_num)throws Exception;
	
	// 상품 후기 등록
	public void writeReview(ReviewVO vo,String mem_id) throws Exception;
	
	// 상품 후기 수정
	public void modifyReview(ReviewVO vo)throws Exception;
	
	// 상품 후기 삭제
	public void deleteReview(int rv_num)throws Exception;
	
	// 상품 후기 리스트(페이지 포함)
	public List<ReviewVO> listReview(int pdt_num,Criteria cri)throws Exception;
}
