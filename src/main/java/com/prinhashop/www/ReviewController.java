package com.prinhashop.www;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.prinhashop.domain.ReviewVO;
import com.prinhashop.dto.MemberDTO;
import com.prinhashop.service.ReviewService;
import com.prinhashop.util.Criteria;
import com.prinhashop.util.PageMaker;

@Controller
@RequestMapping(value="/review/")
public class ReviewController {

	@Inject
	private ReviewService service;
	
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	
	// 1) 상품 후기 등록
	@ResponseBody
	@RequestMapping(value = "write",method=RequestMethod.POST)
	public void write(ReviewVO vo, HttpSession session)throws Exception{
		
		logger.info("-- 상품 후기 등록");
		logger.info("-- ReviewVO : "+vo.toString());

		MemberDTO dto = (MemberDTO)session.getAttribute("user");
		
		// 사용자가 로그인한 id와 작성한 리뷰  vo insert시켜주기
		service.writeReview(vo,dto.getMem_id());
	}
	
	
	// 2) 상품 후기 수정
	@ResponseBody
	@RequestMapping(value = "modify",method = RequestMethod.POST)
	public ResponseEntity<String> modify(ReviewVO vo){
		
		logger.info("-- 상품 후기 수정");
		logger.info("-- ReviewVO : "+vo.toString());
		
		ResponseEntity<String> entity = null;
		
		try {
			// 상품 수정 update
			service.modifyReview(vo);
			
			entity = new ResponseEntity<String>(HttpStatus.OK);
		}catch(Exception e) {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return entity;
	}
	
	
	// 3) 상품 후기 삭제
	@ResponseBody
	@RequestMapping(value = "{rv_num}",method = RequestMethod.DELETE)
	public ResponseEntity<String> delete(@PathVariable("rv_num") int rv_num){
		
		logger.info("-- 상품 후기 삭제");
		
		ResponseEntity<String> entity = null;
		
		try {
			// 상품 후기 삭제 delete 작업
			service.deleteReview(rv_num);
			
			entity = new ResponseEntity<String>(HttpStatus.OK);
		}catch(Exception e) {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		
		return entity;
	}
	
	
	// 4) ★상품 후기 리스트(페이지 포함)
	@ResponseBody
	@RequestMapping(value = "{pdt_num}/{page}",method = RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> listReview(
						@PathVariable("pdt_num") Integer pdt_num,
						@PathVariable("page") Integer page){
		
		logger.info("-- 상품 후기 리스트");
		
		ResponseEntity<Map<String,Object>> entity = null;
		
		try {
			// 페이지 정보 세팅
			Criteria cri = new Criteria();
			cri.setPage(page);

			// 페이지 메이커 생성
			PageMaker pageMaker = new PageMaker();
			pageMaker.setCri(cri);
			
			Map<String,Object> map = new HashMap<String, Object>();
			List<ReviewVO> list = service.listReview(pdt_num, cri);
			
			// 후기 목록(페이지 포함) 추가
			map.put("list",list);
			
			// 해당 상품의 총 후기 개수
			int replyCount = service.countReview(pdt_num);
			pageMaker.setTotalCount(replyCount);

			// 하단 페이지 작업 추가
			map.put("pageMaker",pageMaker);
			
			entity = new ResponseEntity<Map<String,Object>>(map,HttpStatus.OK);
			
			logger.info("-- 상품 후기 리스트 로딩 성공");
		}catch(Exception e) {
			
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
			e.printStackTrace();
		}
		return entity;
	}
	
	
	
	
}
