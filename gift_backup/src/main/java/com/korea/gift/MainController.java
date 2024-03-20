package com.korea.gift;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.MainDAO;
import dto.CategoryDTO;
import dto.ItemDTO;
import lombok.RequiredArgsConstructor;
import util.Common;

@Controller
@RequiredArgsConstructor
@RequestMapping("/")
public class MainController {
	
	@Autowired
	private final MainDAO mainDAO;
	
	// 첫 화면 출력
	@GetMapping
	public String mainPage(Model model) {
		
		// 카테고리 정보
		List<CategoryDTO> cateInfo = mainDAO.categoryInfo();
		
		// 전체 카테고리 상품 수
		int itemCount = mainDAO.itemCountAll();
		
		// 전체 카테고리 상품 리스트
		List<ItemDTO> itemList = mainDAO.itemListAll();
		
		model.addAttribute("cateInfo", cateInfo);
		model.addAttribute("itemCount", itemCount);
		model.addAttribute("itemList", itemList);
		
		return Common.Main.VIEW_PATH + "main.jsp";
	}
	
	// 카테고리 Ajax
	@GetMapping("/list_ajax")
	@ResponseBody
	public Map<String, Object> cateCountAjax(@RequestParam("category") Integer cate_no, Model model) {
		
		Map<String, Object> map = new HashMap<>();
		
		Integer itemCount;
		List<ItemDTO> itemList;
		
		// 전체 카테고리
		if (cate_no == 0) {
			itemCount = mainDAO.itemCountAll();
			itemList = mainDAO.itemListAll();
		} else {
			// 특정 카테고리
			itemCount = mainDAO.itemCountCate(cate_no);
			itemList = mainDAO.itemListCate(cate_no);			
		}
		
		map.put("count", itemCount);
		map.put("list", itemList);
		
		return map;
	}
	
	// 카테고리 정렬 Ajax
}
