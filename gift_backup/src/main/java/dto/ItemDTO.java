package dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ItemDTO {

	private int item_no;
	
	//참조 cate
	private int category_no;
	
	//참조 business
	private int bu_no;
	
	private String item_name;
	
	private int item_price;
	
	private String item_info;
	
	private int item_stock;
	
	private String brand;
	
	private String payment;
	
	//image file
	private MultipartFile item_image;
	
}
