package dao;

import org.apache.ibatis.session.SqlSession;

import dto.ItemDTO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class ItemDAO {

	final SqlSession sqlSession;
	
	public ItemDTO selectOne(int item_no) {
		return sqlSession.selectOne("item.item_detail", item_no);
	}
}
