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
	
	// ����� ȸ���� �̸�, ��ȭ��ȣ ��ȸ ��ȸ
	public MemberDTO memberSelectOne(int m_idx) {
		MemberDTO memberDTO = sqlSession.selectOne("userQna.member_one", m_idx);
		return memberDTO;
	}
	
	// ����� qna(�Խñ�) �߰�
	public int insert(UserQnaDTO dto) {
		return sqlSession.insert("userQna.qna_insert", dto);
	}
	
	// ����� ��ü qna(�Խñ�) ��ȸ
	public List<UserQnaDTO> selectList(int m_idx){		
		List<UserQnaDTO> list = sqlSession.selectList("userQna.qna_list", m_idx);	
		return list;
	}
	
	// ��ü �Խù� �� ��ȸ
	public int getRowTotal() {
		int count = sqlSession.selectOne("userQna.board_count");
		return count;
	}
	
}

    
