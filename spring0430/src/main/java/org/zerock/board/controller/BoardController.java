package org.zerock.board.controller;

import java.net.URLEncoder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.board.service.BoardService;
import org.zerock.board.vo.BoardVO;

import com.webjjang.util.PageObject;

import lombok.extern.log4j.Log4j;

// 자동 생성 - @Controller, @Service, @Respository, @Component, @Restcontroller, @~~Advice
//        --> component-scan 설정 : servlet-context.xml, root-context.xml
@Controller
@RequestMapping("/board")
@Log4j

public class BoardController {
	
	private final String MODULE = "board";
	
	// 자동 DI 적용
	@Autowired
	@Qualifier("bsi")
	private BoardService service;
	
	@GetMapping("/list.do")
	// 1. 게시판 목록 - /list.do - get 
	// @ModelAttribute - 전달 받은 변수의 값을 model에 담아서 JSP까지 보내준다.
	public String list(Model model, @ModelAttribute PageObject pageObject) throws Exception {
		log.info("list().pageObject : " + pageObject + "---------------------");
		model.addAttribute("list", service.list(pageObject));
		// /WEB-INF/views + /board/list + .jsp -> servlet-context.xml 정보
		return MODULE + "/list";
	}
	
	
	// 2. 게시판 글보기 /view.do - get
	@GetMapping("/view.do")
	// Model 객체 - 처리된 데이터를 JSP에 전달
	// no, inc - 숫자 타입 : 원래는 String으로 데이터 전달, 없으면 null. null을 숫자로 변환하는 과정에서 error가 발생
	public String view(Model model, @ModelAttribute PageObject pageObject, Long no, int inc) throws Exception {

		log.info("list().pageObject : " + pageObject + "---------------------");
		model.addAttribute("vo", service.view(no, inc));
		
		return MODULE + "/view";

	}
	// 3. 게시판 등록 폼 /write.do - get
	@GetMapping("/write.do")
	public String writeForm() {
		return MODULE + "/write";
	}

	// 3-1. 게시판 등록 처리 /write.do - post 
	@PostMapping("/write.do")
	public String write(BoardVO vo, int perPageNum, RedirectAttributes rttr) throws Exception {
		log.info("write().vo : " + vo);
		
		// DB에 데이터 저장하기
		service.write(vo);
		
		// addFlashAttribute : 한 번만 사용되고 사라진다(세션에 저장 x)
		rttr.addFlashAttribute("msg", "게시판 글 등록이 완료되었습니다.");
		
		return "redirect:list.do?perPageNum=" + perPageNum;
	}
	
	// 4. 게시판 수정 폼 /update.do - get
	@GetMapping("/update.do")
	public String updateForm(Model model, Long no) throws Exception {
		log.info("updateForm().no : " + no);
		
		// jsp에 수정할 데이터를 보내야 한다. 데이터가 DB에 있다. view()
		model.addAttribute("vo", service.view(no, 0));
		
		return MODULE + "/update";
	}

	// 4-1. 게시판 수정 처리 /update.do - post 
	@PostMapping("/update.do")
	public String update(BoardVO vo, RedirectAttributes rttr, PageObject pageObject) throws Exception {
		log.info("update().vo : " + vo);
		// addFlashAttribute : 한 번만 사용되고 사라진다(세션에 저장 x)
		rttr.addFlashAttribute("msg", "게시판 글 수정이 완료되었습니다.");
		
		int result = service.update(vo);
		if(result == 0) throw new Exception("게시판 수정 오류 - 정보를 다시 확인해 주세요");
		
		log.info("update().result: " + result);
		
		return "redirect:view.do?no=" + vo.getNo() + "&inc=0"
				+ "&page=" + pageObject.getPage()
				+ "&perPageNum=" + pageObject.getPerPageNum()
				+ "&key=" + pageObject.getKey()
				// url로 요청되는 경우 서버의 한글이 적용되므로 utf-8로 encode 시켜서 적용
				+ "&word=" + URLEncoder.encode(pageObject.getWord(), "utf-8");
	}
	
	// 5. 게시판 삭제 /delete.do - post
	@PostMapping("/delete.do")
	public String delete(BoardVO vo, int perPageNum, RedirectAttributes rttr) throws Exception {
		log.info("delete().vo: " + vo);
		
		int result = service.delete(vo);
		// result가 0이면 비밀번호 틀림.
		if(result == 0) throw new Exception("게시판 삭제 실패 - 정보를 확인하세요");

		// addFlashAttribute : 한 번만 사용되고 사라진다(세션에 저장 x)
		rttr.addFlashAttribute("msg", "글삭제가 완료되었습니다.");
		
		return "redirect:list.do?perPageNum=" + perPageNum;
	}
}
