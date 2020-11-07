package com.prinhashop.www;

import java.util.Date;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.prinhashop.domain.MemberVO;
import com.prinhashop.dto.MemberDTO;
import com.prinhashop.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	// service 주입
	@Inject
	MemberService service;
	
	// spring-security.xml  BCryptPasswordEncoder클래스가 bean객체
	@Inject
	private BCryptPasswordEncoder passwdEncrypt;
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	
	// 1)회원가입 뷰(GET) /member/join
	@RequestMapping(value="join",method = RequestMethod.GET)
	public void memberJoinGET() {}
	
	
	// 2)회원가입 폼전송(POST)
	@RequestMapping(value = "join",method=RequestMethod.POST)
	public String memberJoinPOST(MemberVO vo, RedirectAttributes rttr)throws Exception{
		
		logger.info("-- 회원가입");
		
		// 비밀번호 암호화 : "사용자 비밀번호"+"다른 문자"로 비밀번호 생성
		vo.setMem_pw(passwdEncrypt.encode(vo.getMem_pw()));
		
		service.join(vo);
		
		rttr.addFlashAttribute("msg", "REGISTER_SUCCESS");
		
		return "redirect:/"; // 루트 주소로 이동
	}
	
	
	// 3)아이디 중복체크 ajax요청(POST)
	@ResponseBody
	@RequestMapping(value = "checkIdJoin",method = RequestMethod.POST)
	public ResponseEntity<String> checkIdJoin(@RequestParam("mem_id") String mem_id)throws Exception{
		
		logger.info("-- 아이디 중복체크");
		
		ResponseEntity<String> entity=null;
		
		try {
			
			String id=service.checkIdJoin(mem_id);
			
			if(id==null) { // 아이디 사용 가능
				entity=new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
			}else{ // 아이디 사용 불가(같은 아이디 존재)
				entity=new ResponseEntity<String>("FAIL",HttpStatus.OK);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			entity=new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	// 4)이메일 인증코드 확인(POST) /member/checkAuthCode
	// 입력된 인증 코드와 세션에 저장해두었던 인증 코드가 일치하는지 확인
	@ResponseBody
	@RequestMapping(value="checkAuthCode",method = RequestMethod.POST)
	public ResponseEntity<String> checkAuthCode(@RequestParam("authcode")String authcode,HttpSession session){
		
		logger.info("-- 이메일 인증코드 확인");
		
		ResponseEntity<String> entity=null;
		
		try {
				// EmailController에서 세션에 저장한 "authcode"
			if(authcode.equals(session.getAttribute("authcode"))) {
				// 인증코드 일치
				entity=new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
			}else {
				// 인증코드 불일치
				entity=new ResponseEntity<String>("FAIL",HttpStatus.OK);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			entity=new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		
		return entity;
		
	}
	
	
	// 5)로그인폼 뷰(GET)
	@RequestMapping(value = "login",method = RequestMethod.GET)
	public void loginGET() {} // 로그인 정보 받아오는
	
	
	// 6)로그인폼 전송(POST)
	@RequestMapping(value = "login",method = RequestMethod.POST)
	public String loginPOST(MemberDTO dto, RedirectAttributes rttr, 
			HttpSession session, Model model, HttpServletResponse response)throws Exception{
		
		// RedirectAttributes : 이동되는 주소(jsp페이지)에서 데이터를 사용하게 하기 위한 파라미터

		logger.info("-- 로그인 시도");
		
		
		
		
		// 로그인시에 사용자로부터 파라미터를 ID로만 받아서 
		// service에서 dao로 보내서 사용자가 입력한 ID에 대한 DB정보가 있으면 가져오게함
		// service에서 해당 ID에 대한 DB정보가 있는지? 없는지? 확인 후
		// ID에 맞는 정보가 있으면 
		// 사용자가 입력한 비밀번호와 DB에서 가져온 암호화된 비밀번호가 일치하는지 확인
		// 일치하는 사용자가 있으면 mDTO에 로그인 정보 반환, 없으면 null 반환
		MemberDTO mDTO = service.login(dto);
		
		
		if(mDTO!=null) { // 사용자가 로그인한 아이디가 있을때
			
			// 암호화되지않은 비밀번호 저장
			mDTO.setMem_origin_pw(dto.getMem_pw());
			logger.info("mDTO.getMem_origin_pw():"+mDTO.getMem_origin_pw());
			
			// if (session.getAttribute("user") !=null ){
		          // 기존에 세션 값이 존재한다면
		          //session.removeAttribute("user");// 기존값을 제거해 준다.
		    // }

			// 세션 작업(서버의 메모리에 저장)
			session.setAttribute("user", mDTO);
			
			logger.info("-- 로그인 성공");
			logger.info("mDTO : "+mDTO);
			
			//model.addAttribute("user", session.getAttribute("user"));
			
			// 1. 로그인이 성공하면, 그 다음으로 로그인 폼에서 쿠키가 체크된 상태로 로그인 요청이 왔는지를 확인한다.
            if ( dto.getIsUseCookie()==2){// dto 클래스 안에 useCookie 항목에 폼에서 넘어온 쿠키사용 여부(true/false)가 들어있을 것임
                // 쿠키 사용한다는게 체크되어 있으면...
                // 쿠키를 생성하고 현재 로그인되어 있을 때 생성되었던 세션의 id를 쿠키에 저장한다.
                Cookie cookie =new Cookie("loginCookie", session.getId());
                
                logger.info("dto : "+dto.getIsUseCookie());
                logger.info("session.getId() : "+session.getId());
                
                // 쿠키를 찾을 경로를 컨텍스트 경로로 변경해 주고...
                cookie.setPath("/");
                
                int amount = 60*60*24*7;
                
                
                // 쿠키 만료 시간 지정
                cookie.setMaxAge(amount);// 단위는 (초)임으로 7일로 유효시간을 설정해 준다.
                
                // 쿠키를 적용해 준다.
                response.addCookie(cookie);

                // 세션 만료 시간 web.xml에 설정함 -> 20분
                // <session-timeout>20</session-timeout>
                // session.setMaxInactiveInterval(interval);// 단위 초
                
                // currentTimeMills()가 1/1000초 단위임으로 1000곱해서 더해야함
                Date sessionLimit =new Date(System.currentTimeMillis() + (1000*60*20));// 20분
                // 현재 세션 id와 유효시간을 사용자 테이블에 저장한다.
                service.keepLogin(dto.getMem_id(), session.getId(), sessionLimit);

            }


			// 로그인 페이지에서 "msg"라는 키로 정보 사용
			// 주소 이동시 "msg"키가 노출되지않음
			rttr.addFlashAttribute("msg", "LOGIN_SUCCESS");
			return "redirect:/";
			
		}else { // 로그인 실패
			logger.info("-- 로그인 실패");
			
			rttr.addFlashAttribute("msg", "LOGIN_FAIL");
			return "redirect:/member/login";
		}
		
	}
	
	
	// 7)로그아웃(GET)
	@RequestMapping(value = "logout",method = RequestMethod.GET)
	public String logout(HttpSession session, RedirectAttributes rttr,HttpServletRequest request,HttpServletResponse response) {
		
		logger.info("-- 로그아웃");
		
		Object obj = session.getAttribute("user");
		if(obj != null) {
			MemberDTO dto = (MemberDTO)obj;
			// 널이 아닐 경우 제거
			session.invalidate(); // 세션 소멸
			
			
			// 쿠키 가져오기
//			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
//			if(loginCookie != null) {
//				// null아닌 쿠키가 존재하면
//				loginCookie.setPath("/");
//				// 쿠키 없앨 때는 유효시간을 0으로 설정
//				loginCookie.setMaxAge(0);
//				// 쿠키 설정 적용
//				response.addCookie(loginCookie);
//				
//				// 사용자 테이블에도 유효시간을 현재시간으로 다시 세팅
//				Date date = new Date(System.currentTimeMillis());
//				service.keepLogin(dto.getMem_id(), session.getId(), date);
//		
//				logger.info("-- 로그아웃 쿠키,세션 재설정");
//			}
		}
		
		
		rttr.addFlashAttribute("msg", "LOGOUT_SUCCESS");
		return "redirect:/";
	}
	
	
	// 8) 마이페이지 뷰(GET)
	@RequestMapping(value = "myPage",method = RequestMethod.GET)
	public void myPage() {}
	
	
	
	// 9)비밀번호 재확인 뷰(GET)
	// @ModelAttribute("url") String url : String url파라미터로 제공받은 값을 "url"이름으로 저장
	/*
	 	1. 회원 정보 수정 : url=modify
	 	2. 비밀번호 변경 : url=changePW
	 	3. 회원 탈퇴 : url=withdrawal
	*/
	@RequestMapping(value = "checkPW", method = RequestMethod.GET)
	public void checkPWGET(@ModelAttribute("url") String url) {}
	
	
	
	// 10-1)비밀번호 재확인 폼(POST)
	@RequestMapping(value = "checkPW", method = RequestMethod.POST)
	public String checkPWPOST(@RequestParam("url") String url,
							  @RequestParam("mem_pw") String pw,
							  HttpSession session, Model model)throws Exception{
		
		
		logger.info("-- 비밀번호 재확인");
		logger.info("url : "+url+" / mem_pw : "+pw);
		
		// 이미 인증된 사용자(로그인 중)에게서 로그인시에 가져온 데이터(실시간 정보X)
		// 로그인 controller에서 세션에 저장한 정보
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
	
		// 세션 저장 값
		logger.info("-- 세션 저장 dto값  : "+dto.toString());
		
		// 사용자가 입력한 비밀번호(pw)와 로그인시에 가져온 데이터(dto)에서 암호화된 비밀번호 비교
		if(passwdEncrypt.matches(pw, dto.getMem_pw())) {
			// 비밀번호가 일치하면 url 리턴
			
			if(url.equals("modify")) { // 회원정보수정
				// DB에서 사용자의 모든 회원정보 가져오기 MemberVO
				// jsp페이지에서 사용하도록 model 작업
				model.addAttribute("vo", service.userInfo(dto.getMem_id()));
				
				return "/member/modify";
				
			}else if(url.equals("changePW")) { // 비밀번호변경
				return "/member/changePW";
				
			}else if(url.equals("withdrawal")) { // 회원탈퇴
				return "/member/withdrawal";
			}
			
		}
		
		// 비밀번호가 일치하지 않거나, url이 위 3개가 아닌 경우
		model.addAttribute("url",url);
		model.addAttribute("msg","CHECK_PW_FAIL");
		
		return "/member/checkPW";
	}
	
	
	
	// 10-2)비밀번호 재확인 ajax요청(GET)
	@ResponseBody
	@RequestMapping("checkPwAjax")
	public ResponseEntity<String> checkPWjax(@RequestParam("mem_pw") String mem_pw, HttpSession session) {
		
		logger.info("=====checkPWAjax() execute...");
		ResponseEntity<String> entity = null;
		MemberDTO dto = (MemberDTO) session.getAttribute("user");
		logger.info("=====mem_pw: " + mem_pw);
		logger.info("=====dto: " + dto.toString());
		
		if(passwdEncrypt.matches(mem_pw, dto.getMem_pw())) {
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			
		} else {
			entity = new ResponseEntity<String>("FAIL", HttpStatus.OK);
		}
		
		return entity;
	}
	
	
	
	// 11)회원정보수정(POST)
	@RequestMapping(value = "modify",method = RequestMethod.POST)
	public String modifyPOST(MemberVO vo, RedirectAttributes rttr, HttpSession session)throws Exception{
		
		logger.info("-- 회원정보수정");
		
		// session으로 작업
		// 마지막으로 로그인했을 때의 user 로그인 정보 dto에 세팅
		MemberDTO dto= (MemberDTO)session.getAttribute("user");			
		logger.info("dto : "+dto.toString());
		
		// 회원정보수정
		// 비밀번호수정하지않기때문에 (암호화된 비밀번호포함하여) 비밀번호가 필요없음
		service.modify(vo);
		
		logger.info("vo : "+vo.toString());
		
		
		// 암호화되지않은 mem_pw를 dto에 세팅해주기 -> 로그인시 필요
		dto.setMem_pw(dto.getMem_origin_pw());
		
		
		// 처음에 로그인시 세션에 저장했던 정보를 다른곳에서 사용되어질 경우(회원수정, 비번변경, 회원탈퇴)
		// 그 정보가 수정이 발생이 되면,세션정보를 갱신해주어야 한다.
		// 예> 비밀번호가 변경
		// 세션작업. 수정중에서 변경된 정보를 세션에 새로 반영하는 의미.
		// service.login에 들어가는 비밀번호는 암홓
		
		session.setAttribute("user", service.login(dto));
		
		rttr.addFlashAttribute("msg","MODIFY_SUCCESS");
		
		logger.info("dto : "+dto.toString());
		
		return "redirect:/";
	}
	
	
	// 12)비밀번호변경(POST)
	@RequestMapping(value="changePW", method = RequestMethod.POST)
	public String changePWPOST(MemberDTO dto, RedirectAttributes rttr, HttpSession session)throws Exception{
		
		logger.info("-- 비밀번호변경");
		
		// 새로운 비밀번호 암호화 후 업데이트
		dto.setMem_pw(passwdEncrypt.encode(dto.getMem_pw()));
		
		// 비밀번호 변경 업데이트
		service.changePW(dto);
		
		// 핵심기능-> 세션에 변경된 비밀번호 업데이트
		MemberDTO mDTO = (MemberDTO)session.getAttribute("user");
		mDTO.setMem_pw(dto.getMem_pw());
		session.setAttribute("user", mDTO); // 비밀번호 변경 업데이트
		
		rttr.addFlashAttribute("msg","CHANGE_PW_SUCCESS");
		
		return "redirect:/";
	}
	
	
	// 13)회원탈퇴(POST)
	@RequestMapping(value = "withdrawal",method = RequestMethod.POST)
	public String withdrawal(String mem_id, RedirectAttributes rttr, HttpSession session)throws Exception{
		
		logger.info("-- 회원탈퇴");
		
		service.withdrawal(mem_id);
		
		// 회원탈퇴시 세션소멸 작업
		session.invalidate();
		rttr.addFlashAttribute("msg", "DELETE_USER_SUCCESS");
		
		return "redirect:/";
	}

	

}


