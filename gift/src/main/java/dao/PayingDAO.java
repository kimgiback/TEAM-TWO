package dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.MemberDTO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class PayingDAO {
	

final SqlSession sqlSession;

	
	public int pay_info_update(Map<String, Object> map) {
		int res = sqlSession.update("p.paying_info_update", map);
	
		return res;
	}
	
public int BuyingCheck(Map<String, Object> map) {
		
		int res = sqlSession.insert("p.BuyingCheck", map);
		
		return res;
	}
	
	public MemberDTO payitem(Map<String, Object> map) {
		MemberDTO memberDTO = sqlSession.selectOne("p.payitem", map);
		System.out.println("memberDTO="+memberDTO);
		return memberDTO;
	}
	
	
}
