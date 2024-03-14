package com.korea.gift;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.ItemDAO;
import dao.MemberDAO;
import dao.PayingDAO;
import dao.WishCartDAO;
import dto.CartDTO;
import dto.CartItemDTO;
import dto.MemberDTO;
import dto.PayingDTO;
import lombok.RequiredArgsConstructor;
import util.Common;

@Controller
@RequiredArgsConstructor
@RequestMapping("/item")
public class PayingController {

	@Autowired
	HttpSession session;

	final SqlSession sqlSession;

	final PayingDAO pay_dao;
	final MemberDAO member_dao;
	final ItemDAO item_dao;
	final WishCartDAO wishCart_dao;

	@RequestMapping("payitem")
	public String payitem(@RequestParam("item_no") int item_no, CartDTO cartDTO, String payment, Model model) {
	    
	      Integer show = (Integer) session.getAttribute("m_idx");

	    if(show == null) {
	    	return Common.Member.VIEW_PATH+"login.jsp";
	    	
	    }
	    //로그인 했을 때
	    if(show != null) {
	    	int m_idx = show;
	    	int res = wishCart_dao.selectCount(m_idx);
	    //cart에 담긴 정보가 하나 이상일 때 
	    	if(res >= 1) {
	    		cartDTO = new CartDTO();
	    		 cartDTO.setCart_quantity(1);
	    		 cartDTO.setItem_no(item_no);
	    		 cartDTO.setM_idx(m_idx);
	    		CartItemDTO ItemOne = wishCart_dao.cartOne(cartDTO);
	    		System.out.println("cartDTO="+cartDTO);
	    		model.addAttribute("ItemOne", ItemOne);
	    	System.out.println("ItemOne="+ItemOne);
	    	}
	    // cart에 담긴 정보가 없을 때 
	    	if(res <= 0) {
	    		 cartDTO = new CartDTO();
	    		 cartDTO.setCart_quantity(1);
	    		 cartDTO.setItem_no(item_no);
	    		 cartDTO.setM_idx(m_idx);
	    		 //insert
	 	        int cartItem = wishCart_dao.cartItem(cartDTO);
	 	        
	 	        //select
	 	        CartItemDTO ItemOne = wishCart_dao.cartOne(cartDTO);
	 	    
	 	        model.addAttribute("cartItem", cartItem);
	 	        model.addAttribute("ItemOne", ItemOne);
	    	}
	    }
		
	    return Common.Paying.VIEW_PATH+"paying.jsp";
	}
	
	@RequestMapping("card")
	@ResponseBody
	public String card(Model model, MemberDTO dto, @RequestParam("item_no") int item_no ){
		
		Map<String, Object> map = new HashMap<>();
		map.put("item_no", item_no);
		map.put("payment", dto.getPayment());
		map.put("m_idx", session.getAttribute("m_idx"));
		
		int res = pay_dao.pay_info_update(map);
		System.out.println("Res=" + res);
		String result = "";

		if (res > 0) {
			result = "[{'result':'success'}]";
		} else {
			result = "[{'result':'fail'}]";
		}
		return result;
	}


	@RequestMapping("BuyingCheck")
	@ResponseBody
	public String BuyingCheck(PayingDTO dto) {
		int res = pay_dao.BuyingCheck(dto);
		System.out.println("res=" + res);

		if (res >= 0) {
			return "[{'result':'yes'}]";
		} else {
			return "{['result':'no'}]";
		}

	}

}
