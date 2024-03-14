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

	// 장바구니, 상품 연결 : 리스트
	public List<CartItemDTO> cartList(int m_idx) {
		return sqlSession.selectList("wishCart.cartItem_list", m_idx);
	}
	
	// 장바구니, 상품 연결 : 상품 한 개 조회
	public CartItemDTO cartOne(CartDTO cartDTO) {
		return sqlSession.selectOne("wishCart.cartItem_One", cartDTO);
	}
	
	// 장바구니 상품 수량 +1
	public int cartUpdateMinus(CartDTO cartDTO) {
		return sqlSession.update("wishCart.cart_update_minus", cartDTO);
	}
	
	// 장바구니 상품 수량 -1
	public int cartUpdatePlus(CartDTO cartDTO) {
		return sqlSession.update("wishCart.cart_update_plus", cartDTO);
	}
	
	// 장바구니 상품 삭제
	public int cartDel(Map<String, Object> map) {
		return sqlSession.delete("wishCart.cart_delete", map);
	}
	
	// 상품 상세 - 장바구니 상품 존재여부 확인
	public CartDTO cartCheck(CartDTO cartDTO) {
		return sqlSession.selectOne("wishCart.cart_check", cartDTO);
	}
	
	// 상품 상세 - 장바구니 추가
	public int cartAdd(CartDTO cartDTO) {
		return sqlSession.insert("wishCart.cart_add", cartDTO);
	}

	// 찜, 상품 연결 : 리스트
	public List<WishItemDTO> wishList(int m_idx) {
		return sqlSession.selectList("wishCart.wishItem_list", m_idx);
	}
	
	// 찜 상품 삭제
	public int wishDel(WishDTO wishDTO) {
		return sqlSession.delete("wishCart.wish_del", wishDTO);
	}
	
	// 상품 상세 - 찜 상품 존재여부 확인
	public WishDTO wishCheck(WishDTO wishDTO) {
		return sqlSession.selectOne("wishCart.wish_check", wishDTO);
	}
	
	// 상품 상세 - 찜 추가
	public int wishAdd(WishDTO wishDTO) {
		return sqlSession.insert("wishCart.wish_add", wishDTO);
	}
	
	// 구매하기 에서 카트로 보내버리기
	public int cartItem(CartDTO cartDTO) {
		return sqlSession.insert("wishCart.cartItem", cartDTO);
	}
	
	// 회원 정보로 구매 상품 조회하기
		public int selectCount(int m_idx) {
			return sqlSession.selectOne("wishCart.idxCount", m_idx);
		}
}
