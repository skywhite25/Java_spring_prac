package org.zerock.rank.service;

import java.util.List;

//import org.zerock.image.vo.ImageVO;
import org.zerock.rank.vo.RankVO;

import com.webjjang.util.PageObject;

public interface RankService {

	// 리스트
	public List<RankVO> list(PageObject pageObject) throws Exception;
	
	// 상품 썸네일
//	public List<ImageVO> goodList(PageObject pageObject) throws Exception;
	
}
