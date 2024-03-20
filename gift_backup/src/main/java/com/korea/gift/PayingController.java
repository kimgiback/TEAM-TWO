package com.korea.gift;

import java.lang.annotation.Repeatable;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.PayingDAO;
import dto.PayingDTO;
import lombok.RequiredArgsConstructor;
import util.Common;

@Controller
@RequiredArgsConstructor
public class PayingController {
	
@Autowired
HttpSession session;

final SqlSession sqlSession;

final PayingDAO pay_dao;

	
	@RequestMapping("pay_info") 
	public String pay_info(Model model) {
		List<PayingDTO> Payinglist = pay_dao.pay_info();
		model.addAttribute("Payinglist",Payinglist);
		System.out.println(Payinglist);
	return Common.Paying.VIEW_PATH+"paying.jsp";
	}
	
	
	@RequestMapping("card")
	@ResponseBody
	public String card(PayingDTO dto) {
		
		String payment = dto.getPayment();
		int res = pay_dao.update(dto);
		
		String result ="";
		
		if(res > 0) {
			result = "[{'result':'success'}]";
		} else {
			 result = "[{'result':'fail'}]";
		}
		return result;
	}
	
	@RequestMapping("buy_info")
	public String buy_info(Model model) {
		List<PayingDTO> Buyinglist = pay_dao.buy_info();
		model.addAttribute("Buyinglist",Buyinglist);
		return Common.Paying.VIEW_PATH+"buy_info.jsp";
	}
	
}

