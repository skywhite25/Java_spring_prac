package org.zerock.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.log4j.Log4j;

// 자동 생성 : @Controller, @Service, @Repository, @Component, @RestController
// @~Advice - root-context.xml과 servlet-context.xml의 component-scan 설정 확인
@RestController
@RequestMapping("/restsample")
@Log4j
public class RestSampleController {
	
	// 순수한 데이터를 보내는 메솓 지정
	@GetMapping(value = "/getText", produces = "text/plain; charset=UTF-8")
	public String getText() {
		log.info("MIME TYPE : " + MediaType.TEXT_PLAIN_VALUE);
		return "스파시바";
	}
	
	// vo 객체 리턴
	// produces - 제공할 데이터 형식 선언 : JSON, XML 지원 - 기본은 XML
	// /restSample/getSample -> xml
	// /restSample/getSample.json -> json
	// /restSample/getSample.xml -> xml
	@GetMapping(value = "/getSample" , produces = {MediaType.APPLICATION_PROBLEM_JSON_UTF8_VALUE,
												   MediaType.APPLICATION_XML_VALUE})
	public SampleVO getSample() {
		
		return new SampleVO(777, "아아아", "아아아");
	}
	
	// produces를 선언하지 않은 경우
	@GetMapping(value = "/getSample2")
	public SampleVO getSample2() {
		
		return new SampleVO(7777, "오오오", "오오오");
	}
	
	// List - 
	@GetMapping(value = "/getList")
	public List<SampleVO> getList() {
		
		List<SampleVO> list = new ArrayList<SampleVO>();
		
		for(int i = 1; i <= 10; i++)
			list.add(new SampleVO(i, "first"+i, "last"+i));
		
		return list;
	}
	
	// ResponseEntity - 데이터 + 실행상태를 전달
	// localhost/restsample/check?height=140&weight=60
//	@GetMapping(value = "/check", params = {"height, weight"})
	@GetMapping(value = "/check")
	public ResponseEntity<SampleVO> check(Double height, Double weight) {
		
		// "" + height -> height, weight가 Double형식이므로 문자열로 바꿔줌.
		SampleVO vo = new SampleVO(0, "" + height, "" + weight);

		// 데이터 선언
		ResponseEntity<SampleVO> result = null;
		
		if(height < 150) 
			result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
		else  
			result = ResponseEntity.status(HttpStatus.OK).body(vo);
			
		return result;
	}
	
	// url에 데이터를 포함시켜서 전달하는 방법
	// url - localhost/restsample/product/bags/1234
	@GetMapping(value = "/product/{cat}/{pid}")
	public String[] getPath(@PathVariable("cat") String cat, @PathVariable("pid") Integer pid) {
		return new String[] {"category : " + cat, "producted : " + pid};
	}
	
	
	
	
}
