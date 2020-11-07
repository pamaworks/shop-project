package com.prinhashop.www;

import javax.inject.Inject;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.prinhashop.service.ProductService;

// 컨트롤러에서 공통적으로 참조하는 코드 작업
// 다른 모튼 컨트롤러보다 가장 먼저 실행된다.
// 지정해둔 패키지 내의 모든 컨트롤러에서 사용되는 JSP파일에서 해당 model 사용이 가능하다.
@ControllerAdvice(basePackages = {"com.prinhashop.www"})
public class GlobalController {

	@Inject
	private ProductService service;
	
	// 1차 카테고리 메뉴에 표시
	@ModelAttribute
	public void categoryList(Model model)throws Exception{
		model.addAttribute("userCategoryList", service.mainCGList());
		//System.out.println(service.mainCGList().toString());
	}
}
