package com.prinhashop.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.prinhashop.domain.BoardVO;
import com.prinhashop.persistence.BoardDAO;
import com.prinhashop.util.SearchCriteria;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO dao;

	// 목록 검색 기능
	@Override
	public List<BoardVO> listSearchCriteria(SearchCriteria cri) throws Exception {
		
		return dao.listSearchCriteria(cri);
	}

	// 목록 검색 카운트 기능
	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
	
		return dao.listSearchCount(cri);
	}
	
	// 데이터 읽어오기 / 읽기, 수정 페이지
	@Transactional(isolation=Isolation.READ_COMMITTED)
	@Override
	public BoardVO read(int bno) throws Exception {
		dao.viwecntUpdate(bno);
		return dao.read(bno);
	}

	// 데이터 삭제
	@Override
	public void delete(Integer bno) throws Exception {

		dao.delete(bno);
	}

	// 조회수 업데이트
	@Override
	public void viwecntUpdate(Integer bno) throws Exception {

		dao.viwecntUpdate(bno);
	}

	// 게시물 등록
	@Override
	public void register(BoardVO vo) throws Exception {

		dao.register(vo);
	}

	// 게시물 수정
	@Override
	public void modify(BoardVO vo) throws Exception {

		dao.modify(vo);
	}

	// 댓글 수 업데이트
	@Override
	public void updateReplyCnt(Integer bno, int amount) throws Exception {

		dao.updateReplyCnt(bno, amount);
	}

	
}
