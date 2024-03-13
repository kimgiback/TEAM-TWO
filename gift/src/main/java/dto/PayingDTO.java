package dto;

import lombok.Data;

@Data
public class PayingDTO {
	
	
	private String item_name;
	private String item_info;
	private String item_image;
	private String brand;
	private String payment;
	private String category;
	
	private int bu_no;
	private int category_no;
	private int item_stock;
	private int item_price;
	private int item_no;
	private int m_idx;
	private int readhit;
}
