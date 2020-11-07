package com.prinhashop.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.prinhashop.domain.CategoryVO;
import com.prinhashop.domain.ProductVO;
import com.prinhashop.persistence.AdProductDAO;
import com.prinhashop.util.SearchCriteria;

@Service
public class AdProductServiceImpl implements AdProductService {

	@Inject
	AdProductDAO dao;

	// 1차 카테고리 출력
	@Override
	public List<CategoryVO> mainCGList() throws Exception {
		
		return dao.mainCGList();
	}

	// 1차 카테고리에 따른 2차 카테고리 출력
	@Override
	public List<CategoryVO> subCGList(String cate_code) throws Exception {
		
		return dao.subCGList(cate_code);
	}
	
	// 상품 등록
	@Override
	public void insertProduct(ProductVO vo) throws Exception {
		
		dao.insertProduct(vo);
	}

	// 상품 리스트
	@Override
	public List<ProductVO> searchListProduct(SearchCriteria cri) throws Exception {
		
		return dao.searchListProduct(cri);
	}

	// 검색 조건에 맞는 상품 개수
	@Override
	public int searchListCount(SearchCriteria cri) throws Exception {
		
		return dao.searchListCount(cri);
	}

	// 상품 상세 정보 읽기
	@Override
	public ProductVO productRead(int pdt_num) throws Exception {
		
		return dao.productRead(pdt_num);
	}

	// 상품 수정
	@Override
	public void productEdit(ProductVO vo) throws Exception {
		
		dao.productEdit(vo);
	}

	// 상품 사제
	@Override
	public void productDelete(int pdt_num) throws Exception {

		dao.productDelete(pdt_num);
	}

	// 선택 상품 수정
	@Override
	public void editChecked(Map<String, Object> map) throws Exception {

		dao.editChecked(map);
	}
}
