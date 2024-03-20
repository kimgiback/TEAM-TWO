package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.PayingDTO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class PayingDAO {
	

final SqlSession sqlSession;


	public List<PayingDTO> pay_info() {
		List<PayingDTO> Payinglist = sqlSession.selectList("p.pay_info");
		return Payinglist;
	}
	
	public int update(PayingDTO dto) {
		int res = sqlSession.update("p.paying_update", dto);
		return res;
	}
	
	public List<PayingDTO> buy_info() {
		List<PayingDTO> Buyinglist = sqlSession.selectList("p.pay_info");
		return Buyinglist;
	}
}
