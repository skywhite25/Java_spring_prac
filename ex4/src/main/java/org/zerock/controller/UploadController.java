package org.zerock.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

//자동 생성 - @Controller, @Service, @Respository, @Component, @Restcontroller, @~~Advice
//--> component-scan 설정 : servlet-context.xml, root-context.xml
@Controller
@Log4j
public class UploadController {

	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("uploadForm....");
	}
	
	@PostMapping("/uploadFormAction")
	public void uploadFormAction(MultipartFile[] uploadFile, Model model, HttpServletRequest request) throws IllegalStateException, IOException {
		
		// 저장할 위치 결정
		// 저장할 상대 위치 결정 /webapp/upload - servlet-context.xml에서 허용되어진 폴더여야 함
		// 실제적으로 폴더 생성을 해야 함, 파일 한 개를 넣어두면 반드시 폴더를 만든다. 자원이 없으면 폴더 생성이 안 될 수도 있다
		String path = "/upload";
		
		// request.servletContext().realpath() -> Dispatcher Servlet에서 ServletContext는 주지 않음 => request를 받아서 사용
		log.info("request : " + request);

		// 실제적으로 저장이되는 절대 위치 찾기
		String realPath = request.getServletContext().getRealPath(path);
		log.info("실제 저장 폴더 : " + realPath);
		
		for(MultipartFile mf : uploadFile) {
			log.info("-----------------------------------------------");
			log.info("Upload file name : " + mf.getOriginalFilename());
			log.info("Upload file size : " + mf.getSize());
		
			File saveFile = new File(realPath, mf.getOriginalFilename());

			if(saveFile.exists()) log.info("저장할 파일이 이미 존재합니다.");
			
			// 저장을 실행한다.
			mf.transferTo(saveFile);
			
		}
		
		// 저장할 파일 객체 생성
		
		// jsp에 첨부파일을 전송
		model.addAttribute("uploadFile", uploadFile);
	}
	
}
