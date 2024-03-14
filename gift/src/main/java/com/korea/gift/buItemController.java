    package com.korea.gift;

import java.io.File;
import java.io.IOException;
import java.util.Random;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import dao.buItemDAO;
import dto.BusinessDTO;
import dto.ItemDTO;
import dto.ItemImagefileDTO;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/buItem")
@RequiredArgsConstructor
public class buItemController {
	
	private final static String BU_ITEM_VIEW_PATH = "/WEB-INF/views/item";
	
	private final buItemDAO itemDAO;
	
	@Autowired
	HttpSession session;
	
	@Autowired
	HttpServletRequest request;
	
	private static int IMG_NO_SEQ = 0;
	
	@RequestMapping("insertForm")
	public String insertForm() {
		return BU_ITEM_VIEW_PATH+"/buItemRegister.jsp";
	}
	
	@RequestMapping("/insert")
	public String insert(ItemDTO dto) {
		BusinessDTO writer = (BusinessDTO)session.getAttribute("buLogin");
		int writer_no = writer.getBu_no();
		
		dto.setBu_no(writer_no);
		
		//���, ���ϸ�, dto�� image �޾ƿ���
		String webPath = "/resources/images/item";
		String savePath= request.getServletContext().getRealPath(webPath);
		String filename = UUID.randomUUID().toString();
		MultipartFile photo = dto.getItem_images();
		
		//String�� integer��
		dto.setItem_price((int)dto.getItem_price());
		dto.setItem_stock((int)dto.getItem_stock());
		
		itemDAO.insert(dto);
		
		//imagefileDTO����
		ItemImagefileDTO fileDTO = new ItemImagefileDTO();
		fileDTO.setImg_name(filename);
		
		IMG_NO_SEQ++;
		fileDTO.setImg_no((int)IMG_NO_SEQ);
		fileDTO.setItem_no((int)IMG_NO_SEQ);
		
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
		
		return "redirect:/buItem/insertForm";
		
	}

}

    
