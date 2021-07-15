package org.zerock.rank.controller;


//import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.rank.service.RankService;

import com.webjjang.util.PageObject;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/rank")
@Log4j
public class RankController {
	
	private final String MODULE = "rank";
	
	@Autowired
	@Qualifier("rsi")
	private RankService service;
	
	@GetMapping("/list.do")
	public String list(Model model, @ModelAttribute PageObject pageObject) throws Exception {
		log.info("list().pageObject : " + pageObject + "---------------------");
		
//		request.setAttribute("boardList", ExeService.execute(Beans.get("/board/list.do"), pageObject));
		model.addAttribute("list", service.list(pageObject));
		
		return MODULE + "/list";
	}
	
//	public String goodList(Model model, @ModelAttribute PageObject pageObject) throws Exception {
//		
//		model.addAttribute("goodList", service.goodList(pageObject));
//		return null;
//	}

	
}
