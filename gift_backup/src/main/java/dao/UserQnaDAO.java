package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import dto.MemberDTO;
import dto.UserQnaDTO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class UserQnaDAO {

	
	final SqlSession sqlSession;	
	
	// 사용자 회원의 이름, 전화번호 조회 조회
	// -> 타입이름 확인 후 수정 필요
	public List<MemberDTO> memberSelect() {
		List<MemberDTO> list = sqlSession.selectList("userQna.member_one");
		return list;
	}
	
	// 사용자 qna(게시글) 추가
	public int insert(UserQnaDTO dto) {
		return sqlSession.insert("userQna.qna_insert", dto);
	}
	
	// 사용자 전체 qna(게시글) 조회
	public List<UserQnaDTO> selectList(){		
		List<UserQnaDTO> list = sqlSession.selectList("userQna.qna_list");	
		return list;
	}
	
	// 전체 게시물 수 조회
	public int getRowTotal() {
		int count = sqlSession.selectOne("userQna.board_count");
		return count;
	}
	
}
