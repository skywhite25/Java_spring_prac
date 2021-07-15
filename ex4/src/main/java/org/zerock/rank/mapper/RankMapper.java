package org.zerock.rank.mapper;

import java.util.List;

//import org.zerock.image.vo.ImageVO;
import org.zerock.rank.vo.RankVO;

public interface RankMapper {

	// 리스트
	public List<RankVO> list(String lev) throws Exception;
	
	// 순위
	public Long rank(RankVO vo) throws Exception;
	
//	// 전체 데이터
//	public Long getTotalRow(PageObject pageObject);
	
//	public List<ImageVO> glist(PageObject pageObject, ImageVO vo) throws Exception;

}
