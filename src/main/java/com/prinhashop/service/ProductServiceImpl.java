package com.prinhashop.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.prinhashop.domain.CategoryVO;
import com.prinhashop.domain.ProductVO;
import com.prinhashop.persistence.ProductDAO;
import com.prinhashop.util.SearchCriteria;

@Service
public class ProductServiceImpl implements ProductService {

	@Inject
	private ProductDAO dao;

	// 1차 카테고리 출력
	@Override
	public List<CategoryVO> mainCGList() throws Exception {
		
		return dao.mainCGList();
	}

	// 2차 카테고리 출력
	@Override
	public List<CategoryVO> subCGList(String cate_code) throws Exception {
	
		return dao.subCGList(cate_code);
	}

	// 카테고리 코드에 해당하는 카테고리명 출력
	@Override
	public String getCGName(String cate_code) throws Exception {
		
		return dao.getCGName(cate_code);
	}

	// 해당 카테고리에 해당하는 상품리스트
	@Override
	public List<ProductVO> productListCG(Map map) throws Exception {
		
		return dao.productListCG(map);
	}

	// 해당 카테고리에 해당하는 상품 개수
	@Override
	public int productCount(String cate_code) throws Exception {
		
		return dao.productCount(cate_code);
	}

	// 1차 카테고리에 의한 2차 카테고리의 모든 상품 출력
	@Override
	public List<ProductVO> allProductListCG(Map map) throws Exception {
		
		return dao.allProductListCG(map);
	}

	// 1차 카테고리에 의한 2차 카테고리의 cate_code 가져오기
	@Override
	public String getCGCode(String cate_code) throws Exception {
		
		return dao.getCGCode(cate_code);
	}

	// 카테고리 코드 체크
	@Override
	public int cateCodeCheck(String cate_code) throws Exception {
		
		return dao.cateCodeCheck(cate_code);
	}

	// 1차 카테고리의 All 상품 개수
	@Override
	public int productCountAll(String cate_code) throws Exception {
		
		return dao.productCountAll(cate_code);
	}

	// 2차 카테고리에 의한 1차 카테고리 코드 가져오기
	@Override
	public String mainCGCode(String cate_code) throws Exception {
		
		return dao.mainCGCode(cate_code);
	}

	// 해당 검색 조건에 맞는 상품리스트(페이지에 맞추기)
	@Override
	public List<ProductVO> productListSearch(SearchCriteria cri) throws Exception {
		
		return dao.productListSearch(cri);
	}

	// 해당 검색조건에 해당하는 상품 개수
	@Override
	public int productCountSearch(String keyword) throws Exception {
		
		return dao.productCountSearch(keyword);
	}

	// 상품 상세 정보 읽기(카테고리 선택)
	@Override
	public ProductVO readProduct(int pdt_num) throws Exception {
		
		return dao.readProduct(pdt_num);
	}

}
