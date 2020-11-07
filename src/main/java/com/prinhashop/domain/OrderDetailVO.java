package com.prinhashop.domain;

// 주문 상세 테이블(주문번호+상품코드) : 상품 정보 저장
public class OrderDetailVO {

//    ORD_CODE            NUMBER          NOT NULL REFERENCES ORDER_TBL(ORD_CODE),
//    PDT_NUM             NUMBER          NOT NULL REFERENCES PRODUCT_TBL(PDT_NUM),
//    ORD_AMOUNT          NUMBER          NOT NULL,
//    ORD_PRICE           NUMBER          NOT NULL
	
	private int ord_code;
	private int pdt_num;
	private int ord_amount;
	private int ord_price;
	
	
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
	
	
	@Override
	public String toString() {
		return "OrderDetailVO [ord_code=" + ord_code + ", pdt_num=" + pdt_num + ", ord_amount=" + ord_amount
				+ ", ord_price=" + ord_price + "]";
	}
	
}
