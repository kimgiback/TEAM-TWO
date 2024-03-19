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


	//아이디체크
	public HashMap<String, String> check_name(String name, String phone) {
		// TODO Auto-generated method stub
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("name", name);
		map.put("phone", phone);
		
		String get_name = sqlSession.selectOne("m.checkmname", map);
		String get_id = sqlSession.selectOne("m.checkmid", map);
		System.out.println("가져온 이름은 "+get_name+"이고 입력한 이름도 "+name);
		System.out.println("아이디는 "+get_id);
		
		HashMap<String, String> result = new HashMap<String, String>();
		result.put("get_id", get_id);
		result.put("get_name", get_name);
		
		return result;
		
	}


	//비밀번호체크
	public String check_name(String name, String phone, String id) {
		// TODO Auto-generated method stub
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("name", name);
		map.put("phone", phone);
		map.put("id", id);
		
		String get_name = sqlSession.selectOne("m.checkmname_pwd", map);
//		System.out.println("가져온 이름은 "+get_name+"이고 입력한 이름도 "+name);
//		System.out.println(get_name);
		return get_name;

	}


	public void send_temp_pwd(String phone, String random_Int_Str) {


		System.out.println(phone);
		//System.out.println(random_Int_Str);
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("phone", phone);
		map.put("random_int_Str", random_Int_Str);
		//System.out.println(random_Int_Str);
		System.out.println("-------------------");
		System.out.println(phone);
		System.out.println(random_Int_Str);
		

		
		System.out.println("---------------");
		
		sqlSession.update("m.temp_pwd", map);
//		String temp_pwd = sqlSession.selectOne("m.find_temp_pwd",phone);
//		System.out.println(temp_pwd);
//		return temp_pwd;
		
	}


	public int m_withdraw(int m_idx) {
		// TODO Auto-generated method stub
		
		return sqlSession.delete("m.m_withdraw", m_idx);
	}



	
	
}
