package org.zerock.rank.mapper;

import java.util.List;

//import org.zerock.image.vo.ImageVO;
import org.zerock.rank.vo.RankVO;

import com.webjjang.util.PageObject;

public interface RankMapper {

	// 리스트
	public List<RankVO> list(PageObject pageObject);
	
//	// 전체 데이터
	public Long getTotalRow(PageObject pageObject);
	
//	public List<ImageVO> goodList(PageObject pageObject, ImageVO vo) throws Exception;

	
}
