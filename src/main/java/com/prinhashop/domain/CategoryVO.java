package com.prinhashop.domain;

// 카테고리 테이블
public class CategoryVO {
	
	private String cate_code;
	private String cate_code_prt;
	private String cate_name;
	
	
	public String getCate_code() {
		return cate_code;
	}
	public void setCate_code(String cate_code) {
		this.cate_code = cate_code;
	}
	public String getCate_code_prt() {
		return cate_code_prt;
	}
	public void setCate_code_prt(String cate_code_prt) {
		this.cate_code_prt = cate_code_prt;
	}
	public String getCate_name() {
		return cate_name;
	}
	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}
	
	
	@Override
	public String toString() {
		return "CategoryVO [cate_code=" + cate_code + ", cate_code_prt=" + cate_code_prt + ", cate_name=" + cate_name
				+ "]";
	}
	
}
