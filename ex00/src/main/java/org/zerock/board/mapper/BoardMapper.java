package org.zerock.board.mapper;

import java.util.List;

import org.zerock.board.vo.BoardVO;

public interface BoardMapper {

	// 1. 리스트
	public List<BoardVO> list() throws Exception;
	
	// 1-1. 전체데이터 갯수 가져오기
	public Long getTotalRow() throws Exception;

	// 2. 글보기
	// 메소드 이름은 mapper.xml의 id이름과 맞춘다.
	public BoardVO view(Long no) throws Exception;

//	// 2-1. 조회수 1 증가
//	public int increase() throws Exception;
//	
	// 3. 글쓰기
	public int write(BoardVO vo) throws Exception;

	// 4. 글수정
	public int update(BoardVO vo) throws Exception;
	
	// 5. 글삭제
	public int delete(Long no) throws Exception;
	
}
