package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.GuestbookVo;

@Repository
public class GuestbookDao {

	@Autowired
	private SqlSession sqlSession;
	
	//전체 리스트
	public List<GuestbookVo> guestbookSelectList(){
		System.out.println("GuestbookDao.guestbookSelectList()");
		
		List<GuestbookVo> guestbookList = sqlSession.selectList("guestbook.selectList");
		
		return guestbookList;
	}
	
	// 등록
	public int guestbookInsert(GuestbookVo guestbookVo){
		System.out.println("GuestbookDao.guestbookInsert()");
		
		int count = sqlSession.insert("guestbook.insert", guestbookVo);
		return count;
	}
	
	// 삭제
	public int guestbookDelete(GuestbookVo guestbookVo){
		System.out.println("GuestbookDao.guestbookDelete()");
		
		int count = sqlSession.delete("guestbook.delete", guestbookVo);
		return count;
	}
	
	// 방명록 글 저장 ajax  selectKey
	public int insertSelectKey(GuestbookVo guestbookVo) {
		System.out.println("GuestbookDao.insertSelectKey()");
		
		int count = sqlSession.insert("guestbook.insertSelectKey", guestbookVo);
		return count;
	}
	
	//ajax등록
	public int insertSelecKey(GuestbookVo guestbookVo) {
		System.out.println("GuestbookDao.insertSelecKey()");
		
		System.out.println(guestbookVo); //no비워있음
		int count = sqlSession.insert("insertSelectKey",guestbookVo);
		System.out.println(guestbookVo);//no있음
		guestbookVo.getNo();
		
		return count;
	}
	
	//데이터 1개 가져오기 no 1명 데이터 가져오기
	public GuestbookVo gustbookSelectOne(int no) {
		System.out.println("GuestbookDao.gustbookSelectOne()");
		
		GuestbookVo guestbookVo = sqlSession.selectOne("guestbook.selectOne", no);
		return guestbookVo;
	}

}
