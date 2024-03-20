package com.korea.gift;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dto.BusinessDTO;
import lombok.RequiredArgsConstructor;
import service.BuMemberService;

@Controller
@RequestMapping("/bu/member")
@RequiredArgsConstructor
public class BuMemberController {

	private final static String BU_MEM_VIEW_PATH = "/WEB-INF/views/bu";

	private final BuMemberService service;
	
	@Autowired
	HttpSession session;

	@RequestMapping("/buRegisterForm")
	public String buRegisterForm() {
		System.out.println("/buRegisterForm");

		return BU_MEM_VIEW_PATH + "/buRegister.jsp";
	}

	@RequestMapping("/buRegister")
	public String buRegister(BusinessDTO dto) {
		System.out.println("/buRegister");

		try {
			int res = service.buRegister(dto);

			if (res > 0) {
				return "redirect:/";
			}
		} catch (Exception e) {
			return BU_MEM_VIEW_PATH + "/buRegisterError.jsp";
		}

		return null;
	}

	@RequestMapping(value = { "/", "/buLoginForm" })
	public String buLoginForm() {
		System.out.println("/buLoginForm");

		return BU_MEM_VIEW_PATH + "/buLogin.jsp";
	}

	@RequestMapping("/buLogin")
	public String buLogin(BusinessDTO dto, HttpServletRequest req, RedirectAttributes rttr) {
		System.out.println("/buLogin");
//		System.out.println(dto.getBu_id());
//		System.out.println(dto.getBu_pwd());

		HttpSession session = req.getSession();
		
		BusinessDTO login = service.buLogin(dto);

		// 해당하는 회원이 있는지 검증
		if (login == null) {
			// 회원 있으면 세션에 담아주고 없으면 model로 에러 메세지
			session.setAttribute("buLogin", null);
			rttr.addFlashAttribute("msg", false);

			System.out.println("login err");
		} else {
			session.setAttribute("buLogin", login);

			System.out.println("login success");
		}

		// jsp에서 c:if를 통해 page 변화 주어야함
		return "redirect:/";
	}
	
	//로그아웃
	@RequestMapping("/buLogout")
	public String buLogout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/";
	}
	
	//id검증
	@RequestMapping("/buIdCheck")
	public String buIdCheck(BusinessDTO dto, RedirectAttributes rttr) {
		String bu_id = dto.getBu_id();
		
		try {
			BusinessDTO result = service.buIdCheck(bu_id);
			
			if(result.getBu_id().equals(bu_id)) {
				rttr.addFlashAttribute("checkMsg", false);
			}
		} catch(Exception e) {
			rttr.addFlashAttribute("checkMsg", true);
		}
		
		return "redirect:/bu/member/buRegisterForm";
	}

}
