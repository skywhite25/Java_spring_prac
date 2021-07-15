package org.zerock.notice.mapper;

import java.util.List;

import org.zerock.notice.vo.NoticeVO;

import com.webjjang.util.PageObject;

public interface NoticeMapper {
	
	// 1. 공지사항 목록
	public List<NoticeVO> list(PageObject pageObject);
	
	// 1-1. 공지사항 페이지 처리를 위한 전체 데이터 갯수
	public Long getTotalRow(PageObject pageObject);
	
	// 2. 공지사항 글보기
	public NoticeVO view(Long no);
	
	// 3. 공지사항 글쓰기
	public int write(NoticeVO vo);

	// 4. 공지사항 글수정
	public int update(NoticeVO vo);
	
	// 5. 공지사항 글삭제
	public int delete(NoticeVO vo);
	
}
