package org.zerock.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.zerock.board.mapper.ReplyMapper;
import org.zerock.board.vo.ReplyVO;

import com.webjjang.util.PageObject;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

// 자동 생성 - @Controller, @Service, @Repository, @component, @RestController
// @~Advice --> component-scan 설정 : root_context.xml, servlet-context.xml 설정
@Service
// private 변수에 대한 자동 DI적용 - 생성자
@AllArgsConstructor
@Qualifier("rsi")
@Log4j
public class ReplyServiceImpl implements ReplyService {
	
	private ReplyMapper mapper;
	
	// 1. 댓글 목록
	@Override
	public List<ReplyVO> list(PageObject pageObject, Long no) throws Exception {
		// TODO Auto-generated method stub
		// 게시판 글번호에 맞는 전체 데이터 갯수 가져오기
		pageObject.setTotalRow(mapper.getTotalRow(no));
		log.info("list().pageObject : " + pageObject + ", no : " + no);
		// Mybatis에서 파라메터로 한 개만 받으므로 하나로 합침
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("pageObject", pageObject);
		map.put("no", no);
		return mapper.list(map);
	}

	// 2. 댓글 작성
	@Override
	public int write(ReplyVO vo) throws Exception {
		// TODO Auto-generated method stub
		log.info("write().vo : " + vo);
		return mapper.write(vo);
	}
	// 3. 댓글 수정
	@Override
	public int update(ReplyVO vo) throws Exception {
		// TODO Auto-generated method stub
		log.info("update().vo : " + vo);
		return mapper.update(vo);
	}

	// 4. 댓글 삭제
	@Override
	public int delete(ReplyVO vo) throws Exception {
		// TODO Auto-generated method stub
		log.info("delete().vo : " + vo);
		return mapper.delete(vo);
	}

}
