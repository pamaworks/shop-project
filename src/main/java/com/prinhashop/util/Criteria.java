package com.prinhashop.util;

public class Criteria {

	// 페이징 기능에서 페이지 번호 출력을 위한 부분
	private int page; // 현재 페이지(클릭한 페이지 번호)
	private int perPageNum; // 한 페이지당 게시물 개수
	
	// mapper 페이징 sql문에서 사용
	private int rowStart; // 행시작
	private int rowEnd; // 행끝

	public Criteria() {
		this.page=1; // 현재 페이지 번호
		this.perPageNum=6; // 게시물 개수
	}
	
	public void setPage(int page) {
		if(page<=0) {
			this.page=1;
			return;
		}
		this.page=page;
	}
	
	public void setPerPageNum(int perPageNum) {
		if(perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum=10;
			return;
		}
		this.perPageNum=perPageNum;
	}
	
	public int getPage() {
		return page;
	}
	
	public int getPageStart() {
		return(this.page-1)*perPageNum;
	}
	
	public int getPerPageNum() {
		return this.perPageNum;
	}
	
	// mapper파일, 페이징 기능 쿼리에서 호출됨
	public int getRowStart() {
		return ((page-1)*perPageNum)+1;
	}
	
	// mapper파일, 페이징 기능 쿼리에서 호출됨
	public int getRowEnd() {
		return getRowStart()+perPageNum-1;
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + ", rowStart=" + rowStart + ", rowEnd=" + rowEnd
				+ "]";
	}
	
	
}
