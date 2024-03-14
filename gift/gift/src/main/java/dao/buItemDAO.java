package dao;

import org.apache.ibatis.session.SqlSession;

import dto.ItemDTO;
import dto.ItemImagefileDTO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class buItemDAO {

	private final SqlSession session;

	public int insert(ItemDTO dto) {
		return session.insert("buItem.insert", dto);
	}
	
	public int insertImageFile(ItemImagefileDTO dto) {
		return session.insert("buItem.insertItemImage", dto);
	}
	
}
