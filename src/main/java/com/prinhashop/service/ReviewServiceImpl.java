package com.prinhashop.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.prinhashop.domain.ReviewVO;
import com.prinhashop.persistence.ReviewDAO;
import com.prinhashop.util.Criteria;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Inject
	private ReviewDAO dao;

	// 상품번호에 따른 상품 후기 총 개수
	@Override
	public int countReview(int pdt_num) throws Exception {
		
		return dao.countReview(pdt_num);
	}

	// 상품 후기 등록
	@Override
	public void writeReview(ReviewVO vo,String mem_id) throws Exception {
		vo.setMem_id(mem_id);
		dao.writeReview(vo);
	}

	// 상품 후기 수정
	@Override
	public void modifyReview(ReviewVO vo) throws Exception {
		
		dao.modifyReview(vo);
	}

	// 상품 후기 삭제
	@Override
	public void deleteReview(int rv_num) throws Exception {

		dao.deleteReview(rv_num);
	}

	// 상품 후기 리스트(페이지 포함)
	@Override
	public List<ReviewVO> listReview(int pdt_num, Criteria cri) throws Exception {

		Map<String,Object> map = new HashMap<>();
		
		map.put("pdt_num",pdt_num);
		map.put("cri", cri);
		
		return dao.listReview(map);
	}

}
