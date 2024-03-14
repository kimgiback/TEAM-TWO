package dto;

import lombok.Data;

@Data
public class UserQnaDTO {
	
	private int m_idx;
	private int qna_no;
	private int bu_no;
	
	private String qu_title;
	private String qu_content;
	private String qu_select;
	private String term_check;
	private String regidate;
	private String m_name;

}
