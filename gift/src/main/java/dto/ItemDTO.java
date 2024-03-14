package dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ItemDTO {

	private int item_no;
	
	//     cate
	private int category_no;
	
	//     business
	private int bu_no;
	
	private String item_name;
	
	private int item_price;
	
	private String item_info;
	
	private int item_stock;
	
	private String brand;
	
	private int readhit;
	
	private String img_name; // ITEM_ImageFile 테이블과 join해서 img_name 컬럼 가져옴
	
	private MultipartFile item_image;
	
}