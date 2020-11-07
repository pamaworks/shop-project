package com.prinhashop.service;

import com.prinhashop.dto.EmailDTO;

public interface EmailService {

	public void sendMail(EmailDTO dto, String authcode);
	
}
