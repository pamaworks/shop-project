package com.prinhashop.domain;

import java.util.Date;

// 관리자 주문 목록 
public class AdOrderVO {

	private int ord_code;
	private String mem_name;
	private String mem_id;
	private Date ord_regdate;
	private String ord_delivery;
	
	
	public int getOrd_code() {
		return ord_code;
	}
	public void setOrd_code(int ord_code) {
		this.ord_code = ord_code;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
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
		return "AdOrderVO [ord_code=" + ord_code + ", mem_name=" + mem_name + ", mem_id=" + mem_id + ", ord_regdate="
				+ ord_regdate + ", ord_delivery=" + ord_delivery + "]";
	}
	

}
