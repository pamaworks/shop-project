package com.prinhashop.service;

import com.prinhashop.domain.AdminVO;
import com.prinhashop.dto.AdminDTO;

public interface AdminService {
	
	// 로그인
	public AdminVO loginMain(AdminDTO dto)throws Exception;
}
