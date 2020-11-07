package com.prinhashop.service;

import javax.inject.Inject;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.prinhashop.domain.AdminVO;
import com.prinhashop.dto.AdminDTO;
import com.prinhashop.persistence.AdminDAO;

@Service
public class AdminServiceImpl implements AdminService {

	@Inject
	private AdminDAO dao;
	
	// spring-security.xml  BCryptPasswordEncoder클래스가 bean객체
	@Inject
	private BCryptPasswordEncoder passwdEncrypt;

	// 로그인
	@Override
	public AdminVO loginMain(AdminDTO dto) throws Exception {
		
		AdminVO vo = dao.loginMain(dto);

		// 로그인 정보와 일치하는 값이 존재하면 로그인 실행
		if(vo!=null) {
			
			// 비밀번호가 암호화 된 비밀번호와 일치하는지 확인
			// 사용자와 관리자 로그인 같은 컴퓨터 안됨 -> 잠시 주석 처리
			/*
			if(passwdEncrypt.matches(dto.getAdmin_pw(), vo.getAdmin_pw())) {
				dao.loginUpdate(dto);
			} else { 
			// 비밀번호가 일치하지 않으면, null 반환
				vo = null;
			}
			*/
		
			// 로그인 시간 업데이트
			dao.loginUpdate(dto.getAdmin_id());
		}
		
		return vo;
	}
	
}
