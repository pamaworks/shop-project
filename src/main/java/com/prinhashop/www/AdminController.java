package com.prinhashop.www;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.prinhashop.domain.AdminVO;
import com.prinhashop.dto.AdminDTO;
import com.prinhashop.service.AdminService;
import com.prinhashop.service.StatisticsService;

@Controller
@RequestMapping("/admin/*")
public class AdminController {
	
	@Inject
	private AdminService service;
	
	@Inject
	private StatisticsService staService;
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	// 관리자 메인(로그인 전) 뷰(GET)
	@RequestMapping(value = "/loginMain",method = RequestMethod.GET)
	public String adminMain() {
		return "/admin/loginMain";
	}
	
	// 관리자 메인 페이지(로그인 후) 뷰(GET)
	@RequestMapping(value="/main",method = RequestMethod.GET)
	public void adminLoginMain(Model model)throws Exception{
		
		logger.info("-- 관리자 메인 미니 대쉬보드 로딩");
		
		model.addAttribute("todayOrders",staService.todayOrders()); // 주문
		model.addAttribute("todayUser", staService.todayUser()); // 회원가입
		model.addAttribute("todayQna", staService.todayQna()); // 문의
		model.addAttribute("todayReview", staService.todayReview()); // 리뷰
		
		
		// ----------------- 구글 차트 그래프 
		
		// 1) 날짜별 주문 수
		List<Map<String,Object>> list = staService.getDayOrderList();
		logger.info(list.toString());
		
		String strKey;
		String strValue;
		String result = "";
		
		for(int i =0;i<list.size();i++) {
			
			strKey = list.get(i).get("TO_CHAR(ORD_REGDATE,'YYYY-MM-DD')").toString();
			//System.out.println(strKey);
			
			strValue = list.get(i).get("COUNT(ORD_CODE)").toString();
			//System.out.println(strValue);
			
			result += ",['"+strKey+"', "+strValue+"]";
		}
		
		model.addAttribute("result", result);
		
		
		// 2) 날짜별 매출금액
		List<Map<String,Object>> list2 = staService.getDayRevenueList();
		logger.info(list2.toString());
		
		String strKey2;
		String strValue2;
		String result2 = "";
		
		for(int i =0;i<list2.size();i++) {
			
			strKey2 = list2.get(i).get("TO_CHAR(ORD_REGDATE,'YYYY-MM-DD')").toString();
			//System.out.println(strKey);
			
			strValue2 = list2.get(i).get("SUM(ORD_TOTAL_PRICE)").toString();
			//System.out.println(strValue);
			
			result2 += ",['"+strKey2+"', "+strValue2+"]";
		}
		
		model.addAttribute("result2", result2);
	}
	
	
	// 관리자 로그인 폼 전송(POST) 
	@RequestMapping(value = "/main",method = RequestMethod.POST)
	public String loginPost(AdminDTO dto, 
							RedirectAttributes rttr, 
							HttpSession session)throws Exception{
		
		String msg="";
		
		logger.info("-- 관리자 로그인");
		logger.info("AdminDTO : "+dto.toString());
		
		AdminVO vo=null;
		
		vo=service.loginMain(dto); // 로그인 시간 업데이트 기능 같이 있음
	
		if(vo!=null) { // 로그인 성공
			
			logger.info("로그인성공");

			// 세션처리 -> 관리자와 사용자의 key를 다르게 사용해야한다
			session.setAttribute("admin", vo);
			msg="ADMIN_LOGIN_SUCCESS";
			
		}else{ // 로그인 실패
			msg="ADMIN_LOGIN_FAIL";
			rttr.addFlashAttribute("msg",msg);
			return "redirect:/admin/loginMain";
		}
		rttr.addFlashAttribute("msg",msg);
		return "redirect:/admin/main";
	}
	
	
	// 관리자 로그아웃(GET) 
	@RequestMapping(value = "/logout",method = RequestMethod.GET)
	public String logout(HttpSession session, RedirectAttributes rttr) {
		
		logger.info("-- 관리자 로그아웃");
		
		session.invalidate();
		rttr.addFlashAttribute("msg", "ADMIN_LOGOUT_SUCCESS");
		
		return "redirect:/admin/loginMain";
	}
	
}


