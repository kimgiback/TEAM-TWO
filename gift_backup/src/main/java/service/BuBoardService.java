package service;

import java.util.List;

import dao.BuBoardDAO;
import dto.QnaDTO;
import dto.ReplyDTO;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
public class BuBoardService {
	
	private final BuBoardDAO dao;
	
	public List<QnaDTO> qnaList() {
		return dao.qnaList();
	}
	
	public QnaDTO qnaOne(int qna_no) {
		return dao.qnaOne(qna_no);
	}
	
	//reply
	public List<ReplyDTO> replyList(int qna_no) {
		return dao.replyList(qna_no);
	}
	
	public ReplyDTO replyOne(int re_no) {
		return dao.replyOne(re_no);
	}
	
	public int replyWrite(ReplyDTO dto) {
		return dao.replyWrite(dto);
	}
	
	public int replyUpdate(ReplyDTO dto) {
		return dao.replyUpdate(dto);
	}
	
	public int replyDelete(int re_no) {
		return dao.replyDelete(re_no);
	}


}
