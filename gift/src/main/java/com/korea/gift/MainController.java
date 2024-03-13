package com.korea.gift;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import util.MainPage;

@Controller
@RequiredArgsConstructor
@RequestMapping("/")
public class MainController {
	
	@Autowired
	private final MainDAO mainDAO;
	
	@Autowired
	HttpServletRequest request;
	
	@GetMapping
	public String mainPage(Model model) {
		
		List<CategoryDTO> cateInfo = mainDAO.categoryInfo();
		
		// 조회수 세션 제거
		request.getSession().removeAttribute("view");
	
		model.addAttribute("cateInfo", cateInfo);
		
		return Common.Main.VIEW_PATH + "main.jsp";
	}
	
	// 카테고리별 상품 리스트 Ajax
	@GetMapping("list_ajax")
	@ResponseBody
	public Map<String, Object> cateListAjax(@RequestParam("cate_no") Integer cate_no,
											@RequestParam("sort") String sort,
											@RequestParam(value = "page", required = false) Integer page,
											Model model) {
		 // 페이징
	    int nowPage = 1;
	    
	    if (page != null) {
	        nowPage = page;
	    }
	    System.out.println(sort);
	    System.out.println(page);

	    int start = (nowPage -1) * Common.Main.BLOCKLIST + 1;
	    int end = start + Common.Main.BLOCKLIST - 1;
	    
	    Map<String, Integer> pageMap = new HashMap<>();
	    pageMap.put("start", start);
	    pageMap.put("end", end);
	    
		Map<String, Object> map = new HashMap<>();
		List<ItemDTO> itemList;
		Integer itemCount;
		
		// 조회수 세션 제거
		request.getSession().removeAttribute("view");
		
		if (cate_no == 0) {
			itemCount = mainDAO.itemCountAll();
		
			switch (sort) {
			case "priceAsc" :
				itemList = mainDAO.sortAscItemListAll(pageMap);
				break;
			case "priceDesc" :
				itemList = mainDAO.sortDescItemListAll(pageMap);
				break;
			default :
				itemList = mainDAO.sortHitItemListAll(pageMap);
				break;
			}
		} else {
			itemCount = mainDAO.itemCountCate(cate_no);
			
			switch (sort) {
			case "priceAsc" :
				itemList = mainDAO.sortAscItemListCate(cate_no);
				break;
			case "priceDesc" :
				itemList = mainDAO.sortDescItemListCate(cate_no);
				break;
			default :
				itemList = mainDAO.sortHitItemListCate(cate_no);
				break;
			}
		}
		
		//페이지 메뉴 생성하기
	    String pageMenu = MainPage.getPaging(
	            "list_ajax",
	            nowPage, //현재 페이지 번호
	            itemCount, //전체 게시물 수
	            Common.Main.BLOCKLIST, //한 페이지에 표기할 게시물 수
	            Common.Main.BLOCKPAGE,
	            cate_no,
	            sort); //페이지 메뉴 수
	    
		map.put("count", itemCount);
		map.put("list", itemList);
		map.put("pageMenu", pageMenu);
		 
		return map;
	}
	
}
