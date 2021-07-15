package org.zerock.util.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.zerock.member.vo.LoginVO;

import lombok.extern.log4j.Log4j;

@Log4j
public class AuthorityInterceptor extends HandlerInterceptorAdapter{

private static Map<String, Integer> authMap = new HashMap<>();

	// 이 클래스에서만 사용하는 변수
	private String url = null;
	
	// 페이지에 대한 등급 정보를 저장하는 메소드
	// 데이터를 넣는 방법 : static 초기화 블록
	// 서버가 로딩될때 정해져야한다. Init.init()에서 처리를 해준다.
	static {
		// 공지사항 - 등록, 수정, 삭제 - 관리자 : 9 -> 관리자만 가능
		authMap.put("/notice/write.do", 9);
		authMap.put("/notice/update.do", 9);
		authMap.put("/notice/delete.do", 9);
		// 질문답변 - 리스트, 질문하기, 답변하기, 수정, 삭제 : 1 -> 일반회원도 답변이 가능
//		authMap.put("/qna/list.do", 1);
		authMap.put("/qna/view.do", 1);
		authMap.put("/qna/question.do", 1);
		authMap.put("/qna/answer.do", 1);
		authMap.put("/qna/update.do", 1);
		authMap.put("/qna/delete.do", 1);
		// 메시지 - 리스트, 보기, 보내기, 삭제 : 1 -> 일반회원도 답변이 가능
		authMap.put("/message/list.do", 1);
		authMap.put("/message/view.do", 1);
		authMap.put("/message/write.do", 1);
		authMap.put("/message/writeForm.do", 1);
		authMap.put("/message/delete.do", 1);
		// 이미지게시판 - 등록, 수정, 삭제 - 회원 : 1 -> 회원만 가능
		authMap.put("/image/write.do", 1);
		authMap.put("/image/update.do", 1);
		authMap.put("/image/updateFile.do", 1);
		authMap.put("/image/delete.do", 1);
		authMap.put("/ajax/getMessageCnt.do", 1);
		// 내정보보기
		authMap.put("/member/view.do", 1);
		
	}
	
	 @Override
	 public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
	    throws Exception {
		
		log.info("+------------------------[AuthorityInterceptor]---------------------------------+");
		
			url = request.getServletPath();
			log.info("+ Authority.doFilter.url : " + url);
			
			// 로그인 객체 꺼내기
			// 로그인 정보는 session에 있다. 하지만 session이 보이지 않는다. request에서 꺼낼 수 있다.
			HttpSession session = request.getSession();
			LoginVO vo = (LoginVO) session.getAttribute("login");
			
			// 새로운 메시지 갯수를 가져오는 처리가 로그아웃 이상이 생긴경우 처리
			// - 브라우에서 페이지 이동이 없이 가만히 놔둔 상태로 있거가 서버가 재실행이 세션이 사라진다. 
			if(url.equals("/ajax/getMessageCnt.do") && vo == null)
				throw new ServletException("DispatcherServlet - 메시지 갯수 가져 오는데 로그인이 안되어 있습니다.");
			
			// 권한이 없는 경우의 처리
			if(!checkAuthority(vo)) {
				// 오류페이지로 이동시킨다.
				((HttpServletResponse)response).sendRedirect(request.getContextPath() + "/error/auth_error.do");
				// 호출한 쪽으로 되돌아간다. - 없으면 계속 아래로 실행이 된다.
				return false;
			}
		 
		// 요청한 내용을 계속 진행
		return super.preHandle(request, response, handler);
	 } // end of preHandle
	 
	 private boolean checkAuthority(LoginVO vo) {
			// url 정보가 authMap에 있는지 확인한다.
			// 데이터가 없으면(null이면) 권한체크가 필요없는 페이지 요청이다.
			Integer pageGradeNo = authMap.get(url);
			if(pageGradeNo == null) {
				log.info("+ AuthorityFilter.checkAuthority() - 권한이 필요없는 페이지 입니다.");
				return true;
			}
			// 여기서 부터는 로그인이 필요한 처리. vo가 null이면 안된다.
			if(vo == null) {
				log.info("+ AuthorityFilter.checkAuthority() - 로그인이 필요합니다.");
				return false;
			}
			log.info("+ AuthorityFilter.checkAuthority().pageGradeNo : " + pageGradeNo);
			log.info("+ AuthorityFilter.checkAuthority().userGradeNo : " + vo.getGradeNo());
			// 권한이 없는 페이지요청에 대한 처리
			if(pageGradeNo > vo.getGradeNo()) {
				log.info("+ AuthorityFilter.checkAuthority() - 권한이 없습니다.");
				return false;
			}
			log.info("+ AuthorityFilter.checkAuthority() - 권한이 있습니다.");
			return true;
		}
	 
}
