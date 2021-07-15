package org.zerock.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.member.service.MemberService;
import org.zerock.member.vo.LoginVO;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member")
public class MemberController {
	
	private final String MODULE = "member";
	
	// 자동 DI - Mapper
	@Autowired
	@Qualifier("msi")
	private MemberService service;
	
	// 로그인은 session을 이용
	// 로그인 폼
	@GetMapping("/loginForm.do")
	public String loginForm() {
		
		log.info("loginForm : 로그인 폼 이동");
		
		return MODULE + "/login";
	}
	
	// 로그인 처리
	// 클라이언트에서 넘겨주는 id, pw를 받아야 함(LoginVO), session을 받아야 한다.
	@PostMapping("/login.do")
	public String login(LoginVO vo, HttpSession session, RedirectAttributes rttr) throws Exception {
		
		// 넘어온 데이터 확인
		log.info("login().vo : " + vo);
		
		// id, pw가 DB정보와 일치하면 로그인 처리(session에 loginVO객체를 넣어 줌)
		session.setAttribute("login", service.login(vo));

		// 메시지 전송		
		rttr.addFlashAttribute("msg", "로그인 잘 했다");
		
		// 로그인이 끝나면 이동할 url
		return "redirect:/board/list.do";
	}
	
	// 로그아웃 처리 메소드
	@GetMapping("/logout.do")
	public String logout(HttpSession session, RedirectAttributes rttr) {
		
		log.info("logout() - 로그아웃");
		
		// 로그아웃 처리 -> login 키를 지움
		// 1. session을 그대로 두고 session안에 login 정보 삭제
		session.removeAttribute("login");
		// 2. session을 완전히 삭제
//		session.invalidate();
		
		// 메시지 전송 ---> 이 걸 쓰려면 session이 있어야 함 : session.invalidate() - 사용 불가능
		rttr.addFlashAttribute("msg", "로그아웃 잘 했다");
		
		return "redirect:/board/list.do";
	}
}
