package com.prinhashop.persistence;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.prinhashop.domain.CartProductVO;
import com.prinhashop.domain.CartVO;

@Repository
public class CartDAOImpl implements CartDAO {

	@Inject
	SqlSession session;
	
	public final static String NS="com.prinhashop.mappers.cartMapper";

	// 장바구니에 상품 추가
	@Override
	public void addCart(CartVO vo) throws Exception {

		session.insert(NS+".addCart",vo);
	}

	// 장바구니 삭제
	@Override
	public void deleteCart(int cart_code) throws Exception {

		session.delete(NS+".deleteCart",cart_code);
	}

	// 장바구니 수량 변경
	@Override
	public void updateCart(Map map) throws Exception {

		session.update(NS+".updateCart",map);
	}

	// 장바구니 목록 가져오기
	@Override
	public List<CartProductVO> getCart(String mem_id) throws Exception {
		
		return session.selectList(NS+".getCart",mem_id);
	}

	// 장바구니 삭제(주문완료)
	@Override
	public void deleteCartOrder(Map map) throws Exception {

		session.delete(NS+".deleteCartOrder",map);
	}


}
