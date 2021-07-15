package org.zerock.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.board.mapper.BoardMapper;
import org.zerock.board.vo.BoardVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@Qualifier("bsi")
public class BoardServiceImpl implements BoardService {
	
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	// 1. 목록
	public List<BoardVO> list() throws Exception{
		
		log.info("list() - 게시판 목록 실행 ============");
		
		return mapper.list();
	}
	
	// 2. 글보기
	public BoardVO view(Long no) throws Exception{
		
		log.info("view() - 게시판 글보기 실행 ============");
		
		return mapper.view(no);
	}
	
	// 3. 글쓰기
	public int write(BoardVO vo) throws Exception{
		
		log.info("write() - 게시판 글쓰기 실행 ============");
		
		return mapper.write(vo);
	}

	// 4. 글수정
	public int update(BoardVO vo) throws Exception{
		
		log.info("update() - 게시판 글수정 실행 ============");
		
		return mapper.update(vo);
	}
	
	// 5. 글삭제
	public int delete(Long no) throws Exception{
		
		log.info("delete() - 게시판 글쓰기 실행 ============");
		
		return mapper.delete(no);
	}
	
}
