package com.prinhashop.domain;

import java.util.Date;

public class OrderListVO {

	private String pdt_name;
	private String pdt_img;
	private int ord_code;
	private int pdt_num;
	private int ord_amount;
	private int ord_price;
	private Date ord_regdate;
	private String ord_delivery;
	
	
	public String getOrd_delivery() {
		return ord_delivery;
	}
	public void setOrd_delivery(String ord_delivery) {
		this.ord_delivery = ord_delivery;
	}
	public String getPdt_name() {
		return pdt_name;
	}
	public void setPdt_name(String pdt_name) {
		this.pdt_name = pdt_name;
	}
	public String getPdt_img() {
		return pdt_img;
	}
	public void setPdt_img(String pdt_img) {
		this.pdt_img = pdt_img;
	}
	public int getOrd_code() {
		return ord_code;
	}
	public void setOrd_code(int ord_code) {
		this.ord_code = ord_code;
	}
	public int getPdt_num() {
		return pdt_num;
	}
	public void setPdt_num(int pdt_num) {
		this.pdt_num = pdt_num;
	}
	public int getOrd_amount() {
		return ord_amount;
	}
	public void setOrd_amount(int ord_amount) {
		this.ord_amount = ord_amount;
	}
	public int getOrd_price() {
		return ord_price;
	}
	public void setOrd_price(int ord_price) {
		this.ord_price = ord_price;
	}
	public Date getOrd_regdate() {
		return ord_regdate;
	}
	public void setOrd_regdate(Date ord_regdate) {
		this.ord_regdate = ord_regdate;
	}
	
	
	@Override
	public String toString() {
		return "OrderListVO [pdt_name=" + pdt_name + ", pdt_img=" + pdt_img + ", ord_code=" + ord_code + ", pdt_num="
				+ pdt_num + ", ord_amount=" + ord_amount + ", ord_price=" + ord_price + ", ord_regdate=" + ord_regdate
				+ ", ord_delivery=" + ord_delivery + "]";
	}
	
}
