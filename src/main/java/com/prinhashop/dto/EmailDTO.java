package com.prinhashop.dto;

public class EmailDTO {
	
	// 이메일 전송에 필요한 DTO 설정 -> MemberVO에서 가져오기
	// mem_email : 수신자 이메일 주소(사용자가 입력)
	
	private String senderName; // 발신자 이름
	private String senderMail; // 발신자 이메일 주소
	private String receiveMail; // 수신자 이메일 주소
	private String subject; // 제목
	private String message; // 내용
	 
	// 인증 코드 전송을 위한 기본 세팅(수신자 메일 주소 제외)
	public EmailDTO() {
		this.senderName="prinha";
		this.senderMail="prinha";
		this.subject="prinha 회원 가입 인증 코드입니다.";
		this.message="아래의 인증코드를 이메일 인증코드란에 입력하세요. \n\n인증코드: ";
	}

	public String getSenderName() {
		return senderName;
	}

	public void setSenderName(String senderName) {
		this.senderName = senderName;
	}

	public String getSenderMail() {
		return senderMail;
	}

	public void setSenderMail(String senderMail) {
		this.senderMail = senderMail;
	}

	public String getReceiveMail() {
		return receiveMail;
	}

	public void setReceiveMail(String receiveMail) {
		this.receiveMail = receiveMail;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	@Override
	public String toString() {
		return "EmailDTO [senderName=" + senderName + ", senderMail=" + senderMail + ", receiveMail=" + receiveMail
				+ ", subject=" + subject + ", message=" + message + "]";
	}
	
}
