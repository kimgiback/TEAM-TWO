package com.korea.gift;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import dao.ItemDAO;
import dao.WishCartDAO;
import dto.ItemDTO;
import dto.WishDTO;
import lombok.RequiredArgsConstructor;
import util.Common;

@Controller
@RequiredArgsConstructor
@RequestMapping("item")
public class ItemController {

	@Autowired
	private final ItemDAO itemDAO;
	
	@Autowired
	private final WishCartDAO wishCartDAO;
	
	@Autowired
	HttpServletRequest request;
	
	@GetMapping("{item_no}")
	public String itemDetailPage(@PathVariable("item_no") Integer item_no, Model model) {
	/*
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		int m_idx = member.getM_idx();
	*/	
		// 李쒖뿉 �긽�뭹�씠 議댁옱�븯�뒗吏� �솗�씤
		WishDTO checkWishDTO = new WishDTO();
		checkWishDTO.setM_idx(41); // m_idx
		checkWishDTO.setItem_no(item_no);
		
		String wish = "no";
		WishDTO wishDTO = wishCartDAO.wishCheck(checkWishDTO);
		
		if (wishDTO != null) {
			wish = "exists";
		}
		
		// �긽�뭹 �긽�꽭
		ItemDTO item = itemDAO.selectOne(item_no);
		
		HttpSession session = request.getSession();	
		
		// 議고쉶�닔 利앷�
		String view = (String)session.getAttribute("view");
		
		if (view == null) {
			int res = itemDAO.readhitUpdate(item_no);
			session.setAttribute("view", "0");
		}
		
		model.addAttribute("item", item);
		model.addAttribute("wish", wish);
		
		return Common.Item.VIEW_PATH + "item_detail.jsp";
	}
}
