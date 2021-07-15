package org.zerock.rank.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
//import org.zerock.image.vo.ImageVO;
import org.zerock.rank.mapper.RankMapper;
import org.zerock.rank.vo.RankVO;

import com.webjjang.util.PageObject;

import lombok.extern.log4j.Log4j;


@Service
@Qualifier("rsi")
@Log4j
public class RankServiceImpl implements RankService {
	
	@Inject
	private RankMapper mapper;
	
	@Override
	public List<RankVO> list(PageObject pageObject) throws Exception {
		// TODO Auto-generated method stub
		log.info("pageObject : " + pageObject);
		return mapper.list(pageObject);
	}


//	@Override
//	public List<ImageVO> goodList(PageObject pageObject) throws Exception {
//		// TODO Auto-generated method stub
//		return null;
//	}

}
