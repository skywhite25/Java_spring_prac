package org.zerock.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.board.mapper.BoardMapper;
import org.zerock.board.vo.BoardVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

// 자동 생성하게 하는 어노테이션(@)
// @Controller, @Service, @Repository, @Component, @Restcontroller, @Advice
// /WEB-INF/spring/appServlet/servlet-context.xml 설정이 되어 있어야 한다. component-scan
@Service
@Log4j
// BoardService를 상속 받아서 타입이 같은 것이 있으면 어떤 것을 넣어줄 지 결정 x => 오류 발생
@Qualifier("bsi")
public class BoardServiceImpl implements BoardService{
	
	// @Setter - lombok 사용, @Autowired - spring 사용
	// 대신 사용가능한 어노테이션 => @Autowired - spring, @Inject - java
	// DI 적용시 BoardService 타입 => 1: BoardService 인터페이스, 2: BoardServiceImpl 클래스
	@Setter(onMethod_ = @Autowired)
//	@Autowired
//	private BoardDAO dao;
	private BoardMapper mapper;
	
	@Override
	public List<BoardVO> list() throws Exception {
		// TODO Auto-generated method stub
		log.info("list() - 게시판 리스트 서비스 실행 ****");
//		dao.getTotalRow();
//		dao.list();
		return mapper.list();
	}

	@Override
	public BoardVO view(Long no) throws Exception {
		// TODO Auto-generated method stub
		log.info("view() - 게시판 글보기 서비스 실행 ****");

		return mapper.view(no);
	}

	@Override
	public int write(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		return mapper.write(vo);
	}

	@Override
	public int update(BoardVO vo) throws Exception {
		// TODO Auto-generated method stub
		return mapper.update(vo);
	}

	@Override
	public int delete(Long no) throws Exception {
		// TODO Auto-generated method stub
		return mapper.delete(no);
	}

}
