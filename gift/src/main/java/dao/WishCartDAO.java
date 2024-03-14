package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import dto.CartDTO;
import dto.CartItemDTO;
import dto.ItemDTO;
import dto.WishDTO;
import dto.WishItemDTO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class WishCartDAO {
	
	final SqlSession sqlSession;

	// 占쎌삢獄쏅떽�럡占쎈빍, 占쎄맒占쎈�� 占쎈염野껓옙 : �뵳�딅뮞占쎈뱜
	public List<CartItemDTO> cartList(int m_idx) {
		return sqlSession.selectList("wishCart.cartItem_list", m_idx);
	}
	
	// 占쎌삢獄쏅떽�럡占쎈빍, 占쎄맒占쎈�� 占쎈염野껓옙 : 占쎄맒占쎈�� 占쎈립 揶쏉옙 鈺곌퀬�돳
	public CartItemDTO cartOne(CartDTO cartDTO) {
		return sqlSession.selectOne("wishCart.cartItem_One", cartDTO);
	}
	
	// 占쎌삢獄쏅떽�럡占쎈빍 占쎄맒占쎈�� 占쎈땾占쎌쎗 +1
	public int cartUpdateMinus(CartDTO cartDTO) {
		return sqlSession.update("wishCart.cart_update_minus", cartDTO);
	}
	
	// 占쎌삢獄쏅떽�럡占쎈빍 占쎄맒占쎈�� 占쎈땾占쎌쎗 -1
	public int cartUpdatePlus(CartDTO cartDTO) {
		return sqlSession.update("wishCart.cart_update_plus", cartDTO);
	}
	
	// 占쎌삢獄쏅떽�럡占쎈빍 占쎄맒占쎈�� 占쎄텣占쎌젫
	public int cartDel(Map<String, Object> map) {
		return sqlSession.delete("wishCart.cart_delete", map);
	}
	
	// 占쎄맒占쎈�� 占쎄맒占쎄쉭 - 占쎌삢獄쏅떽�럡占쎈빍 占쎄맒占쎈�� 鈺곕똻�삺占쎈연�겫占� 占쎌넇占쎌뵥
	public CartDTO cartCheck(CartDTO cartDTO) {
		return sqlSession.selectOne("wishCart.cart_check", cartDTO);
	}
	
	// 占쎄맒占쎈�� 占쎄맒占쎄쉭 - 占쎌삢獄쏅떽�럡占쎈빍 �빊遺쏙옙
	public int cartAdd(CartDTO cartDTO) {
		return sqlSession.insert("wishCart.cart_add", cartDTO);
	}
	
	//-----------------------------------------------------------------

	// 筌∽옙, 占쎄맒占쎈�� 占쎈염野껓옙 : �뵳�딅뮞占쎈뱜
	public List<WishItemDTO> wishList(int m_idx) {
		return sqlSession.selectList("wishCart.wishItem_list", m_idx);
	}
	
	// 筌∽옙 占쎄맒占쎈�� 占쎄텣占쎌젫
	public int wishDel(WishDTO wishDTO) {
		return sqlSession.delete("wishCart.wish_del", wishDTO);
	}
	
	// 占쎄맒占쎈�� 占쎄맒占쎄쉭 - 筌∽옙 占쎄맒占쎈�� 鈺곕똻�삺占쎈연�겫占� 占쎌넇占쎌뵥
	public WishDTO wishCheck(WishDTO wishDTO) {
		return sqlSession.selectOne("wishCart.wish_check", wishDTO);
	}
	
	// 占쎄맒占쎈�� 占쎄맒占쎄쉭 - 筌∽옙 �빊遺쏙옙
	public int wishAdd(WishDTO wishDTO) {
		return sqlSession.insert("wishCart.wish_add", wishDTO);
	}
	//援щℓ�븯湲� �뿉�꽌 移댄듃濡� 蹂대궡踰꾨━湲�
	public int cartItem(CartDTO cartDTO) {
		return sqlSession.insert("wishCart.cartItem", cartDTO);
	}
	
	// 회원 정보로 구매 상품 조회하기
		public int selectCount(int m_idx) {
			return sqlSession.selectOne("wishCart.idxCount", m_idx);
		}
}
