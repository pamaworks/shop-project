package com.prinhashop.service;

import java.util.List;
import java.util.Map;

import com.prinhashop.domain.CategoryVO;
import com.prinhashop.domain.ProductVO;
import com.prinhashop.util.SearchCriteria;

public interface AdProductService {

	// 1차 카테고리 출력
	public List<CategoryVO> mainCGList()throws Exception;
	
	// 1차 카테고리에 따른 2차 카테고리 출력
	public List<CategoryVO> subCGList(String cate_code)throws Exception;
	
	// 상품 등록
	public void insertProduct(ProductVO vo) throws Exception;
	
	// 상품 리스트
	public List<ProductVO> searchListProduct(SearchCriteria cri)throws Exception;
	
	// 검색 조건에 맞는 상품 개수
	public int searchListCount(SearchCriteria cri)throws Exception;
	
	// 상품 상세 정보 읽기
	public ProductVO productRead(int pdt_num)throws Exception;
	
	// 상품 수정
	public void productEdit(ProductVO vo) throws Exception;
	
	// 상품 삭제
	public void productDelete(int pdt_num) throws Exception;
	
	// 선택 상품 수정
	public void editChecked(Map<String,Object> map) throws Exception;
	
}
