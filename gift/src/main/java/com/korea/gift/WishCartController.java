package com.korea.gift;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.ItemDAO;
import dao.WishCartDAO;
import dto.CartDTO;
import dto.CartItemDTO;
import dto.ItemDTO;
import dto.WishDTO;
import dto.WishItemDTO;
import lombok.RequiredArgsConstructor;
import util.Common;

@Controller
@RequiredArgsConstructor
@RequestMapping("/")
public class WishCartController {
	
	@Autowired
	private final WishCartDAO wishCartDAO;
	
	@Autowired
	private final ItemDAO itemDAO;
	
	@Autowired
	HttpSession session;
	
	// �옣諛붽뎄�땲
	@GetMapping("cartList")
	public String cartListPage(Model model) {
	/*	
		MemberDTO member = (MemberDTO)session.getAttribute("member");
				
		// 濡쒓렇�씤 �븞�릺�뼱�엳�쑝硫� 濡쒓렇�씤 �럹�씠吏�濡�
		if (member == null) {
			return Common.Member.VIEW_PATH + "login.jsp";
		}
		
		int m_idx = member.getM_idx();
	*/	
		
		List<CartItemDTO> cartItemList = wishCartDAO.cartList(1); // m_idx
		model.addAttribute("cartItemList", cartItemList);
		
		return Common.Item.VIEW_PATH + "cart.jsp";
	}
	
	// �옣諛붽뎄�땲 �닔�웾 蹂�寃�
	@GetMapping("cartList_quan_ajax")
	@ResponseBody
	public Map<String, Object> cartListQuanAjax(@RequestParam("type") String type,
								   		@ModelAttribute CartDTO cartDTO) {
	/*	
		MemberDTO member = (MemberDTO)session.getAttribute("member");
				
		// 濡쒓렇�씤 �븞�릺�뼱�엳�쑝硫� 濡쒓렇�씤 �럹�씠吏�濡�
		if (member == null) {
			return Common.Member.VIEW_PATH + "login.jsp";
		}
		
		int m_idx = member.getM_idx();
	*/
		
		cartDTO.setM_idx(1); // m_idx
		
		String result = "";
		Map<String, Object> map = new HashMap<>();

		CartItemDTO cartItemDTO = wishCartDAO.cartOne(cartDTO);
		ItemDTO itemDTO = itemDAO.selectOne(cartDTO.getItem_no());
		
		if (type.equals("minus")) {
			if (cartItemDTO.getCart_quantity() == 1) {
				result = "one";
				map.put("result", result);
				
				return map;
			}
			
			wishCartDAO.cartUpdateMinus(cartDTO);	

		} else if (type.equals("plus")) {
			if(cartItemDTO.getCart_quantity() > itemDTO.getItem_stock()) {
				result = "over";
				map.put("result", result);
				
				return map;
			}
			
			wishCartDAO.cartUpdatePlus(cartDTO);
		}
		
		cartItemDTO = wishCartDAO.cartOne(cartDTO);
		map.put("item", cartItemDTO);
		
		return map;
	}
	
	// 장바구니 삭제 Ajax
	@PostMapping("cartList_del_ajax")
	@ResponseBody
	public String cartListDelAjax(@RequestBody Map<String, String[]> checkedItems) {
	/*	
		MemberDTO member = (MemberDTO)session.getAttribute("member");
				
		// 濡쒓렇�씤 �븞�릺�뼱�엳�쑝硫� 濡쒓렇�씤 �럹�씠吏�濡�
		if (member == null) {
			return Common.Member.VIEW_PATH + "login.jsp";
		}
		
		int m_idx = member.getM_idx();
	*/
		
		String[] itemsArray = checkedItems.get("items");
		List<Integer> items = Arrays.stream(itemsArray)
                					.map(Integer::parseInt)
                					.collect(Collectors.toList());
		
		Map<String, Object> map = new HashMap<>();
		map.put("m_idx", 1); // m_idx
		map.put("items", items);
	
		wishCartDAO.cartDel(map);
		
		/*
		 * cartDTO.setM_idx(1); // m_idx wishCartDAO.cartDel(cartDTO);
		 */
		
		return null;
	}
	
