package org.zerock.service;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
//import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

//import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@Log4j
@ContextConfiguration( "file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class SampleServiceTests {
	
	// 자동 DI 적용
//	@Setter(onMethod_  = @Autowired)
	@Inject
	@Qualifier("ssi")
	private SampleService service;
	
	// 실행되는 객체에 대한 정보
	@Test
	public void testClass() {
		log.info("testClass().service : " + service);
		log.info("testClass().service.getClass().getName() : " + service.getClass().getName());
	}
	
	// 값을 대입해서 결과를 출력하는 테스트
	@Test
	public void testAdd() throws Exception{
		log.info(service.doAdd("123", "456"));
	}
}
