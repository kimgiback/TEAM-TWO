    package com.korea.gift;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BuHomeController {

	private final static String BU_MEM_VIEW_PATH = "/WEB-INF/views/bu";

	@RequestMapping("buLoginForm")
	public String buLoginForm() {
		System.out.println("/buLoginForm");

		return BU_MEM_VIEW_PATH + "/buLogin.jsp";
	}

}

    
