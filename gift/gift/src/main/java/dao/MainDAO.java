package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.CategoryDTO;
import dto.ItemDTO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class MainDAO {
	
	final SqlSession sqlSession;
	
	// 카테고리 정보
	public List<CategoryDTO> categoryInfo() {
		return sqlSession.selectList("main.category_info");
	}
	
	// 전체 카테고리 상품 수
	public int itemCountAll() {
		return sqlSession.selectOne("main.itemCount_all");
	}
	
	// 특정 카테고리 상품 수
	public int itemCountCate(int cate_no) {
		return sqlSession.selectOne("main.itemCount_cate", cate_no);
	}
	
	// 전체 카테고리 정렬
	public List<ItemDTO> sortHitItemListAll(Map<String, Integer> pageMap) {
		return sqlSession.selectList("main.sortHitItemList_all", pageMap);
	}
	
	public List<ItemDTO> sortAscItemListAll(Map<String, Integer> pageMap) {
		return sqlSession.selectList("main.sortAscItemList_all", pageMap);
	}
	
	public List<ItemDTO> sortDescItemListAll(Map<String, Integer> pageMap) {
		return sqlSession.selectList("main.sortDescItemList_all", pageMap);
	}
	
	// 특정 카테고리 정렬
	public List<ItemDTO> sortHitItemListCate(int cate_no) {
		return sqlSession.selectList("main.sortHitItemList_cate", cate_no);
	}
	
	public List<ItemDTO> sortAscItemListCate(int cate_no) {
		return sqlSession.selectList("main.sortAscItemList_cate", cate_no);
	}
	
	public List<ItemDTO> sortDescItemListCate(int cate_no) {
		return sqlSession.selectList("main.sortDescItemList_cate", cate_no);
	}
	
}
