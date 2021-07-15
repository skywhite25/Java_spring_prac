package org.zerock.board.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.board.service.BoardService;

import lombok.extern.log4j.Log4j;




@Controller // 자동 생성과 역할
@RequestMapping("/board")
@Log4j
public class BoardController {
	
	private final String MODULE = "board";
	
	@Autowired
	@Qualifier("bsi")
	private BoardService service;
	
	// 1. 게시판 리스트
	@GetMapping("/list.do")
	public String list(Model model) throws Exception {
		
		log.info("list() - 게시판 리스트 --------------------");
		
		model.addAttribute("list", service.list());
		
		return MODULE + "/list";
	}
	// 2. 게시판 글보기 
	@GetMapping("/view.do")
	public String view(Model model, Long no) throws Exception {
		
		log.info("list() - 게시판 글보기 --------------------");
		
		model.addAttribute("view", service.view(no));
		
		return MODULE + "/view";
	}
	// 3. 게시판 글쓰기 폼
	// 3-1. 게시판 글쓰기 처리  
	// 4. 게시판 글수정 폼
	// 4-1. 게시판 글수정 처리
	// 5. 게시판 글삭제
}
