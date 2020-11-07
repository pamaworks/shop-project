package com.prinhashop.www;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.prinhashop.domain.BoardVO;
import com.prinhashop.dto.MemberDTO;
import com.prinhashop.service.BoardService;
import com.prinhashop.util.PageMaker;
import com.prinhashop.util.SearchCriteria;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Inject
	private BoardService service;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	
	// 1) 리스트 페이지 GET
	@RequestMapping(value = "list", method = RequestMethod.GET)
	public void listPage(@ModelAttribute("cri")SearchCriteria cri, Model model)throws Exception{
		
		logger.info("-- Q&A 리스트 페이지 로딩");
		logger.info(cri.toString());
		
		// listSearchCriteria 목록 검색 기능
		model.addAttribute("list",service.listSearchCriteria(cri));
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		
		//listSearchCount 목록 검색 카운트 기능
		pageMaker.setTotalCount(service.listSearchCount(cri));
		
		model.addAttribute("pageMaker",pageMaker);
	}
	
	
	 // 2) 게시글 상세페이지 GET
	 @RequestMapping(value = "readPage", method = RequestMethod.GET)
	 public void read(@RequestParam("bno") int bno, 
			 		  @ModelAttribute("cri") SearchCriteria cri,
			 		  Model model) throws Exception {
		 
		 logger.info("-- 게시글 상세페이지 로딩");
		 
		 // 조회수 업데이트 -> service에서 Transactional
		 // service.viwecntUpdate(bno);
		 
		 model.addAttribute("boardVO",service.read(bno));
		
	 }

	 
	 // 3) 게시글 삭제 POST
	 @RequestMapping(value = "removePage", method= RequestMethod.POST)
	 public String remove(@RequestParam("bno") int bno,
			 			  SearchCriteria cri,
			 			  RedirectAttributes rttr)throws Exception{
		 
		  logger.info("-- 게시물 삭제");
		 
		 // 게시물 삭제
		 service.delete(bno);
		 
		 rttr.addAttribute("page", cri.getPage());
		 rttr.addAttribute("perPageNum", cri.getPerPageNum());
		 rttr.addAttribute("searchType", cri.getSearchType());
		 rttr.addAttribute("keyword", cri.getKeyword());

		 rttr.addFlashAttribute("msg", "DELETE");
		 
		 
		 return "redirect:/board/list";
	 }
	 
	 
	 
	// 4) 게시글 등록 폼 GET
	@RequestMapping(value = "/register",method = RequestMethod.GET)
	public void registerGET()throws Exception{
		logger.info("-- 게시물 등록 폼 로딩");
	}
	 
	 
	
	// 5) 게시글 등록 POST
	@RequestMapping(value = "/register", method=RequestMethod.POST)
	public String registerPOST(BoardVO board,
							   HttpSession session,
							   RedirectAttributes rttr)throws Exception{
		
		logger.info("-- 게시물 등록");
		logger.info("-- BoardVO : "+board.toString());
		
		MemberDTO dto = (MemberDTO)session.getAttribute("user");
		board.setMem_id(dto.getMem_id());
		
		// 게시물 등록
		service.register(board);
		
		rttr.addFlashAttribute("msg", "REGSUCCESS");
		
		return "redirect:/board/list";
	}
	
	
	
	// 6) 수정폼 GET
	@RequestMapping(value = "modifyPage",method = RequestMethod.GET)
	public void modifyPageGET(int bno, 
						  @ModelAttribute("cri") SearchCriteria cri,
						  Model model)throws Exception{
		
		logger.info("-- 수정 폼 로딩");
		
		model.addAttribute(service.read(bno));
	}
	
	
	
	// 7) 수정하기 POST
	@RequestMapping(value = "modifyPage",method = RequestMethod.POST)
	public String modifyPagePOST(BoardVO board,
								 SearchCriteria cri,
								 RedirectAttributes rttr)throws Exception{
		
		logger.info("-- 게시물 수정");
		logger.info("BoardVO board : "+board.toString());
		
		// 게시물 수정
		service.modify(board);
	
		rttr.addFlashAttribute("msg","MODIFYSUCCESS");
		
		return "redirect:/board/list";
	}
	
}
