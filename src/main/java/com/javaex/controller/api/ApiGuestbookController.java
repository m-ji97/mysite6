package com.javaex.controller.api;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	public GuestbookVo add(@RequestBody GuestbookVo guestbookVo) {
		System.out.println("ApiGuestbookController.add()");
		System.out.println(guestbookVo);

		GuestbookVo gvo = guestbookService.exeAddandGuest(guestbookVo);

		System.out.println(gvo);

		return gvo;
	}

	//삭제
	//@ResponseBody
	//@RequestMapping(value ="/api/guestbooks/delete", method = RequestMethod.POST)
	//public int remove2(@ModelAttribute GuestbookVo guestbookVo) {
		//System.out.println("ApiGuestbookController.remove()");
		//System.out.println(guestbookVo);

		//int count = guestbookService.exeRemove(guestbookVo);
		//System.out.println(count);

		//return count;
	//}

	//삭제
	@ResponseBody
	@RequestMapping(value ="/api/guestbooks/{no}", method = RequestMethod.DELETE)
	public int remove1(@PathVariable("no") int no, @ModelAttribute GuestbookVo guestbookVo) {
		System.out.println("ApiGuestbookController.remove()");
		System.out.println(no);
		System.out.println(guestbookVo);

		int count = guestbookService.exeRemove(guestbookVo);
		System.out.println(count);
		return count;
	}


}
