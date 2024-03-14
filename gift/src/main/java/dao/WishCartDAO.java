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

	// �옣諛붽뎄�땲, �긽�뭹 �뿰寃� : 由ъ뒪�듃
	public List<CartItemDTO> cartList(int m_idx) {
		return sqlSession.selectList("wishCart.cartItem_list", m_idx);
	}
	
	// �옣諛붽뎄�땲, �긽�뭹 �뿰寃� : �긽�뭹 �븳 媛� 議고쉶
	public CartItemDTO cartOne(CartDTO cartDTO) {
		return sqlSession.selectOne("wishCart.cartItem_One", cartDTO);
	}
	
	// �옣諛붽뎄�땲 �긽�뭹 �닔�웾 +1
	public int cartUpdateMinus(CartDTO cartDTO) {
		return sqlSession.update("wishCart.cart_update_minus", cartDTO);
	}
	
	// �옣諛붽뎄�땲 �긽�뭹 �닔�웾 -1
	public int cartUpdatePlus(CartDTO cartDTO) {
		return sqlSession.update("wishCart.cart_update_plus", cartDTO);
	}
	
	// �옣諛붽뎄�땲 �긽�뭹 �궘�젣
	public int cartDel(Map<String, Object> map) {
		return sqlSession.delete("wishCart.cart_delete", map);
	}
	
	// �긽�뭹 �긽�꽭 - �옣諛붽뎄�땲 �긽�뭹 議댁옱�뿬遺� �솗�씤
	public CartDTO cartCheck(CartDTO cartDTO) {
		return sqlSession.selectOne("wishCart.cart_check", cartDTO);
	}
	
	// �긽�뭹 �긽�꽭 - �옣諛붽뎄�땲 異붽�
	public int cartAdd(CartDTO cartDTO) {
		return sqlSession.insert("wishCart.cart_add", cartDTO);
	}
	
	//-----------------------------------------------------------------

	// 李�, �긽�뭹 �뿰寃� : 由ъ뒪�듃
	public List<WishItemDTO> wishList(int m_idx) {
		return sqlSession.selectList("wishCart.wishItem_list", m_idx);
	}
	
	// 李� �긽�뭹 �궘�젣
	public int wishDel(WishDTO wishDTO) {
		return sqlSession.delete("wishCart.wish_del", wishDTO);
	}
	
	// �긽�뭹 �긽�꽭 - 李� �긽�뭹 議댁옱�뿬遺� �솗�씤
	public WishDTO wishCheck(WishDTO wishDTO) {
		return sqlSession.selectOne("wishCart.wish_check", wishDTO);
	}
	
	// �긽�뭹 �긽�꽭 - 李� 異붽�
	public int wishAdd(WishDTO wishDTO) {
		return sqlSession.insert("wishCart.wish_add", wishDTO);
	}
	//구매하기 에서 카트로 보내버리기
	public int cartItem(CartDTO cartDTO) {
		return sqlSession.insert("wishCart.cartItem", cartDTO);
	}
}
