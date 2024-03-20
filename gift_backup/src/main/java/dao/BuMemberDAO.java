package dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import dto.BusinessDTO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class BuMemberDAO {

	private final SqlSession sql;

	// 결과가 성공하면 int값 반환
	public int buRegister(BusinessDTO buDTO) throws Exception {
		return sql.insert("buMember.buRegister", buDTO);
	}

	public BusinessDTO buLogin(HashMap<String, String> map) {

//		System.out.println(map.get("bu_id"));
//		System.out.println(map.get("bu_pwd"));

		return sql.selectOne("buMember.buLogin", map);
	}

	public BusinessDTO buIdCheck(String bu_id) throws Exception {
		return sql.selectOne("buMember.buIdCheck", bu_id);
	}

	public BusinessDTO buOne(int bu_no) {
		return sql.selectOne("buMember.buOne", bu_no);
	}

}
