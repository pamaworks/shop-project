package com.prinhashop.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.prinhashop.domain.AdminVO;
import com.prinhashop.dto.AdminDTO;

@Repository
public class AdminDAOImpl implements AdminDAO {

	@Inject
	private SqlSession session;
	
	public final static String NS = "com.prinhashop.mappers.adminMapper";

	// 로그인
	@Override
	public AdminVO loginMain(AdminDTO dto) throws Exception {
		
		return session.selectOne(NS+".loginMain",dto);
	}

	// 로그인 시간 업데이트
	@Override
	public void loginUpdate(String admin_id) throws Exception {

		session.update(NS+".loginUpdate",admin_id);
	}
}
