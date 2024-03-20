package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.ItemDTO;
import dto.ItemImagefileDTO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class BuItemDAO {

	private final SqlSession session;
	
	public List<ItemDTO> selectAll() {
		return session.selectList("buItem.itemList");
	}

	public int insert(ItemDTO dto) {
		return session.insert("buItem.insert", dto);
	}
	
	public int insertImageFile(ItemImagefileDTO dto) {
		return session.insert("buItem.insertItemImage", dto);
	}
	
}
