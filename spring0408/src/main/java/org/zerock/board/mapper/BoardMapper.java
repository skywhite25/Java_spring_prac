package org.zerock.board.mapper;

import java.util.List;

import org.zerock.board.vo.BoardVO;

public interface BoardMapper {
	
	// 1. 게시판 리스트
	public List<BoardVO> list()throws Exception;
	
	// 2. 게시판 글보기
	public BoardVO view(Long no) throws Exception;
}
