package org.zerock.service;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.mapper.SampleMapper;

@Service
@Qualifier("stsi")
public class SampleTxServiceImpl implements SampleTxService {
	
	@Inject
	private SampleMapper mapper;
	
	@Transactional 	// 만약에 메소드안의 DB처리가 한 개라도 오류 발생시 rollback 처리
	@Override
	public int addData() {
		// TODO Auto-generated method stub
		
		// 정상 입력처리
		mapper.insertCol();
		// PK 5 -> 중복 = 오류 발생
		mapper.insertCol();
		
		return 1;
	}

}
