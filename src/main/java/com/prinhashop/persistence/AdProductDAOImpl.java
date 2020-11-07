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
public class AdProductDAOImpl implements AdProductDAO {

	@Inject
	SqlSession session;
	
	public final static String NS="com.prinhashop.mappers.adProductMapper";

	// 1차 카테고리 출력
	@Override
	public List<CategoryVO> mainCGList() throws Exception {

		return session.selectList(NS+".mainCGList");
	}

	// 1차 카테고리에 따른 2차 카테고리 출력
	@Override
	public List<CategoryVO> subCGList(String cate_code) throws Exception {

		return session.selectList(NS+".subCGList",cate_code);
	}

	// 상품 등록
	@Override
	public void insertProduct(ProductVO vo) throws Exception {
		
		session.insert(NS+".insertProduct",vo);
	}

	// 상품 리스트
	@Override
	public List<ProductVO> searchListProduct(SearchCriteria cri) throws Exception {
		
		return session.selectList(NS+".searchListProduct",cri);
	}

	// 검색 조건에 맞는 상품 개수
	@Override
	public int searchListCount(SearchCriteria cri) throws Exception {
		
		return session.selectOne(NS+".searchListCount",cri);
	}

	// 상품 상세 정보 읽기
	@Override
	public ProductVO productRead(int pdt_num) throws Exception {
		
		return session.selectOne(NS+".productRead",pdt_num);
	}

	// 상품 수정
	@Override
	public void productEdit(ProductVO vo) throws Exception {
		
		session.update(NS+".productEdit",vo);
	}

	// 상품 삭제
	@Override
	public void productDelete(int pdt_num) throws Exception {

		session.delete(NS+".productDelete",pdt_num);
	}

	// 선택 상품 수정
	@Override
	public void editChecked(Map<String, Object> map) throws Exception {

		session.update(NS+".editChecked",map);
		//System.out.println("dao"+map.toString());
	}
	
}
