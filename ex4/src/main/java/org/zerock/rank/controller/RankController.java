package org.zerock.rank.controller;


//import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.image.service.ImageService;
import org.zerock.rank.service.RankService;
import org.zerock.rank.vo.RankVO;

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

	@Autowired
	@Qualifier("isi")
	private ImageService iservice;
	
	@GetMapping("/list.do")
	public String list(Model model, @ModelAttribute PageObject pageObject, String lev, RankVO vo) throws Exception {
		log.info("list().pageObject : " + lev + "---------------------");

		model.addAttribute("list", service.list(lev));
//		model.addAttribute("rank", service.rank(vo));
		model.addAttribute("ilist", iservice.list(pageObject));
		
		return MODULE + "/list";

	}

	
}
