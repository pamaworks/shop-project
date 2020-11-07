package com.prinhashop.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.prinhashop.domain.BoardVO;
import com.prinhashop.util.SearchCriteria;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession session;
	
	private static String NS = "com.prinhashop.mappers.boardMapper";

	// 목록 검색 기능
	@Override
	public List<BoardVO> listSearchCriteria(SearchCriteria cri) throws Exception {

		return session.selectList(NS+".listSearchCriteria",cri);
	}

	// 목록 검색 카운트 기능
	@Override
	public int listSearchCount(SearchCriteria cri) throws Exception {
		
		return session.selectOne(NS+".listSearchCount",cri);
	}

	// 데이터 읽어오기 / 읽기, 수정 페이지
	@Override
	public BoardVO read(int bno) throws Exception {
		
		return session.selectOne(NS+".read",bno);
	}

	// 데이터 삭제
	@Override
	public void delete(Integer bno) throws Exception {

		session.delete(NS+".delete",bno);
	}

	// 조회수 업데이트
	@Override
	public void viwecntUpdate(Integer bno) throws Exception {

		session.update(NS+".viwecntUpdate",bno);
	}

	
	// 게시물 등록
	@Override
	public void register(BoardVO vo) throws Exception {

		session.insert(NS+".register",vo);
	}

	// 게시물 수정
	@Override
	public void modify(BoardVO vo) throws Exception {

		session.update(NS+".modify",vo);
	}

	// 댓글 수 업데이트
	@Override
	public void updateReplyCnt(Integer bno, int amount) throws Exception {

		Map<String,Object> map = new HashMap<String, Object>();
		
		map.put("bno", bno);
		map.put("amount",amount);
		
		session.update(NS+".updateReplyCnt",map);
	}
	
	
	
}
