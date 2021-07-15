package org.zerock.controller;

import java.util.ArrayList;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.zerock.domain.SampleDTO;
import org.zerock.domain.SampleDTOList;

import lombok.extern.log4j.Log4j;

// 자동 생성이 되게하는 어노테이션 - @Controller, @Service, @Repository, @RestController, @Component, @~~Advice
// - servlet-context.xml에 component-scan으로 설정되어 있어야 한다.
@Controller // url과 실행  mapping
@RequestMapping("/sample")
@Log4j
public class SampleController {
	
	// sample을 입력하면 basic이 나온다 -> '/'를 넣어놔도 무방
	@RequestMapping("")
	// return type이 void면 jsp 정보가 없기 때문에 url자체가 jsp 그 자체가 되어버린다.
	// ex) /localhost/board/list -> return을 void로 지정할 수 있다.
	public void basic() {
		log.info("basic......");
	}
	
	// get 방식으로 넘어오는 url 받기
	// /sample/basic
	// RequestMapping은 get, post 둘다 불러온다.
	@RequestMapping(value = "/basic", method = {RequestMethod.GET})
	public void basicGet() {
		log.info("basicGet......");
	}
	
	// get 방식으로 넘어오는 url 받기 - @GetMapping
	// /sample/basicGet
	@GetMapping("/basicGet")
	public void basicGet2() {
		log.info("basicGet2......");
		
	}
	
	// get 방식으로 넘어오는 url 받기 - /sample/ex02
	// get 방식으로 넘어오는 데이터 받기 - 이름, 나이
	// url : localhost/sample/ex02?name=kim&age=28
	@GetMapping("/ex02")
	public String ex02(
			@RequestParam("name") String name,
			@RequestParam("age") int age
			) {
		log.info("name : " + name);
		log.info("age: " + age);
		
		// WEB-INF/views/ + ex02 + .jsp
		return "ex02";
	}

	@GetMapping("/ex03")
	public String ex03(String name, int age) {
		
		log.info("ex03()-------------------------------");
		log.info("name : " + name);
		log.info("age: " + age);
		
		// WEB-INF/views/ + ex02 + .jsp
		return "ex03";
	}
	
	// ArrayList로 데이터 받기
	// url : /sample/ex02List?ids=111&ids=222&ids=333
	@GetMapping("/ex02List")
	public String ex02List(@RequestParam("ids")ArrayList<String> ids) {
		log.info("ids : " + ids);
		
		return "ex02List";
	}
	
	// url : /sample/ex02List1?ids=111&ids=222&ids=333
	@GetMapping("/ex02List1")
	// ArrayList인 경우 @RequestParam("ids")가 없으면 받아지지 않는다.
	// String[]인 경우 변수 이름만 맞으면 된다 -> @RequestParam("ids")가 없어도 가능
	public String ex02List1(String[] ids) {

		for(String s : ids)
			log.info("s : " + s);

		return "ex02List1";
		
	}
	
	// DTO : Data Transfer Object = VO : value Object
	// BoardDTO = BoardVO = Board : private 변수 선언, getter & setter, toString()
	// url : /sample/ex02DTO?name=test
	@GetMapping("/ex02DTO")
	public String ex02DTO(SampleDTO dto) {
		
		log.info("dto : " + dto);
		
		return "ex02DTO";
	}
	
	// url : /sample/ex02Bean?list[0].name=aaa&list[1].name=bbb ==> [,] : url로 사용할 수 없는 문자열 -> 에러
	// unicode로 작성해 넘긴다. '[' -> %5B, ']' -> %5D
	// url : /sample/ex02Bean?list%5B0%5D.name=aaa&list%5B1%5D.name=bbb
	@GetMapping("/ex02Bean")
	public String ex02Bean(SampleDTOList list) {
		
		log.info("list: " + list);
		
		// url : /WEB-INF/views/ + ex02Bean + .jsp
		return "ex02Bean";
		
	}
	// @ModelAttribute test
	// url : WEB-INF/view/ + sample/exo4 + .jsp
	@GetMapping("/ex04")
	// @ModelAttribute("~~") -> 넘어오는 page의 데이터를 받아서 바로 Model에 담는다. page의 경우 int로 설정했기 때문에 int가 아닌 것을 입력하면 에러
	// JSP로 page 정보를 바로 넘겨줄 수 있다
	public void ex04(@ModelAttribute("dto")SampleDTO dto, @ModelAttribute("page") int page) {
		log.info("dto : " + dto);
		log.info("page" + page);
	}
	
	// 객체 타입의 데이터를 순수 데이터로 전송 -> JSON 데이터 활용
	// 순수한 데이터를 전달하는 메소드만 모아서 @RestController를 만든다.
	@GetMapping("/ex06")
	public @ResponseBody SampleDTO ex06() {
		log.info("ex06 .... dto data return....");
		SampleDTO dto = new SampleDTO();
		dto.setAge(28);
		dto.setName("김태훈");
		
		return dto;
	}
	
	// 처리 된 상태코드와 함께 보내는 ResponseEntity 타입
	@GetMapping("/ex07")
	public ResponseEntity<String> ex07() {
		log.info("ex07 .... ResponseEntity return....");
		String msg = "{'name':'김태훈'}";
//		String msg = "{\"name\":\"김태훈\"}";
		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "application/json;charset=UTF-8");
		
		return new ResponseEntity<>(msg, header, HttpStatus.OK);
	}
	
	// fileupload Form
	@GetMapping("/exUpload")
	public void exUpload() {
		log.info("/exUpload.. input form...");
		
	}
	
	// fileupload 처리
	@PostMapping("/exUploadPost")
	public void exUploadPost(ArrayList<MultipartFile> files) {
		// 일반적인 반복문(for)
//		for(MultipartFile file : files) {
//			log.info("[upload File List]-----------------");
//			log.info("name : " + file.getOriginalFilename());
//			log.info("size : " + file.getSize());
//		}
		// 반복문(for) 람다식
		files.forEach(file -> {
			if(!file.getOriginalFilename().equals("")) {
			log.info("[upload File List]-----------------");
			log.info("name : " + file.getOriginalFilename());
			log.info("size : " + file.getSize());
			}
		});
		
	}
	
	// ModelAndView -> 메소드에서 생성해서 데이터를 담은 후 돌려준다.
	@GetMapping("/mav")
	public ModelAndView exMav() {
		ModelAndView mav = new ModelAndView();
		
		// 데이터 담기 -> Model 대신 사용
		// model.attAttribute("name", "김태훈"); 와 동일
		mav.addObject("name", "김태훈");
		
		// jsp 정보 담기
		mav.setViewName("mav");
		
		return mav;
	}
	
}
