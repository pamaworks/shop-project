package com.prinhashop.www;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.prinhashop.domain.ReplyVO;
import com.prinhashop.service.ReplyService;
import com.prinhashop.util.Criteria;
import com.prinhashop.util.PageMaker;

@RestController // @Controller + @ResponseBody
@RequestMapping("/replies")
public class ReplyController {

	@Inject
	private ReplyService service;
	
	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);
	
	
	// 1) 댓글 등록 POST
	@RequestMapping(value = "",method = RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody ReplyVO vo){
		
		// @RequestBody : json 포맷으로 전송되어 온 데이터를 vo 객체로 변환 작업
		
		logger.info("-- 게시물 댓글 등록");
		ResponseEntity<String> entity = null;
		
		try {
			// 댓글등록
			service.addReply(vo);
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
			
		}catch(Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	// 2) 댓글 리스트 GET
	@RequestMapping(value = "/all/{bno}",method = RequestMethod.GET)
	public ResponseEntity<List<ReplyVO>> list(@PathVariable("bno") Integer bno){
		
		ResponseEntity<List<ReplyVO>> entity = null;
		
		try {
			entity = new ResponseEntity<>(service.list(bno),HttpStatus.OK);
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	
	// 3) 댓글 수정 PUT, PATCH
	@RequestMapping(value = "/{rno}",method = {RequestMethod.PUT,RequestMethod.PATCH})
	public ResponseEntity<String> update(@PathVariable("rno") Integer rno,
										 @RequestBody ReplyVO vo){
		
		ResponseEntity<String> entity = null;
		
		try {
			vo.setRno(rno); // 댓글 번호 세팅
			service.modify(vo); // 댓글 업데이트
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
			
			logger.info("댓글 수정 값 vo : "+vo.toString());
			
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	
	// 4) 댓글 삭제 DELETE
	@RequestMapping(value = "/{rno}", method = RequestMethod.DELETE)
	public ResponseEntity<String> remove(@PathVariable("rno") Integer rno){
		
		ResponseEntity<String> entity = null;
		
		try {
			service.delete(rno); // 댓글 삭제
			entity = new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(),HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	
	// 5) 댓글 리스트(페이징 포함) GET
	// replies/12/1
	// @PathVariable : 주소에 사용하는 값을 매개변수로 사용 가능하게 해줌
	@RequestMapping(value = "/{bno}/{page}",method = RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> listPage(
							@PathVariable("bno") Integer bno,
							@PathVariable("page") Integer page){
		
		ResponseEntity<Map<String,Object>> entity = null;
		
		try {
			Criteria cri = new Criteria();
			cri.setPage(page);
			
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			
			Map<String,Object> map = new HashMap<String, Object>();
			
			// 댓글리스트 가져오기(페이징포함)
			List<ReplyVO> list = service.listPage(bno, cri); 
			
			map.put("list", list);
			
			// 글번호별 댓글 수 가져오기
			int replyCount = service.count(bno);
			pageMaker.setTotalCount(replyCount);
	
			map.put("pageMaker",pageMaker);
			
			entity = new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	
	
}
