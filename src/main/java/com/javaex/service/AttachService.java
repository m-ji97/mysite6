package com.javaex.service;

import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.vo.AttachVo;

@Service
public class AttachService {
	
	public String exeupload(MultipartFile file) {
		System.out.println("AttachService.exeupload()");
		
		//파일저장 폴더
		String seveDir = "c:\\javaStudy\\upload";
		
		//(0)파일관련 정보수집
		//	 오리지날 파일명
		String orgName = file.getOriginalFilename();
		System.out.println("orgName: "+ orgName);
		//	 확장자
		String exName = orgName.substring(orgName.lastIndexOf("."));
		System.out.println("exName: "+ exName);
		//System.out.println(orgName.substring(4));
		//System.out.println(orgName.lastIndexOf(".")); //점의 위치
		//	 저장 파일명(겹치지 않아야 한다)
		String saveName = System.currentTimeMillis() + UUID.randomUUID().toString() + exName;
		System.out.println("saveName: "+saveName);
		//	 파일 사이즈
		long fileSize = file.getSize();
		System.out.println("fileSize: "+fileSize);
		//	 파일 전체 경로(저장파일명 포함)
		String filePath = seveDir + "\\" + saveName;
		System.out.println("filePath: "+filePath);
		
		
		//(1)파일정보를 db에 저장
		//	 vo로 묶어주고
		AttachVo attachVo = new AttachVo(orgName, saveName, filePath, fileSize);
		//	 db에 저장
		//   dao의 메소드 호출해서 저장-> 만들어볼것
		
		//(2)파일을 하드디스크에 저장
		//	 파일저장
		//오전 02:08:10부터 다시시작
		
		return "";
	}

}
