package org.zerock.rank.service;

import java.util.List;

import org.zerock.rank.vo.RankVO;

public interface RankService {

	// 리스트
	public List<RankVO> list(String lev) throws Exception; 
		
//	// 순위
	public Long rank(RankVO vo) throws Exception;
	
		
		
	
	
	// 상품 썸네일
//	public List<ImageVO> glist(PageObject pageObject, ImageVO vo) throws Exception;
	

	
}
