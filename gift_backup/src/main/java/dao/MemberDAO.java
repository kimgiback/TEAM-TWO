package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.MemberDTO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class MemberDAO {
	
	final SqlSession sqlSession;
//	public MemberDAO(SqlSession sqlSession) {
//		
//		this.sqlSession = sqlSession;
//	}
	
	
	public MemberDTO login(HashMap<String, String> map) {
		
		System.out.println("아이디dao : " +map.get("id"));
		System.out.println("비밀번호dao : " +map.get("pwd"));
		

		MemberDTO dto = sqlSession.selectOne("m.memberlogin",map);
		if(dto==null) {
			System.out.println("비밀번호가 일치하지 않습니다.");
		}else {
			System.out.println(dto.getM_idx());
			System.out.println(dto.getBu_name());
			System.out.println("실제 아이디 : " + dto.getBu_id());
			System.out.println("실제 비밀번호 : " + dto.getBu_pwd());
			//return null;
		}
		

		return dto;
	}


	public void insert(MemberDTO memberDTO) {
		System.out.println(memberDTO.getBu_id());
		System.out.println(memberDTO.getBu_name());
		//sqlSession.insert("m.memberjoin", memberDTO);
		
	}


	
	
}
