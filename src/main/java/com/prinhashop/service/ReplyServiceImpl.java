package com.prinhashop.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.prinhashop.domain.ReplyVO;
import com.prinhashop.persistence.BoardDAO;
import com.prinhashop.persistence.ReplyDAO;
import com.prinhashop.util.Criteria;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Inject
	private ReplyDAO dao;

	@Inject
	private BoardDAO boardDAO;

	// 댓글  추가
	@Transactional
	@Override
	public void addReply(ReplyVO vo) throws Exception {

		dao.addReply(vo); // 1. 댓글 추가
		boardDAO.updateReplyCnt(vo.getBno(), 1); // 부모글 정보와 댓글 개수 1개 업데이트
	}

	// 댓글 리스트
	@Override
	public List<ReplyVO> list(Integer bno) throws Exception {
		
		return dao.list(bno);
	}

	// 댓글 수정
	@Override
	public void modify(ReplyVO vo) throws Exception {

		dao.modify(vo);
	}

	// 댓글 삭제
	@Override
	public void delete(Integer rno) throws Exception {

		int bno = dao.getBno(rno); // rno로 bno 알아오기
		dao.delete(rno); // 댓글 삭제
		boardDAO.updateReplyCnt(bno, -1); // 댓글 수 줄이기
	}

	// 페이징을 포함한 댓글리스트
	@Override
	public List<ReplyVO> listPage(Integer bno, Criteria cri) throws Exception {
		
		return dao.listPage(bno, cri);
	}

	// 글번호별 댓글 개수
	@Override
	public int count(Integer bno) throws Exception {
		
		return dao.count(bno);
	}
	
}
