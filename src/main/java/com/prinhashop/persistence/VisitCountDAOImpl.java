//package com.prinhashop.persistence;
//
//import javax.inject.Inject;
//
//import org.apache.ibatis.session.SqlSession;
//import org.springframework.stereotype.Repository;
//
//
//@Repository
//public class VisitCountDAOImpl{
//   
//   private static VisitCountDAOImpl instance; // 정적필드 / 인스턴스 생성 
//   private VisitCountDAOImpl(){} // private 생성자
//   public static VisitCountDAOImpl getInstance(){ // getInstance 메서드 정의
//      
//      if(instance==null) {
//    	 System.out.println("dao객체 널이에요");
//         instance = new VisitCountDAOImpl();
//      }
//      return instance; // instance 객체 리턴
//   }   
//   
//   
//  
//   
//   @Inject
//   private SqlSession session;
//  
//   public final static String NS = "com.prinhashop.mappers.visitCountMapper";
//
//   // 전체 방문자 수 +1
//   public void setVisitTotalCount()throws Exception {
//	  System.out.println("session"+session);
//      session.insert(NS+".setVisitTotalCount");
//   }
//   
//   // 오늘 방문자 수
//   public int getVisitTodayCount()throws Exception{
//      
//      return session.selectOne(NS+".getVisitTodayCount");
//   }
//   
//   // 전체 방문자 수
//   public int getVisitTotalCount()throws Exception{
//      
//      return session.selectOne(NS+".getVisitTotalCount");
//   }
//}