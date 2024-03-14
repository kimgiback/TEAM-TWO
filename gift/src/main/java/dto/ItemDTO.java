package dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class ItemDTO {

	private int item_no;
	
	//���� cate
	private int category_no;
	
	private String item_name;
	
	private int item_price;
	
	private String item_info;
	
	private int item_stock;
	
	private int bu_no;
	
	private MultipartFile item_image;
	
	private String brand;
	
	private int readhit;
	
}