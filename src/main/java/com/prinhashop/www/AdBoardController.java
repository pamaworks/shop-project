package com.prinhashop.www;

import java.util.ArrayList;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.prinhashop.domain.AdOrderVO;
import com.prinhashop.domain.OrderListVO;
import com.prinhashop.domain.OrderReadDetailVO;
import com.prinhashop.domain.OrderReadDetailVOList;
import com.prinhashop.domain.OrderReadDetailVOList2;
import com.prinhashop.service.AdOrderService;
import com.prinhashop.service.BoardService;
import com.prinhashop.service.OrderService;
import com.prinhashop.util.PageMaker;
import com.prinhashop.util.SearchCriteria;

@Controller
@RequestMapping("/admin/board/*")
public class AdBoardController {
	
	@Inject
	private BoardService service;

	private static final Logger logger = (Logger) LoggerFactory.getLogger(AdBoardController.class);

	// 1) 리스트 페이지 GET
	@RequestMapping(value = "list",method = RequestMethod.GET)
	public void listPage(@ModelAttribute("cri") SearchCriteria cri, 
						 Model model)throws Exception{
		
		logger.info("-- 관리자 Q&A 리스트 페이지 로딩");
		logger.info(cri.toString());
		
		// listSearchCriteria 목록 검색 기능
		model.addAttribute("list",service.listSearchCriteria(cri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		//listSearchCount 목록 검색 카운트 기능
		pageMaker.setTotalCount(service.listSearchCount(cri));
		
		model.addAttribute("pm",pageMaker);
		
	}
	
	
	// 2) 게시글 상세페이지 GET
	@RequestMapping(value = "readPage",method = RequestMethod.GET)
	public void read(@RequestParam("bno") int bno,
					 @ModelAttribute("cri") SearchCriteria cri,
					 Model model)throws Exception{
		
		logger.info("-- 게시글 상세페이지 로딩");
		
		model.addAttribute("boardVO", service.read(bno));
	}
	
	
	 // 3) 게시글 삭제 POST
	 @RequestMapping(value = "removePage", method= RequestMethod.POST)
	 public String remove(@RequestParam("bno") int bno,
			 			  SearchCriteria cri,
			 			  RedirectAttributes rttr)throws Exception{
		 
		  logger.info("-- 관리자 게시물 삭제");
		 
		 // 게시물 삭제
		 service.delete(bno);
		 
		 rttr.addAttribute("page", cri.getPage());
		 rttr.addAttribute("perPageNum", cri.getPerPageNum());
		 rttr.addAttribute("searchType", cri.getSearchType());
		 rttr.addAttribute("keyword", cri.getKeyword());

		 rttr.addFlashAttribute("msg", "DELETE");
		 
		 
		 return "redirect:/admin/board/list";
	 }
}
