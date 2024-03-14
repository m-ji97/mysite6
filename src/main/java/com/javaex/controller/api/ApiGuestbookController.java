package com.javaex.controller.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.GuestbookService;
import com.javaex.vo.GuestbookVo;


@Controller
public class ApiGuestbookController {

	@Autowired
	private GuestbookService guestbookService;
	
	//리스트
	@ResponseBody  //return의 데이타를 json방식으로변경해서 응답문서(response)의 바디(body)에 붙여서 보내줘
	@RequestMapping(value="/api/guestbooks", method = RequestMethod.GET)
	public List<GuestbookVo> list() {
		System.out.println("ApiGuestbookController.list()");

		List<GuestbookVo> guestbookList =guestbookService.exeAddList();
		System.out.println(guestbookList);
		
		return guestbookList;
	}
	
	//등록
	@ResponseBody
	@RequestMapping(value ="/api/guestbooks", method = RequestMethod.POST)
	public GuestbookVo add(@ModelAttribute GuestbookVo guestbookVo) {
		System.out.println("ApiGuestbookController.add()");
		System.out.println(guestbookVo);
		
		GuestbookVo gvo = guestbookService.exeAddandGuest(guestbookVo);
		
		System.out.println(gvo);
		
		return gvo;
	}
	
	//삭제
	@ResponseBody
	@RequestMapping(value ="/api/guestbooks/delete", method = {RequestMethod.GET,RequestMethod.POST})
	public String delete(@RequestParam(value = "no") int no,@RequestParam(value = "password") int password, GuestbookVo guestbookVo) {
		System.out.println("ApiGuestbookController.Delete()");
		
		guestbookService.exeDelete(no, password);
		
		return "redirect:/guestbook/addlistForm";
		
	}
	
	
}
