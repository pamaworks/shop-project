package com.prinhashop.domain;

import java.util.Date;

public class BoardVO {

	/*
    BNO                 NUMBER          PRIMARY KEY,
    MEM_ID              VARCHAR2(15)    NOT NULL,
    BOARD_TITLE         VARCHAR2(100)   NOT NULL,
    BOARD_CONTENT       VARCHAR2(4000)  NOT NULL,
    BOARD_REGDATE       DATE DEFAULT SYSDATE NOT NULL,
    BOARD_VIEWCNT       NUMBER DEFAULT 0 NOT NULL,
    BOARD_REPLYCNT      NUMBER DEFAULT 0,
    FOREIGN KEY(MEM_ID) REFERENCES  MEMBER_TBL(MEM_ID)
    */
	
	private Integer bno;
	private String mem_id;
	private String board_title;
	private String board_content;
	private Date board_regdate;
	private int board_viewcnt;
	private int board_replycnt;
	
	
	public Integer getBno() {
		return bno;
	}
	public void setBno(Integer bno) {
		this.bno = bno;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public Date getBoard_regdate() {
		return board_regdate;
	}
	public void setBoard_regdate(Date board_regdate) {
		this.board_regdate = board_regdate;
	}
	public int getBoard_viewcnt() {
		return board_viewcnt;
	}
	public void setBoard_viewcnt(int board_viewcnt) {
		this.board_viewcnt = board_viewcnt;
	}
	public int getBoard_replycnt() {
		return board_replycnt;
	}
	public void setBoard_replycnt(int board_replycnt) {
		this.board_replycnt = board_replycnt;
	}
	
	
	@Override
	public String toString() {
		return "BoardVO [bno=" + bno + ", mem_id=" + mem_id + ", board_title=" + board_title + ", board_content="
				+ board_content + ", board_regdate=" + board_regdate + ", board_viewcnt=" + board_viewcnt
				+ ", board_replycnt=" + board_replycnt + "]";
	}

	
}
