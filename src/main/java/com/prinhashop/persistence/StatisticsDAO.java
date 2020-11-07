package com.prinhashop.persistence;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface StatisticsDAO {

	// 오늘 주문수
	public int todayOrders()throws Exception;
	
	// 오늘 회원가입수
	public int todayUser()throws Exception;
	
	// 오늘 문의수
	public int todayQna()throws Exception;
	
	// 오늘 리뷰수
	public int todayReview()throws Exception;
	
	// 날짜별 주문수
	public List<Map<String,Object>> getDayOrderList()throws Exception;
	
	// 날짜별 매출금액
	public List<Map<String,Object>> getDayRevenueList() throws Exception;
}
