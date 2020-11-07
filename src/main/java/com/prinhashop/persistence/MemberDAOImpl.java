package com.prinhashop.persistence;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.prinhashop.domain.MemberVO;
import com.prinhashop.dto.MemberDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Inject
	private SqlSession session;
	public final static String NS = "com.prinhashop.mappers.memberMapper";
	
	// 아이디 중복 체크
	@Override
	public String checkIdJoin(String mem_id) throws Exception {
		
		return session.selectOne(NS+".checkIdJoin",mem_id);
	}

	// 회원가입
	@Override
	public void join(MemberVO vo) throws Exception {
		
		session.insert(NS+".join",vo);
	}

	// 로그인
	@Override
	public MemberDTO login(MemberDTO dto) throws Exception {
		
		return session.selectOne(NS+".login",dto);
	}

	// 로그인 시간 업데이트
	@Override
	public void loginUpdate(String mem_id) throws Exception {
		session.update(NS+".loginUpdate",mem_id);		
	}
	
	// MemberVO 가져오기 
	@Override
	public MemberVO userInfo(String mem_id) throws Exception {
		
		return session.selectOne(NS+".userInfo",mem_id);
	}

	// 회원 정보 수정
	@Override
	public void modify(MemberVO vo) throws Exception {
		session.update(NS+".modify",vo);
	}

	// 비밀번호변경
	@Override
	public void changePW(MemberDTO dto) throws Exception {
		session.update(NS+".changePW",dto);
	}

	// 회원탈퇴
	@Override
	public void withdrawal(String mem_id) throws Exception {
		session.update(NS+".withdrawal",mem_id);
	}

	// 자동로그인 체크한 경우에 사용자 테이블에 세션과 유효시간을 저장하기 위한 메서드
	@Override
	public void keepLogin(String mem_id, String sessionId, Date next) {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mem_id", mem_id);
		map.put("sessionId", sessionId);
		map.put("next",next);
		
		session.update(NS+".keepLogin",map);
	}

	// 이전에 로그인한 적이 있는지, 즉 유효시간이 넘지 않은 세션을 가지고 있는지 체크한다.
	@Override
	public MemberDTO checkUserWithSessionKey(String sessionId) {
		
		return session.selectOne(NS+".checkUserWithSessionKey",sessionId);
	}
	
}
