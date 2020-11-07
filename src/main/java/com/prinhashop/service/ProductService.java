package com.prinhashop.service;

import java.util.List;
import java.util.Map;

import com.prinhashop.domain.CategoryVO;
import com.prinhashop.domain.ProductVO;
import com.prinhashop.util.SearchCriteria;

public interface ProductService {

	// 1차 카테고리 출력
	public List<CategoryVO> mainCGList()throws Exception;
	
	// 2차 카테고리 출력
	public List<CategoryVO> subCGList(String cate_code)throws Exception;
	
	// 카테고리 코드에 해당하는 카테고리명 출력
	public String getCGName(String cate_code)throws Exception;
	
	// 해당 카테고리에 해당하는 상품리스트 출력(페이지에 맞춰서)
	public List<ProductVO> productListCG(Map map) throws Exception;
	
	// 해당 카테고리에 해당하는 상품 개수
	public int productCount(String cate_code)throws Exception;
	
	// 1차 카테고리에 의한 2차 카테고리의 모든 상품 출력
	public List<ProductVO> allProductListCG(Map map)throws Exception;

	// 1차 카테고리에 의한 2차 카테고리의 cate_code 가져오기
	public String getCGCode(String cate_code)throws Exception;
	
	// 카테고리 코드 체크
	public int cateCodeCheck(String cate_code)throws Exception;
	
	// 1차 카테고리의 All 상품 개수
	public int productCountAll(String cate_code)throws Exception;
	
	// 2차 카테고리에 의한 1차 카테고리 코드 가져오기
	public String mainCGCode(String cate_code)throws Exception;
	
	// 해당 검색 조건에 맞는 상품리스트(페이지에 맞추기)
	public List<ProductVO> productListSearch(SearchCriteria cri)throws Exception;
	
	// 해당 검색조건에 해당하는 상품 개수
	public int productCountSearch(String keyword)throws Exception;
	
	// 상품 상세 정보 읽기(카테고리 선택)
	public ProductVO readProduct(int pdt_num)throws Exception;
}
