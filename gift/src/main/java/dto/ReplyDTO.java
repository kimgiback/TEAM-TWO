package dto;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyDTO {

	private int bu_no;
	
	private int qna_no;
	
	private int re_no;
	
	private String re_title;
	
	private String re_content;
	
	private Date regidate;
	
}
