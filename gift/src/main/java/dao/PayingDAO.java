<<<<<<< HEAD
package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.ItemDTO;
import dto.MemberDTO;
import dto.PayingDTO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class PayingDAO {
	
final SqlSession sqlSession;

	// 결제 정보 업데이트
	public int pay_info_update(Map<String, Object> map) {
		int res = sqlSession.update("p.paying_info_update", map);
		return res;
	}
	// 지금은 필요없지만 결제정보로 넣어야 하나 고민중
	public List<PayingDTO> buy_info() {
		List<PayingDTO> Buyinglist = sqlSession.selectList("p.pay_info");
		return Buyinglist;
	}
	// 결제하기 누르면 PAY테이블에 insert 됨
	public int BuyingCheck(PayingDTO dto) {
		int res = sqlSession.insert("p.BuyingCheck", dto);
		return res;
	}
	
	/*
	 * public MemberDTO payitem(Map<String, Object> map) { 
	 * MemberDTO memberDTO = sqlSession.selectOne("p.payitem", map);
	 * System.out.println("memberDTO="+memberDTO); 
	 * return memberDTO; }
	 */
	
	public List<ItemDTO> pay_info(Map<String, Object> map) {
		List<ItemDTO> Payinglist = sqlSession.selectList("p.payitem", map);
		System.out.println("Payinglist3="+Payinglist);
		return Payinglist;
	}
	

}
=======
package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.ItemDTO;
import dto.MemberDTO;
import dto.PayingDTO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class PayingDAO {
	

final SqlSession sqlSession;


/*
 * public List<PayingDTO> pay_info() { 
 * List<PayingDTO> Payinglist = sqlSession.selectList("p.pay_info"); 
 * return Payinglist; 
 * }
 */
	
	public int pay_info_update(Map<String, Object> map) {
		int res = sqlSession.update("p.paying_info_update", map);
	
		return res;
	}
	
	public List<PayingDTO> buy_info() {
		List<PayingDTO> Buyinglist = sqlSession.selectList("p.pay_info");
		return Buyinglist;
	}
	
	public int BuyingCheck(PayingDTO dto) {
		int res = sqlSession.update("p.BuyingCheck", dto);
		return res;
	}
	
	public MemberDTO payitem(Map<String, Object> map) {
		MemberDTO memberDTO = sqlSession.selectOne("p.payitem", map);
		System.out.println("memberDTO="+memberDTO);
		return memberDTO;
	}
	
	public List<ItemDTO> pay_info(Map<String, Object> map) {
		List<ItemDTO> Payinglist = sqlSession.selectList("p.payitem", map);
		System.out.println("Payinglist3="+Payinglist);
		return Payinglist;
	}
}
>>>>>>> branch 'gift' of https://github.com/kimgiback/TEAM-TWO.git
