package com.prinhashop.persistence;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class StatisticsDAOImpl implements StatisticsDAO {

	@Inject
	private SqlSession session;
	
	public final static String NS = "com.prinhashop.mappers.statisticsMapper";

	// 오늘 주문 수
	@Override
	public int todayOrders() throws Exception {
		
		return session.selectOne(NS+".todayOrders");
	}

	// 오늘 회원가입수
	@Override
	public int todayUser() throws Exception {
		
		return session.selectOne(NS+".todayUser");
	}

	// 오늘 문의수
	@Override
	public int todayQna() throws Exception {
		
		return session.selectOne(NS+".todayQna");
	}

	// 오늘 리뷰수
	@Override
	public int todayReview() throws Exception {
		
		return session.selectOne(NS+".todayReview");
	}

	// 날짜별 주문수
	@Override
	public List<Map<String,Object>> getDayOrderList() throws Exception {
		
		return session.selectList(NS+".getDayOrderList");
	}

	// 날짜별 매출금액
	@Override
	public List<Map<String, Object>> getDayRevenueList() throws Exception {
		
		return session.selectList(NS+".getDayRevenueList");
	}
	
}
