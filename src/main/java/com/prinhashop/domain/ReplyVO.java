package com.prinhashop.domain;

import java.util.Date;

public class ReplyVO {

	/*
	RNO                 NUMBER          PRIMARY KEY,
    BNO                 NUMBER          NOT NULL,
    REPLY_TEXT          VARCHAR2(4000)  NOT NULL,
    REPLYER             VARCHAR2(15)    NOT NULL,  
    REPLY_REGDATE       DATE DEFAULT SYSDATE NOT NULL,
    --REPLY_UPDATE        DATE DEFAULT SYSDATE NOT NULL,
    FOREIGN KEY(BNO) REFERENCES BOARD_TBL(BNO) 
	 */
	
	private Integer rno;
	private Integer bno;
	private String reply_text;
	private String replyer;
	private Date reply_regdate;
	//private Date reply_update;
	
	
	public Integer getRno() {
		return rno;
	}
	public void setRno(Integer rno) {
		this.rno = rno;
	}
	public Integer getBno() {
		return bno;
	}
	public void setBno(Integer bno) {
		this.bno = bno;
	}
	public String getReply_text() {
		return reply_text;
	}
	public void setReply_text(String reply_text) {
		this.reply_text = reply_text;
	}
	public String getReplyer() {
		return replyer;
	}
	public void setReplyer(String replyer) {
		this.replyer = replyer;
	}
	public Date getReply_regdate() {
		return reply_regdate;
	}
	public void setReply_regdate(Date reply_regdate) {
		this.reply_regdate = reply_regdate;
	}
	/*
	public Date getReply_update() {
		return reply_update;
	}
	public void setReply_update(Date reply_update) {
		this.reply_update = reply_update;
	}
	*/
	
	@Override
	public String toString() {
		return "ReplyVO [rno=" + rno + ", bno=" + bno + ", reply_text=" + reply_text + ", replyer=" + replyer
				+ ", reply_regdate=" + reply_regdate + "]";
	}
	
}
