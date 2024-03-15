package dto;

import lombok.Data;

@Data
public class CartItemDTO {
	private int m_idx;
	private int item_no;
	private int cart_quantity;
	private String item_name;
	private int item_price;
	private String brand;
	private String img_name;
	private String payment;
}
