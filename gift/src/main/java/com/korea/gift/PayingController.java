package com.korea.gift;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.ItemDAO;
import dao.MemberDAO;
import dao.PayingDAO;
import dao.WishCartDAO;
import dto.CartDTO;
import dto.CartItemDTO;
import dto.ItemDTO;
import dto.MemberDTO;
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
	    //�α��� ���� ��
	    if(show != null) {
	    	int m_idx = show;
	    	int res = wishCart_dao.selectCount(m_idx);
	    //cart�� ��� ������ �ϳ� �̻��� �� 
	    	if(res >= 1) {
	    		cartDTO = new CartDTO();
	    		 cartDTO.setCart_quantity(1);
	    		 cartDTO.setItem_no(item_no);
	    		 cartDTO.setM_idx(m_idx);
	    		 
	    		 //select
	    		CartItemDTO ItemOne = wishCart_dao.cartOne(cartDTO);
	    		model.addAttribute("ItemOne", ItemOne);
	    	
	    	}
	    // cart�� ��� ������ ���� �� 
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
	   public String BuyingCheck(@RequestParam Integer item_no, @RequestParam Integer m_idx, @RequestParam String payment) {

	      Map<String, Object> map = new HashMap<>();
			map.put("payment", payment);
			map.put("m_idx", session.getAttribute("m_idx"));
	      
	      // item_no�� DB�� ITEM���̺��� item_no���� �� ã�Ƽ� ItemDTO�� �ޱ�
	      // ���� ItemDTO�� map�� �߰��ϱ�
	      
		ItemDTO itemDTO = item_dao.selectOne(item_no);
		map.put("itemDTO", itemDTO);
		System.out.println("MAP="+map);
		
	      int res = pay_dao.BuyingCheck(map);
	      
	      String result="";
	      
	      if (res >= 0) {
	         return "[{'result':'yes'}]";
	      } else {
	         return "{['result':'no'}]";
	      }
	   }
	   
	 
	   @RequestMapping("cartbuying")
	   public String cartbuying(@RequestParam("items") List<String> items, Model model) {
		   
		   Integer m_idx = (Integer) session.getAttribute("m_idx");
		  
		   System.out.println("m_idx="+m_idx);
		   HashMap<String, Object> map = new HashMap<String, Object>();
		   map.put("m_idx", m_idx);
		   map.put("items",items);
		   System.out.println("items="+items);
		   List<CartItemDTO> cartbuyItem = wishCart_dao.AllCartItem(map); // �迭�� �ִ� ��� īƮ ������ ��������
		 
		 
		   model.addAttribute("cartbuyItem", cartbuyItem); // īƮ ������ ����Ʈ�� �𵨿� �߰�
		   System.out.println("carybuyItem1="+cartbuyItem);
		   
		   return Common.Paying.VIEW_PATH+"buy_info.jsp";
	   }
	   }
