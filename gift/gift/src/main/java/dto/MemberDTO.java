package dto;

import lombok.Data;

@Data
public class MemberDTO {

	private int m_idx;

	private String bu_id, m_id;

	private String bu_pwd, m_pwd;

	private String bu_name, m_name;

	private String bu_adress, m_address;

	private String bu_email, m_email;

	private String bu_phone, m_phone;
	
	private String payment;

}