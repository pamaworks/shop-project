package com.prinhashop.service;

import java.util.Date;

import javax.inject.Inject;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.prinhashop.domain.MemberVO;
import com.prinhashop.dto.MemberDTO;
import com.prinhashop.persistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO dao;
	
	@Inject
	private BCryptPasswordEncoder crptPassEnc;
	
	// 아이디 중복 체크
	@Override
	public String checkIdJoin(String mem_id) throws Exception {
		return dao.checkIdJoin(mem_id);
	}

	// 회원가입
	@Override
	public void join(MemberVO vo) throws Exception {
		dao.join(vo);
	}

	// 로그인
	@Override
	@Transactional
	public MemberDTO login(MemberDTO dto) throws Exception {
		
		// 1) Transactional
		// 아이디 파라미터만 사용하여(비밀번호 X) 해당 아이디에 맞는 MemberDTO 회원 정보를 dao로 부터 가져옴
		// 암호화된 비밀번호가 담겨있음
		MemberDTO mDTO = dao.login(dto);
		
		if(mDTO!=null) { // 사용자가 입력한 아이디에 맞는 회원 정보가 있을 때(없으면 null값)
			
			// 사용자가 입력한 비밀번호와 암호화된 비밀번호가 일치하는지 확인
			// crptPassEnc.matches(일반비밀번호, 암호화된 비밀번호)
			// dto(일반비밀번호), mDTO(암호화된 비밀번호)
			if(crptPassEnc.matches(dto.getMem_pw(), mDTO.getMem_pw())) {
				// true = 비밀번호 일치
				
				// 2) Transactional
				// 로그인 시간 저장
				dao.loginUpdate(mDTO.getMem_id());
				
			}else {
				// 비밀번호 불일치 null 반환
				mDTO=null;
			}
		}
		
		return mDTO;
	}

	// MemberVO 가져오기
	@Override
	public MemberVO userInfo(String mem_id) throws Exception {
	
		return dao.userInfo(mem_id);
	}

	// 회원정보수정
	@Override
	public void modify(MemberVO vo) throws Exception {
		
		dao.modify(vo);
	}

	// 비밀번호변경
	@Override
	public void changePW(MemberDTO dto) throws Exception {
		
		dao.changePW(dto);
	}

	// 회원탈퇴
	@Override
	public void withdrawal(String mem_id) throws Exception {
		dao.withdrawal(mem_id);
	}

	// 자동로그인 체크한 경우에 사용자 테이블에 세션과 유효시간을 저장하기 위한 메서드
	@Override
	public void keepLogin(String mem_id, String sessionId, Date next) {
		
		dao.keepLogin(mem_id, sessionId, next);
	}

	// 이전에 로그인한 적이 있는지, 즉 유효시간이 넘지 않은 세션을 가지고 있는지 체크한다.
	@Override
	public MemberDTO checkUserWithSessionKey(String sessionId) {
		
		return dao.checkUserWithSessionKey(sessionId);
	}

	
}