	// �긽�뭹 �긽�꽭 - �옣諛붽뎄�땲 異붽� Ajax
	@GetMapping("cart_ajax")
	@ResponseBody
	public Map<String, String> cartAddAjax(@ModelAttribute CartDTO checkCartDTO) {
	/*		
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		
		// 濡쒓렇�씤 �븞�릺�뼱�엳�쑝硫� 濡쒓렇�씤 �럹�씠吏�濡�
		if (member == null) {
			return Common.Member.VIEW_PATH + "login.jsp";
		}
		
		int m_idx = member.getM_idx();
	*/	
		
		Map<String, String> map = new HashMap<>();
		
		String result = "";
		int res = 0;
		
		// �옣諛붽뎄�땲�뿉 �긽�뭹�씠 �씠誘� 議댁옱�븯�뒗吏� �솗�씤
		checkCartDTO.setM_idx(1); // m_idx
		CartDTO cartDTO = wishCartDAO.cartCheck(checkCartDTO);
		
		// �옣諛붽뎄�땲�뿉 �긽�뭹�씠 �씠誘� 議댁옱�븯硫� �닔�웾留� 異붽�
		if (cartDTO != null) {
			res = wishCartDAO.cartUpdatePlus(cartDTO);
		}
		
		if (res > 0) {
			result = "update_success";
			map.put("result", result);
			
			return map;
		}
		
		// �옣諛붽뎄�땲�뿉 �긽�뭹�씠 議댁옱�븯吏� �븡�쑝硫� 異붽�
		checkCartDTO.setCart_quantity(1);
		res = wishCartDAO.cartAdd(checkCartDTO);
		
		if (res > 0) {
			result = "add_success";
			map.put("result", result);
		}
		
		return map;
	}
	
	// 李�
	@GetMapping("wishList")
	public String wishListPage(Model model) {
	/*
		MemberDTO member = (MemberDTO)session.getAttribute("member");
				
		// 濡쒓렇�씤 �븞�릺�뼱�엳�쑝硫� 濡쒓렇�씤 �럹�씠吏�濡�
		if (member == null) {
			return Common.Member.VIEW_PATH + "login.jsp";
		}
		
		int m_idx = member.getM_idx();
	*/	
		
		List<WishItemDTO> wishItemList = wishCartDAO.wishList(1); // m_idx
		model.addAttribute("wishItemList", wishItemList);
		
		return Common.Item.VIEW_PATH + "wish.jsp";
	}
	
	// 李� �궘�젣 Ajax
	@GetMapping("wishList_del_ajax")
	@ResponseBody
	public Map<String, Object> wishListDelAjax(@ModelAttribute WishDTO wishDTO) {
	/*
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		int m_idx = member.getM_idx();
	*/	
		Map<String, Object> map = new HashMap<>();
		String result = "";
		
		wishDTO.setM_idx(1); // m_idx
		
		int res = wishCartDAO.wishDel(wishDTO);
		
		if (res > 0) {
			result = "del_success";
			map.put("result", result);
			map.put("item_no", wishDTO.getItem_no());
		}
		
		return map;
	}
	
	// �긽�뭹 �긽�꽭 - 李� 異붽� Ajax
	@GetMapping("wish_ajax")
	@ResponseBody
	public Map<String, String> wishAddAjax(@ModelAttribute WishDTO checkWishDTO) {
	/*
		MemberDTO member = (MemberDTO)session.getAttribute("member");
		
		// 濡쒓렇�씤 �븞�릺�뼱�엳�쑝硫� 濡쒓렇�씤 �럹�씠吏�濡�
		if (member == null) {
			return Common.Member.VIEW_PATH + "login.jsp";
		}
		
		int m_idx = member.getM_idx();
	*/			
		
		String result = "";
		Map<String, String> map = new HashMap<>();
		
		checkWishDTO.setM_idx(1);
		
		// 李쒖뿉 �긽�뭹�씠  議댁옱�븯�뒗吏� �솗�씤
		WishDTO wishDTO = wishCartDAO.wishCheck(checkWishDTO);

		// 李쒖뿉 �씠誘� �긽�뭹�씠 議댁옱�븯硫� �궘�젣
		if (wishDTO != null) {
			
			int res = wishCartDAO.wishDel(wishDTO);
			
			if (res > 0) {
				result = "del_success";
				map.put("result", result);
			}
			
			return map;
		}
		
		// 李쒖뿉 �긽�뭹�씠 議댁옱�븯吏� �븡�쑝硫� �긽�뭹 異붽�
		int res = wishCartDAO.wishAdd(checkWishDTO);
		
		if (res > 0) {
			result = "add_success";
			map.put("result", result);
		}
		
		return map;
	}
}
