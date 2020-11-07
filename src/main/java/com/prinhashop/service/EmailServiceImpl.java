package com.prinhashop.service;

import javax.inject.Inject;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.prinhashop.dto.EmailDTO;

@Service
public class EmailServiceImpl implements EmailService {

	// DB작업이 필요없어서 관련 작업이 없음
	
	@Inject
	JavaMailSender mailSender;// root-context.xml에 bean 객체 설정
	
	
	// 이메일 인증코드 발송 메소드
	@Override
	public void sendMail(EmailDTO dto, String authcode) {
		
		MimeMessage msg = mailSender.createMimeMessage();
		
		try {
			// EmailDTO참고 -> 수신자 메일주소 빼고 모두 미리 세팅
			
			// 수신자 이메일 주소
			msg.addRecipient(RecipientType.TO, new InternetAddress(dto.getReceiveMail()));
			
			// 빌산자 이메일, 이름 
			msg.addFrom(new InternetAddress[] {new InternetAddress(dto.getSenderMail(), dto.getSenderName())});
			
			// 이메일 제목
			msg.setSubject(dto.getSubject(),"utf-8");
			
			// 이메일 본문
			msg.setText(dto.getMessage()+authcode,"utf-8");
			
			// 메일보내기
			mailSender.send(msg);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
	}

}
