package dao;

import java.util.List;

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
	
	// 전체 카테고리 상품 리스트
	public List<ItemDTO> itemListAll() {
		return sqlSession.selectList("main.itemList_all");
	}
	
	// 특정 카테고리 상품 수
	public int itemCountCate(int cate_no) {
		return sqlSession.selectOne("main.itemCount_cate", cate_no);
	}
	
	// 특정 카테고리 상품 리스트
	public List<ItemDTO> itemListCate(int cate_no) {
		return sqlSession.selectList("main.itemList_cate", cate_no);
	}
	
}
