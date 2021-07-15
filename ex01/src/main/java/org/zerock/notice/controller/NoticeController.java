package org.zerock.notice.controller;

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
import org.zerock.notice.service.NoticeService;
import org.zerock.notice.vo.NoticeVO;

import com.webjjang.util.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/notice")
@Log4j
public class NoticeController {

	private final String MODULE = "notice";
	
	@Autowired
	@Qualifier("nsi")
	private NoticeService service;
	
	@GetMapping("/list.do")
	// 1. 공지사항 목록 - /list.do - get
	public String list(Model model, @ModelAttribute PageObject pageObject) throws Exception{
		log.info("list().pageObject : " + pageObject + "---------------------");
		model.addAttribute("list", service.list(pageObject));
		
		return MODULE + "/list";
	}
	
	// 2. 공지사항 글보기 - /view.do - get
	@GetMapping("/view.do")
	public String view(Model model,@ModelAttribute PageObject pageObject, Long no) throws Exception {
		log.info("view().pageObject : " + pageObject + "---------------------");
		model.addAttribute("vo", service.view(no));
		
		return MODULE + "/view";
	}
	
	// 3. 게시판 등록 폼 /write.do - post
	@GetMapping("/write.do")
	public String writeForm() {
		return MODULE + "/write";
	}
	
	// 3-1. 게시판 등록 처리 /write.do - get
	@PostMapping("/write.do")
	public String write(NoticeVO vo, RedirectAttributes rttr) throws Exception {
		log.info("write()---------------------");
		
		service.write(vo);
		
		rttr.addFlashAttribute("msg", "공지사항 글 등록이 완료되었습니다.");
		
		return "redirect:list.do";
	}
	
	// 4. 공지사항 수정 폼 /update.do - get
	@GetMapping("/update.do")
	public String updateForm(Model model, Long no) throws Exception {
		log.info("updateForm().no : " + no);
		model.addAttribute("vo", service.view(no));
	
		return MODULE + "/update";
	}
	
	// 4-1. 공지사항 수정 처리 /update.do - post
	@PostMapping("/update.do")
	public String update(NoticeVO vo, RedirectAttributes rttr, PageObject pageObject) throws Exception {

		log.info("update().vo : " + vo);
		
		rttr.addFlashAttribute("msg", "공지사항 수정이 완료되었습니다.");
		
		int result = service.update(vo);
		if(result == 0) throw new Exception("공지사항 수정 오류 - 정보를 다시 확인해 주세요.");
		
		log.info("update().result: " + result);
		
		return "redirect:view.do?no=" + vo.getNo()
				+ "&page=" + pageObject.getPage()
				+ "&perPageNum=" + pageObject.getPerPageNum()
				+ "&key=" + pageObject.getKey()
				+ "&word=" + URLEncoder.encode(pageObject.getWord(), "utf-8");
	}
	
	// 5. 게시판 삭제 /delete.do - post
	@PostMapping("/delete.do")
	public String delete(NoticeVO vo, int perPageNum, RedirectAttributes rttr) throws Exception {
		log.info("delete().vo: " + vo);
		
		int result = service.delete(vo);
		
		if(result == 0) throw new Exception("공지사항 삭제 실패 - 정보를 다시 확인하세요");
		
		return "redirect:list.do?perPageNum=" + perPageNum;
	}
	
}
