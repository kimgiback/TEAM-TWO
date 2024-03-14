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
			System.out.println(dto.getM_name());
			System.out.println("실제 아이디 : " + dto.getM_id());
			System.out.println("실제 비밀번호 : " + dto.getM_pwd());
			//return null;
		}
		

		return dto;
	}


	public void insert(HashMap<String, String> m_join_insert) {
		System.out.println("DAO 자바 출력");
		System.out.println(m_join_insert.get("id"));
		System.out.println(m_join_insert.get("pwd"));
		System.out.println(m_join_insert.get("name"));
		System.out.println(m_join_insert.get("addr"));
		System.out.println(m_join_insert.get("email"));
		System.out.println(m_join_insert.get("phone"));
		sqlSession.insert("m.memberjoin", m_join_insert);
		System.out.println("insert완료");
		//sqlSession.insert("m.memberjoin", memberDTO);
		
	}


	public String check_id(String id) {
		// TODO Auto-generated method stub
		System.out.println("dao의 값도 "+id);
		String checked_id = sqlSession.selectOne("m.checkid", id);
//		if(checked_id==null) {System.out.println("아이디가 없습니다.");}
//		else {System.out.println("중복된 아이디 "+checked_id+"가 있습니다.");}
		
		return checked_id;
		
		
	}


	
	
}

    
