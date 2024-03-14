    package service;

import java.util.HashMap;

import dao.BuMemberDAO;
import dto.BusinessDTO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class BuMemberService {
	
	private final BuMemberDAO dao;
	
	public int buRegister(BusinessDTO buDTO) throws Exception {
		return dao.buRegister(buDTO);
	}
	
	public BusinessDTO buLogin(BusinessDTO buDTO) {
//		System.out.println(buDTO.getBu_id());
//		System.out.println(buDTO.getBu_pwd());
		
		HashMap<String, String> map = new HashMap<>();
		map.put("bu_id", buDTO.getBu_id());
		map.put("bu_pwd", buDTO.getBu_pwd());
		
		return dao.buLogin(map);
	}
	
	public BusinessDTO buIdCheck(String bu_id) throws Exception{
		return dao.buIdCheck(bu_id);
	}
	
	public BusinessDTO buOne(int bu_no) {
		return dao.buOne(bu_no);
	}

}

    
