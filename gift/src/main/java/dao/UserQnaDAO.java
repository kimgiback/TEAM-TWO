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
	
	// 사용자 회원의 이름, 전화번호 조회
	public MemberDTO memberSelectOne(int m_idx) {
		MemberDTO memberDTO = sqlSession.selectOne("userQna.member_one", m_idx);
		return memberDTO;
	}
	
	// 사용자 qna(게시글) 추가
	public int insert(UserQnaDTO dto) {
		return sqlSession.insert("userQna.qna_insert", dto);
	}
	
	// 사용자 전체 qna(게시글) 조회
	public List<UserQnaDTO> selectList(int m_idx){		
		List<UserQnaDTO> list = sqlSession.selectList("userQna.qna_list", m_idx);	
		return list;
	}
	
	// 전체 게시물 수 조회
	public int getRowTotal() {
		int count = sqlSession.selectOne("userQna.board_count");
		return count;
	}
	
}

    
