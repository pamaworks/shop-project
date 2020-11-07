package com.prinhashop.dto;

import java.util.Date;

// 로그인 전용 DTO
public class MemberDTO {

	private String mem_id;
	private String mem_pw;
	private String mem_origin_pw; // 암호화하지않은 임시 비밀번호
	private String mem_nick;
	private String mem_name;
	private String mem_point;
	private Date mem_last_login;
	//private boolean isUseCookie; // 로그인페이지  <input type="checkbox" name="useCookie" />
	
	private int isUseCookie;
	
	
	public int getIsUseCookie() {
		return isUseCookie;
	}
	public void setIsUseCookie(int isUseCookie) {
		this.isUseCookie = isUseCookie;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getMem_pw() {
		return mem_pw;
	}
	public void setMem_pw(String mem_pw) {
		this.mem_pw = mem_pw;
	}
	public String getMem_nick() {
		return mem_nick;
	}
	public void setMem_nick(String mem_nick) {
		this.mem_nick = mem_nick;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getMem_point() {
		return mem_point;
	}
	public void setMem_point(String mem_point) {
		this.mem_point = mem_point;
	}
	public Date getMem_last_login() {
		return mem_last_login;
	}
	public void setMem_last_login(Date mem_last_login) {
		this.mem_last_login = mem_last_login;
	}

	public String getMem_origin_pw() {
		return mem_origin_pw;
	}
	public void setMem_origin_pw(String mem_origin_pw) {
		this.mem_origin_pw = mem_origin_pw;
	}
	
	@Override
	public String toString() {
		return "MemberDTO [mem_id=" + mem_id + ", mem_pw=" + mem_pw + ", mem_origin_pw=" + mem_origin_pw + ", mem_nick="
				+ mem_nick + ", mem_name=" + mem_name + ", mem_point=" + mem_point + ", mem_last_login="
				+ mem_last_login + ", isUseCookie=" + isUseCookie + "]";
	}
	
}
