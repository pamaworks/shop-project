package com.prinhashop.domain;

import java.util.Date;

// 주문 테이블 : 주문자, 수령인의 정보
// 1(주문테이블) : N(주문상세테이블) 관계 -> 1대 다
public class OrderVO {
	

	private int ord_code;
	private String mem_id;
	private String ord_name;
	private String ord_zipcode;
	private String ord_addr;
	private String ord_addr_d;
	private String ord_phone;
	private int ord_total_price;
	private Date ord_regdate;
	private String ord_delivery;
	
	
	public int getOrd_code() {
		return ord_code;
	}
	public void setOrd_code(int ord_code) {
		this.ord_code = ord_code;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getOrd_name() {
		return ord_name;
	}
	public void setOrd_name(String ord_name) {
		this.ord_name = ord_name;
	}
	public String getOrd_zipcode() {
		return ord_zipcode;
	}
	public void setOrd_zipcode(String ord_zipcode) {
		this.ord_zipcode = ord_zipcode;
	}
	public String getOrd_addr() {
		return ord_addr;
	}
	public void setOrd_addr(String ord_addr) {
		this.ord_addr = ord_addr;
	}
	public String getOrd_addr_d() {
		return ord_addr_d;
	}
	public void setOrd_addr_d(String ord_addr_d) {
		this.ord_addr_d = ord_addr_d;
	}
	public String getOrd_phone() {
		return ord_phone;
	}
	public void setOrd_phone(String ord_phone) {
		this.ord_phone = ord_phone;
	}
	public int getOrd_total_price() {
		return ord_total_price;
	}
	public void setOrd_total_price(int ord_total_price) {
		this.ord_total_price = ord_total_price;
	}
	public Date getOrd_regdate() {
		return ord_regdate;
	}
	public void setOrd_regdate(Date ord_regdate) {
		this.ord_regdate = ord_regdate;
	}
	
	public String getOrd_delivery() {
		return ord_delivery;
	}
	public void setOrd_delivery(String ord_delivery) {
		this.ord_delivery = ord_delivery;
	}
	
	
	@Override
	public String toString() {
		return "OrderVO [ord_code=" + ord_code + ", mem_id=" + mem_id + ", ord_name=" + ord_name + ", ord_zipcode="
				+ ord_zipcode + ", ord_addr=" + ord_addr + ", ord_addr_d=" + ord_addr_d + ", ord_phone=" + ord_phone
				+ ", ord_total_price=" + ord_total_price + ", ord_regdate=" + ord_regdate + ", ord_delivery="
				+ ord_delivery + "]";
	}
	
}
