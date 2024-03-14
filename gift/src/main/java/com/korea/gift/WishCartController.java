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
	
	// 장바구니
	@GetMapping("cartList")
	public String cartListPage(Model model) {

		Integer m_idx = (Integer)session.getAttribute("m_idx");
			
		// 로그인 안되어있으면 로그인 페이지로
		if (m_idx == null) {
			return Common.Member.VIEW_PATH + "login.jsp";
		}
		
		List<CartItemDTO> cartItemList = wishCartDAO.cartList(m_idx);
		model.addAttribute("cartItemList", cartItemList);
		
		return Common.Item.VIEW_PATH + "cart.jsp";
	}
	
	// 장바구니 수량 변경 Ajax
	@GetMapping("cartList_quan_ajax")
	@ResponseBody
	public Map<String, Object> cartListQuanAjax(@RequestParam("type") String type,
								   		@ModelAttribute CartDTO cartDTO) {
		
		Integer m_idx = (Integer)session.getAttribute("m_idx");
		
		cartDTO.setM_idx(m_idx);
		
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
			if(cartItemDTO.getCart_quantity() == itemDTO.getItem_stock()) {
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
		
		Integer m_idx = (Integer)session.getAttribute("m_idx");
		
		String[] itemsArray = checkedItems.get("items");
		List<Integer> items = Arrays.stream(itemsArray)
                					.map(Integer::parseInt)
                					.collect(Collectors.toList());
		
		Map<String, Object> map = new HashMap<>();
		map.put("m_idx", m_idx); // m_idx 변경
		map.put("items", items);
	
		wishCartDAO.cartDel(map);
		
		/*
		 * cartDTO.setM_idx(1); // m_idx wishCartDAO.cartDel(cartDTO);
		 */
		
		return null;
	}
	
	// 상품 상세 - 장바구니 추가
	@GetMapping("cart_ajax")
	@ResponseBody
	public Map<String, String> cartAddAjax(@ModelAttribute CartDTO checkCartDTO) {
		
		Map<String, String> map = new HashMap<>();
		String result = "";
		int res = 0;

		Integer m_idx = (Integer)session.getAttribute("m_idx");
		
		if (m_idx == null) {
			result = "login_null";
			map.put("result", result);
			
			return map;
		}
		
		// 장바구니에 상품이 이미 존재하는지 확인
		checkCartDTO.setM_idx(m_idx);
		CartDTO cartDTO = wishCartDAO.cartCheck(checkCartDTO);
		
		// 장바구니에 상품이 이미 존재하면 수량만 추가
		if (cartDTO != null) {
			res = wishCartDAO.cartUpdatePlus(cartDTO);
		}
		
		if (res > 0) {
			result = "update_success";
			map.put("result", result);
			
			return map;
		}
		
		// 장바구니에 상품이 존재하지 않으면 추가
		checkCartDTO.setCart_quantity(1);
		res = wishCartDAO.cartAdd(checkCartDTO);
		
		if (res > 0) {
			result = "add_success";
			map.put("result", result);
		}
		
		return map;
	}
	
	// 찜
	@GetMapping("wishList")
	public String wishListPage(Model model) {
		
		Integer m_idx = (Integer)session.getAttribute("m_idx");
		
		// 로그인 안되어있으면 로그인 페이지로
		if (m_idx == null) {
			return Common.Member.VIEW_PATH + "login.jsp";
		}
		
		List<WishItemDTO> wishItemList = wishCartDAO.wishList(m_idx);
		model.addAttribute("wishItemList", wishItemList);
		
		return Common.Item.VIEW_PATH + "wish.jsp";
	}
	
	// 찜 삭제 Ajax
	@GetMapping("wishList_del_ajax")
	@ResponseBody
	public Map<String, Object> wishListDelAjax(@ModelAttribute WishDTO wishDTO) {
		
		Integer m_idx = (Integer)session.getAttribute("m_idx");
		
		Map<String, Object> map = new HashMap<>();
		String result = "";
		
		wishDTO.setM_idx(m_idx); // m_idx 변경
		
		int res = wishCartDAO.wishDel(wishDTO);
		
		if (res > 0) {
			result = "del_success";
			map.put("result", result);
			map.put("item_no", wishDTO.getItem_no());
		}
		
		return map;
	}
	
	// 상품 상세 - 찜 추가 Ajax
	@GetMapping("wish_ajax")
	@ResponseBody
	public Map<String, String> wishAddAjax(@ModelAttribute WishDTO checkWishDTO) {		
		
		Map<String, String> map = new HashMap<>();
		String result = "";

		Integer m_idx = (Integer)session.getAttribute("m_idx");
		
		if (m_idx == null) {
			result = "login_null";
			map.put("result", result);
			
			return map;
		}
		
		checkWishDTO.setM_idx(m_idx); // m_idx 변경
		
		// 찜에 상품이  존재하는지 확인
		WishDTO wishDTO = wishCartDAO.wishCheck(checkWishDTO);

		// 찜에 이미 상품이 존재하면 삭제
		if (wishDTO != null) {
			
			int res = wishCartDAO.wishDel(wishDTO);
			
			if (res > 0) {
				result = "del_success";
				map.put("result", result);
			}
			
			return map;
		}
		
		// 찜에 상품이 존재하지 않으면 상품 추가
		int res = wishCartDAO.wishAdd(checkWishDTO);
		
		if (res > 0) {
			result = "add_success";
			map.put("result", result);
		}
		
		return map;
	}
}
