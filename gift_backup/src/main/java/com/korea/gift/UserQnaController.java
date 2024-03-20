package com.korea.gift;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import dao.MemberDAO;
import dao.UserQnaDAO;
import dto.MemberDTO;
import dto.UserQnaDTO;
import lombok.RequiredArgsConstructor;
import util.Common;
import util.Page;

@Controller
@RequiredArgsConstructor
public class UserQnaController {
	
	final UserQnaDAO userQnaDAO;	
//	final MemberDAO memberDAO;
	
	@Autowired
	HttpServletRequest request;	
	
	@Autowired
	HttpSession session;
	
	// 사용자 qna(게시글) 글쓰기 화면으로 이동
	@RequestMapping("userQna_form")
	public String insert_form(Model model) {

		MemberDTO show = (MemberDTO)session.getAttribute("m_idx");
		
		model.addAttribute("show",show);

		// 로그인 페이지 작성 완료 후 테스트 필요
//		if(show == null) {
//			return Common.Member.VIEW_PATH + "login.jsp";
//		}
		
		
//		int m_idx = show.getM_idx();	
//		dto.setM_idx(m_idx);
//		
//		// 타입 이름 확인 후 수정 필요
//		MemberDTO memberDTO = UserQnaDAO.selectOne(m_idx);	
//		
//		model.addAttribute("memberDTO", memberDTO);
		
		List<MemberDTO> memberList = userQnaDAO.memberSelect();				
		
		return Common.Board.VIEW_PATH + "userQna_form.jsp";
	}
	
	// 사용자 qna(게시글) 추가
	@RequestMapping("userQna_insert")
	public String insert(UserQnaDTO dto) {
		
		MemberDTO show = (MemberDTO)session.getAttribute("m_idx");
		
		// 로그인 페이지 작성 완료 후 테스트 필요
		if(show == null) {
			return Common.Member.VIEW_PATH + "login.jsp";
		}
		
		int m_idx = show.getM_idx();
		dto.setM_idx(m_idx);

		int res = userQnaDAO.insert(dto);

		if(res > 0) {
			//등록완료후 게시판의 첫 페이지로 복귀
			return "redirect:userQna_list";
		}
		return null;
	}	
	
	// 사용자 qna(게시글) 조회 화면으로 이동
	@RequestMapping("userQna_list")
	public String list(Model model, @RequestParam(required= false, defaultValue="1") int page) {		
		
		//한 페이지에 표시될 게시물의 시작과 끝번호 계산
		//page가 1이면 1~10까지 계산되야함
		//page가 2이면 11~20까지 계산되야함
		int start = (page - 1) * Common.Board.BLOCKLIST + 1;
		int end = start + Common.Board.BLOCKLIST - 1;		
		
		HashMap<String, Integer> map = new HashMap<>();
		map.put("start",start);
		map.put("end",end);
		
		//List<UserQnaDTO> list = userQnaDAO.selectList(map);
		
		//전체 게시물 수 조회
		int rowTotal = userQnaDAO.getRowTotal();
		
		//페이지 메뉴 생성하기
		String pageMenu = Page.getPaging(
				"board_list",
				page, //현재 페이지 번호
				rowTotal, //전체 게시물 수
				Common.Board.BLOCKLIST, //한 페이지에 표기할 게시물 수
				Common.Board.BLOCKPAGE); //페이지 메뉴 수
		
		MemberDTO show = (MemberDTO)session.getAttribute("m_idx");		
		
		List<UserQnaDTO> list = userQnaDAO.selectList();
		
		model.addAttribute("list",list);
		model.addAttribute("pageMenu",pageMenu);
		
		return Common.Board.VIEW_PATH + "userQna_list.jsp?page="+page;
	}
	

}
