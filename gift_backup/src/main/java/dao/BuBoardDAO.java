package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import dto.QnaDTO;
import dto.ReplyDTO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class BuBoardDAO {

	private final SqlSession sql;
	
	//qna
	public List<QnaDTO> qnaList() {
		return sql.selectList("buBoard.boardList");
	}
	
	public QnaDTO qnaOne(int qna_no) {
		return sql.selectOne("buBoard.boardOne", qna_no);
	}
	
	//reply
	public List<ReplyDTO> replyList(int qna_no) {
		return sql.selectList("buBoard.replyList", qna_no);
	}
	
	public ReplyDTO replyOne(int re_no) {
		return sql.selectOne("buBoard.replyOne", re_no);
	}
	
	public int replyWrite(ReplyDTO dto) {
		return sql.insert("buBoard.replyInsert", dto);
	}
	
	public int replyUpdate(ReplyDTO dto) {
		return sql.update("buBoard.replyUpdate", dto);
	}
	
	public int replyDelete(int re_no) {
		return sql.delete("buBoard.replyDelete", re_no);
	}

}
