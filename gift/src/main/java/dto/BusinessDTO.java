package dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BusinessDTO {

	private int bu_no;
	
	private String bu_id;
	
	private String bu_pwd;
	
	private String bu_name;
	
	private String bu_address;
	
	private String bu_email;
	
	private String bu_phone;
	
	//relpy
	private String bu_reply;
	
	//memeber 참조
	private int m_idx;
	
	//item참조
	private int item_no;
	
	private int category_no;
	
	//이미지
	private MultipartFile item_image;
	
}
