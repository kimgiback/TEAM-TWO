    package com.korea.gift;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import dao.BuItemDAO;
import dto.BusinessDTO;
import dto.ItemDTO;
import dto.ItemImagefileDTO;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/buItem")
@RequiredArgsConstructor
public class BuItemController {
	
	private final static String BU_ITEM_VIEW_PATH = "/WEB-INF/views/item";
	
	private final BuItemDAO itemDAO;
	
	@Autowired
	HttpSession session;
	
	@Autowired
	HttpServletRequest request;
	
	@RequestMapping("insertForm")
	public String insertForm() {
		return BU_ITEM_VIEW_PATH+"/buItemRegister.jsp";
	}
	
	@RequestMapping("/insert")
	public String insert(ItemDTO dto, HttpSession session) {
		System.out.println(dto.toString());
		
//		BusinessDTO writer = (BusinessDTO)session.getAttribute("buLogin");
//		System.out.println(writer.toString());
//		
//		int writer_no = writer.getBu_no();
		
		int writer_no = 1;
		dto.setBu_no(writer_no);
		
		System.out.println(dto.toString());
		
		//���, ���ϸ�, dto�� image �޾ƿ���
		String webPath = "/resources/images/item";
		String savePath= request.getServletContext().getRealPath(webPath);
		String filename = UUID.randomUUID().toString();
		MultipartFile photo = dto.getItem_image();
		
		//String�� integer��
		dto.setItem_price((int)dto.getItem_price());
		dto.setItem_stock((int)dto.getItem_stock());
		dto.setImg_name(filename);
		dto.setCategory_no(1); //임시로 스타벅스
		
		System.out.println(dto.toString());
		
		//imagefileDTO����
		ItemImagefileDTO fileDTO = new ItemImagefileDTO();
		fileDTO.setImg_name(filename);
		
		int imgNum = 1;
		fileDTO.setImg_no((int)imgNum);
//		fileDTO.setItem_no((int)IMG_NO_SEQ);
		imgNum += 1;
		
		itemDAO.insert(dto);
		
//		List<ItemDTO> list = itemDAO.selectAll();
//		int img_itemNum = 1;
//		
//		for(ItemDTO item : list) {
//			if(img_itemNum == item.getItem_no()) {
//				fileDTO.setItem_no(img_itemNum);
//			} else {
//				img_itemNum += 1;
//			}
//		}
		
		fileDTO.setItem_no(3); //##이 부분 하드코딩
		itemDAO.insertImageFile(fileDTO);
		
		if(!photo.isEmpty()) {
			File saveFile = new File(savePath, filename);

			if(!saveFile.exists()) {
				saveFile.mkdirs();
			} else {
				long time = System.currentTimeMillis();
				filename = String.format("%d_%s",time,filename);
				saveFile = new File(savePath, filename);
			}

			try {
				photo.transferTo(saveFile);
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return "redirect:/bu/member/buLoginForm";
		
	}

}

    
