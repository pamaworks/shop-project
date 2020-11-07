package com.prinhashop.domain;

public class OrderReadDetailVO {

	private int pdt_num;
	private String pdt_name;
	private String pdt_img;
	private int pdt_price;
	private int ord_price;
	private int ord_amount;
	
	
	public int getPdt_num() {
		return pdt_num;
	}
	public void setPdt_num(int pdt_num) {
		this.pdt_num = pdt_num;
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
	public int getPdt_price() {
		return pdt_price;
	}
	public void setPdt_price(int pdt_price) {
		this.pdt_price = pdt_price;
	}
	public int getOrd_price() {
		return ord_price;
	}
	public void setOrd_price(int ord_price) {
		this.ord_price = ord_price;
	}
	public int getOrd_amount() {
		return ord_amount;
	}
	public void setOrd_amount(int ord_amount) {
		this.ord_amount = ord_amount;
	}
	
	
	@Override
	public String toString() {
		return "OrderReadDetailVO [pdt_num=" + pdt_num + ", pdt_name=" + pdt_name + ", pdt_img=" + pdt_img
				+ ", pdt_price=" + pdt_price + ", ord_price=" + ord_price + ", ord_amount=" + ord_amount + "]";
	}
	
}
