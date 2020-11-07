package com.prinhashop.service;

import java.util.List;

import com.prinhashop.domain.BoardVO;
import com.prinhashop.util.SearchCriteria;

public interface BoardService {

	// 목록 검색 기능
	public List<BoardVO> listSearchCriteria(SearchCriteria cri)throws Exception;
	
	// 목록 검색 카운트 기능
	public int listSearchCount(SearchCriteria cri) throws Exception;
	
	// 데이터 읽어오기 / 읽기, 수정 페이지
	public BoardVO read(int bno)throws Exception;
	
	// 데이터 삭제
	public void delete(Integer bno)throws Exception;
	
	// 조회수 업데이트
	public void viwecntUpdate(Integer bno)throws Exception;
	
	// 게시물 등록
	public void register(BoardVO vo)throws Exception;
	
	// 게시물 수정
	public void modify(BoardVO vo)throws Exception;
	
	// 댓글 수 업데이트
	public void updateReplyCnt(Integer bno, int amount) throws Exception;
}
