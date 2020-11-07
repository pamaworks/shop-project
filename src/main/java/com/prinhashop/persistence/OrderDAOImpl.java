package com.prinhashop.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.prinhashop.domain.OrderDetailVO;
import com.prinhashop.domain.OrderListVO;
import com.prinhashop.domain.OrderReadDetailVO;
import com.prinhashop.domain.OrderVO;

@Repository
public class OrderDAOImpl implements OrderDAO {

	@Inject
	private SqlSession session;

	public final static String NS = "com.prinhashop.mappers.orderMapper";

	// 핸드폰번호 가져오기
	@Override
	public String buyPhoneCheck(String mem_id) throws Exception {
		
		return session.selectOne(NS+".buyPhoneCheck",mem_id);
	}

	// 주문코드 시퀀스 가져오기
	@Override
	public int readOrderCode() throws Exception {

		return session.selectOne(NS+".readOrderCode");
	}

	// 주문 내역 추가
	@Override
	public void addOrderDetail(OrderDetailVO vo) throws Exception {

		session.insert(NS+".addOrderDetail",vo);
	}

	// 주문 정보 추가
	@Override
	public void addOrder(OrderVO vo) throws Exception {

		session.insert(NS+".addOrder",vo);
	}

	// 주문 목록 / 주문 조회
	@Override
	public List<OrderListVO> orderList(String mem_id) throws Exception {
		
		return session.selectList(NS+".orderList",mem_id);
	}

	// 주문 상세 정보
	@Override
	public List<OrderReadDetailVO> readOrder(int ord_code) throws Exception {
		
		return session.selectList(NS+".readOrder",ord_code);
	}

	// 주문자 정보
	@Override
	public OrderVO getOrder(int ord_code) throws Exception {
		
		return session.selectOne(NS+".getOrder",ord_code);
	}
	
	
	
	
}
