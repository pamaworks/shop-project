package com.prinhashop.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.prinhashop.domain.CategoryVO;
import com.prinhashop.domain.ProductVO;
import com.prinhashop.util.SearchCriteria;

@Repository
public class ProductDAOImpl implements ProductDAO {

	@Inject
	private SqlSession session;
	public final static String NS = "com.prinhashop.mappers.productMapper";
	
	// 1차 카테고리 출력
	@Override
	public List<CategoryVO> mainCGList() throws Exception {
		
		return session.selectList(NS+".mainCGList");
	}

	// 2차 카테고리 출력
	@Override
	public List<CategoryVO> subCGList(String cate_code) throws Exception {
		
		return session.selectList(NS+".subCGList",cate_code);
	}

	// 카테고리 코드에 해당하는 카테고리명 출력
	@Override
	public String getCGName(String cate_code) throws Exception {
		
		return session.selectOne(NS+".getCGName",cate_code);
	}


	// 해당 카테고리에 해당하는 상품리스트 출력(페이지에 맞춰서)
	@Override
	public List<ProductVO> productListCG(Map map) throws Exception {
		
		return session.selectList(NS+".productListCG",map);
	}

	// 해당 카테고리에 해당하는 상품 개수
	@Override
	public int productCount(String cate_code) throws Exception {
	
		return session.selectOne(NS+".productCount",cate_code);
	}

	// 1차 카테고리에 의한 2차 카테고리의 모든 상품 출력
	@Override
	public List<ProductVO> allProductListCG(Map map) throws Exception {
		
		return session.selectList(NS+".allProductListCG",map);
	}


	// 카테고리 코드 체크
	@Override
	public int cateCodeCheck(String cate_code) throws Exception {
		
		return session.selectOne(NS+".cateCodeCheck",cate_code);
	}

	// 1차 카테고리의 All 상품 개수
	@Override
	public int productCountAll(String cate_code) throws Exception {
		
		return session.selectOne(NS+".productCountAll",cate_code);
	}


	// 해당 검색 조건에 맞는 상품리스트(페이지에 맞추기)
	@Override
	public List<ProductVO> productListSearch(SearchCriteria cri) throws Exception {
		
		return session.selectList(NS+".productListSearch",cri);
	}

	// 해당 검색조건에 해당하는 상품 개수
	@Override
	public int productCountSearch(String keyword) throws Exception {
	
		return session.selectOne(NS+".productCountSearch",keyword);
	}

	
	// 2차 카테고리에 의한 1차 카테고리 코드 가져오기
	@Override
	public String mainCGCode(String cate_code) throws Exception {
		
		return session.selectOne(NS+".mainCGCode",cate_code);
	}
	
	
	// 1차 카테고리에 의한 2차 카테고리의 cate_code 가져오기
	@Override
	public String getCGCode(String cate_code) throws Exception {
		
		return session.selectOne(NS+".getCGCode",cate_code);
	}

	// 상품 상세정보 읽기(카테고리 선택)
	@Override
	public ProductVO readProduct(int pdt_num) throws Exception {
		
		return session.selectOne(NS+".readProduct",pdt_num);
	}

	
	

}
