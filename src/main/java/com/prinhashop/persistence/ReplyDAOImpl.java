package com.prinhashop.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.prinhashop.domain.ReplyVO;
import com.prinhashop.util.Criteria;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	@Inject
	private SqlSession session;
	
	private static String NS = "com.prinhashop.mappers.replyMapper";

	
	// 댓글 추가 
	@Override
	public void addReply(ReplyVO vo) throws Exception {

		session.insert(NS+".addReply",vo);
	}

	// 댓글 리스트
	@Override
	public List<ReplyVO> list(Integer bno) throws Exception {
		
		return session.selectList(NS+".list",bno);
	}

	// 댓글 수정
	@Override
	public void modify(ReplyVO vo) throws Exception {
		
		session.update(NS+".modify",vo);
	}

	// 댓글 삭제
	@Override
	public void delete(Integer rno) throws Exception {

		session.delete(NS+".delete",rno);
	}

	// 댓글번호로 글번호 알아내기
	@Override
	public int getBno(Integer rno) throws Exception {
		
		return session.selectOne(NS+".getBno",rno);
	}

	// 댓글 리스트(페이징 포함)
	@Override
	public List<ReplyVO> listPage(Integer bno, Criteria cri) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("bno", bno);
		map.put("cri", cri);
		
		return session.selectList(NS+".listPage",map);
	}

	// 글번호별 댓글 개수
	@Override
	public int count(Integer bno) throws Exception {
	
		return session.selectOne(NS+".count",bno);
	}
	
}
