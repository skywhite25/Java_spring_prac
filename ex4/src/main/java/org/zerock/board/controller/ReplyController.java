package org.zerock.board.controller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.board.service.ReplyService;
import org.zerock.board.vo.ReplyVO;

import com.webjjang.util.PageObject;

import lombok.extern.log4j.Log4j;

// 자동 생성 - @Controller, @Service, @Respository, @Component, @Restcontroller, @~~Advice
//        --> component-scan 설정 : servlet-context.xml, root-context.xml
@RestController
@RequestMapping("/replies")
@Log4j
public class ReplyController {
	
	// 자동 DI 적용
	@Autowired
	@Qualifier("rsi")
	private ReplyService service;
	
	@GetMapping(value = "/list.do",
			produces = {
					MediaType.APPLICATION_XML_VALUE, 
					MediaType.APPLICATION_JSON_UTF8_VALUE
						} )
	// 1. 댓글 목록 - /list.do - get  -> list.json 불가능 : xml만 서비스
	// ResponseEntity : 실행 상태 코드와 함께 실행 결과를 클라이언트에서 전달할 때 사용하는 객체
//	public ResponseEntity<List<ReplyVO>> list(
	public ResponseEntity<Map<String, Object>> list(
			@RequestParam(defaultValue = "1")long repPage,
			@RequestParam(defaultValue = "5")long repPerPageNum, 
			long no) 
		throws Exception {
		Map<String, Object> map = new HashMap<>();
		// 댓글에 대한 페이지 정보
		PageObject replyPageObject = new PageObject(repPage, repPerPageNum);
		log.info("list().replyPageObject : " + replyPageObject + ", no : " + no);
		
		map.put("pageObject", replyPageObject);
		map.put("list", service.list(replyPageObject, no));
		
//		return new ResponseEntity<>(service.list(replyPageObject, no), HttpStatus.OK);
		return new ResponseEntity<>(map, HttpStatus.OK);
		// /WEB-INF/views + /board/list + .jsp -> servlet-context.xml 정보
	}
	
	
	// 2. 댓글 보기 /view.do - get - 생략
//	@GetMapping("/view.do")
//	// Model 객체 - 처리된 데이터를 JSP에 전달
//	// no, inc - 숫자 타입 : 원래는 String으로 데이터 전달, 없으면 null. null을 숫자로 변환하는 과정에서 error가 발생
//	public String view(Model model, @ModelAttribute PageObject pageObject, Long no, int inc) throws Exception {
//
//		log.info("list().pageObject : " + pageObject + "---------------------");
//		model.addAttribute("vo", service.view(no, inc));
//		
//		return MODULE + "/view";
//
//	}
	
	// 3. 댓글 등록 폼 /write.do - get --> /board/view.do 포함
//	@GetMapping("/write.do")
//	public String writeForm() {
//		return MODULE + "/write";
//	}

	// 3-1. 댓글 등록 처리 /write.do - post 
	@PostMapping(value = "/write.do", 
//			consumes = "application/json",
			consumes = {MediaType.APPLICATION_JSON_UTF8_VALUE},
//			produces = {MediaType.TEXT_PLAIN_VALUE})
			produces = {"application/text; charset=utf-8"})
	public ResponseEntity<String> write(@RequestBody ReplyVO vo) throws Exception {
		log.info("write().vo : " + vo);
		
		// DB에 데이터 저장하기
		service.write(vo);
		
		// addFlashAttribute : 한 번만 사용되고 사라진다(세션에 저장 x)
		
		return new ResponseEntity<String>("댓글 등록이 완료되었습니다", HttpStatus.OK);
//		(URLEncoder.encode("댓글 등록이 완료되었습니다.", "utf-8"), HttpStatus.OK);
	}
	
	// 4. 게시판 수정 폼 /update.do - get - /board/view.do 포함
//	@GetMapping("/update.do")
//	public String updateForm(Model model, Long no) throws Exception {
//		log.info("updateForm().no : " + no);
//		
//		// jsp에 수정할 데이터를 보내야 한다. 데이터가 DB에 있다. view()
//		model.addAttribute("vo", service.view(no, 0));
//		
//		return MODULE + "/update";
//	}

	// 4-1. 댓글 수정 처리 /update.do - patch
	@PatchMapping(value = "/update.do",
			consumes = {MediaType.APPLICATION_JSON_UTF8_VALUE},
			produces = {"application/text; charset=utf-8"})
	public ResponseEntity<String> update(@RequestBody ReplyVO vo) throws Exception {
		
		log.info("update().vo : " + vo);
		
		int result = service.update(vo);
		
		// 전달되는 데이터의 선언
		String msg = "댓글 수정 성공";
		HttpStatus status = HttpStatus.OK;
		
		if(result == 0) {
			msg = "댓글 수정 오류 - 정보를 다시 확인해 주세요";
			status = HttpStatus.NOT_MODIFIED;
		}
		log.info("update().msg: " + msg);
		
		return new ResponseEntity<String>(msg, status);
	}	
		
	
	//5. 댓글 삭제 / delete.do - delete 방식
	@DeleteMapping(value = "/delete.do",
			consumes = {MediaType.APPLICATION_JSON_UTF8_VALUE},
			produces = {"application/text; charset=utf-8"})
	public ResponseEntity<String> delete(@RequestBody ReplyVO vo)
			throws Exception {
		
		log.info("delete().vo : " + vo);
		
		int result = service.delete(vo);

		// 전달되는 데이터의 선언
		String msg = "댓글 삭제 성공";
		HttpStatus status = HttpStatus.OK;
		
		if(result == 0) {
			msg = "댓글 삭제 실패";
			status = HttpStatus.NOT_MODIFIED;
		}
		
		log.info("update().msg : " + msg);
		
		return new ResponseEntity<String>(msg, status);
	}
}
