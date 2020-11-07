package com.prinhashop.persistence;

import com.prinhashop.domain.AdminVO;
import com.prinhashop.dto.AdminDTO;

public interface AdminDAO {
	
	// 로그인
	public AdminVO loginMain(AdminDTO dto)throws Exception;
	
	// 로그인 시간 업데이트
	public void loginUpdate(String admin_id)throws Exception;
	
}
