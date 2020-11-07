package com.prinhashop.domain;


// 장바구니 테이블
public class CartVO {
	
	
	private int cart_code;
	private int pdt_num;
	private String mem_id;
	private int cart_amount;
	
	
	public int getCart_code() {
		return cart_code;
	}
	public void setCart_code(int cart_code) {
		this.cart_code = cart_code;
	}
	public int getPdt_num() {
		return pdt_num;
	}
	public void setPdt_num(int pdt_num) {
		this.pdt_num = pdt_num;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public int getCart_amount() {
		return cart_amount;
	}
	public void setCart_amount(int cart_amount) {
		this.cart_amount = cart_amount;
	}
	
	
	@Override
	public String toString() {
		return "CartVO [cart_code=" + cart_code + ", pdt_num=" + pdt_num + ", mem_id=" + mem_id + ", cart_amount="
				+ cart_amount + "]";
	}
	
}
