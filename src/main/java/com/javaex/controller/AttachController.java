package com.javaex.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AttachController {
	
	@RequestMapping(value="/attach/uploadform")
	public String uploadform() {
		System.out.println("AttachController.uploadform()");
		
		return "attach/form";
	}
	//월요일 영상 보고 채워넣기
	
}