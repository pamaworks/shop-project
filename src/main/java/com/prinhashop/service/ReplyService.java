package com.prinhashop.service;

import java.util.List;

import com.prinhashop.domain.ReplyVO;
import com.prinhashop.util.Criteria;

public interface ReplyService {

	// 댓글 추가
	public void addReply(ReplyVO vo)throws Exception;
	
	// 댓글 리스트
	public List<ReplyVO> list(Integer bno)throws Exception;
	
	// 댓글 수정
	public void modify(ReplyVO vo)throws Exception;
	
	// 댓글 삭제
	public void delete(Integer rno)throws Exception;
	
	// 페이징을 포함한 댓글 리스트
	public List<ReplyVO> listPage(Integer bno, Criteria cri)throws Exception;

	// 글번호 별 댓글 개수
	public int count(Integer bno) throws Exception;
}
