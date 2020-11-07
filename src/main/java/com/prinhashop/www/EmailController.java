package com.prinhashop.www;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.prinhashop.dto.EmailDTO;
import com.prinhashop.service.EmailService;

@Controller
@RequestMapping("/email/*")
public class EmailController {
	
	@Inject
	private EmailService emailService;
	
	private static final Logger logger = LoggerFactory.getLogger(EmailController.class);
	
	// ajax 방식 요청으로 이메일 인증 코드 전송 -> /email/send
	@ResponseBody
	@RequestMapping("send")
	public ResponseEntity<String> sendMail(@ModelAttribute EmailDTO dto, Model model, HttpSession session){
		
		logger.info("-- 이메일 인증코드 전송");
		logger.info("-- EmailDTo : "+dto.toString());
		
		ResponseEntity<String> entity=null;
		
		// 6자리 인증코드 생성
		String authcode="";
		for(int i =0;i<6;i++) {
			authcode+=String.valueOf((int)(Math.random()*10));
		}
		
		// 인증코드를 "authcode"라는 이름으로 세션에 저장
		session.setAttribute("authcode", authcode);
		// 세션 유효 시간 : 10분
		// session.setMaxInactiveInterval(60*10);
		
		logger.info("--authcode : "+authcode);
		
		try {
			// EmailDTO에 authcode 인증코드 저장
			emailService.sendMail(dto, authcode);
			entity= new ResponseEntity<String>(HttpStatus.OK);
			
		}catch(Exception e) {
			e.printStackTrace();
			entity=new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
}
