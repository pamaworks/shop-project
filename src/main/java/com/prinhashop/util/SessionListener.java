package com.prinhashop.util;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.context.ApplicationContext;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.web.context.support.WebApplicationContextUtils;


@WebListener
public class SessionListener implements HttpSessionListener {
   
   @Override
   public void sessionCreated(HttpSessionEvent se){

      System.out.println("sessionCreated 호출");
      if(se.getSession().isNew()) {
    	
    	// 세션 객체 참조
    	ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(se.getSession().getServletContext());
    	SqlSessionTemplate session = (SqlSessionTemplate)ctx.getBean("sqlSession");
    	System.out.println("세션 " +session);
          
          try {
	        	 // 전체 방문자 수 +1
	        	 session.insert("com.prinhashop.mappers.visitCountMapper.setVisitTotalCount");
        
	        	 // 오늘 방문자 수
	        	 int todayCount = session.selectOne("com.prinhashop.mappers.visitCountMapper.getVisitTodayCount");
        
	        	 // 전체 방문자 수
	        	 int totalCount = session.selectOne("com.prinhashop.mappers.visitCountMapper.getVisitTotalCount");
	        	 
	        	 HttpSession s = se.getSession();
           
	        	//세션 속성에 담아준다.
	        	s.setAttribute("totalCount", totalCount); // 전체 방문자 수
	        	s.setAttribute("todayCount", todayCount); // 오늘 방문자 수
	        	
          }catch (Exception e) {
           e.printStackTrace();
        }
      }
   }
   
   @Override
   public void sessionDestroyed(HttpSessionEvent se) {

   }
   
}