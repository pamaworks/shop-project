package com.prinhashop.persistence;

import java.util.Date;

import com.prinhashop.domain.MemberVO;
import com.prinhashop.dto.MemberDTO;

public interface MemberDAO {

	// 아이디 중복 체크
	public String checkIdJoin(String mem_id) throws Exception;
	
	// 회원가입
	public void join(MemberVO vo) throws Exception;
	
	// 로그인
	public MemberDTO login(MemberDTO dto) throws Exception;
	
	// 마지막 로그인 시간 업데이트
	public void loginUpdate(String mem_id)throws Exception;
	
	// MemberVO 가져오기 
	public MemberVO userInfo(String mem_id)throws Exception;
	
	// 회원정보 수정
	public void modify(MemberVO vo)throws Exception;
	
	// 비밀번호변경
	public void changePW(MemberDTO dto) throws Exception;
	
	// 회원탈퇴
	public void withdrawal(String mem_id)throws Exception;
	
	// 자동로그인 체크한 경우에 사용자 테이블에 세션과 유효시간을 저장하기 위한 메서드
	public void keepLogin(String mem_id, String sessionId, Date next);
	     
	// 이전에 로그인한 적이 있는지, 즉 유효시간이 넘지 않은 세션을 가지고 있는지 체크한다.
	public MemberDTO checkUserWithSessionKey(String sessionId);
	
}
