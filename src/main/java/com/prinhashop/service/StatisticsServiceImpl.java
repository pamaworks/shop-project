package com.prinhashop.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.prinhashop.persistence.StatisticsDAO;

@Service
public class StatisticsServiceImpl implements StatisticsService {

	@Inject
	private StatisticsDAO dao;

	// 오늘 주문 수
	@Override
	public int todayOrders() throws Exception {
	
		return dao.todayOrders();
	}

	// 오늘 회원가입수
	@Override
	public int todayUser() throws Exception {
		
		return dao.todayUser();
	}

	// 오늘 문의수
	@Override
	public int todayQna() throws Exception {
		
		return dao.todayQna();
	}

	// 오늘 리뷰수
	@Override
	public int todayReview() throws Exception {
		
		return dao.todayReview();
	}

	// 날짜별 주문수
	@Override
	public List<Map<String,Object>> getDayOrderList() throws Exception {
	
		return dao.getDayOrderList();
	}

	// 날짜별 매출 금액
	@Override
	public List<Map<String, Object>> getDayRevenueList() throws Exception {
	
		return dao.getDayRevenueList();
	}
}
