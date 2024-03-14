<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${pageContext.request.contextPath}/assets/css/mysite.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/assets/css/guestbook.css" rel="stylesheet" type="text/css">

<!-- Axios 라이브러리 포함 -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<style>
	.modal{
		display: block;
	}
	.modal .modal-content{
		width: 818px;
		border: 1px solid #000000;
	}
</style>

</head>

<body>
	<div id="wrap">

		<!-- header+nav -->
		<c:import url="/WEB-INF/views/include/header.jsp"></c:import>
		<!-- //header+nav -->
	
		<div id="container" class="clearfix">
			<div id="aside">
				<h2>방명록</h2>
				<ul>
					<li>일반방명록</li>
					<li>ajax방명록</li>
				</ul>
			</div>
			<!-- //aside -->

			<div id="content">
				
				<div id="content-head" class="clearfix">
					<h3>일반방명록</h3>
					<div id="location">
						<ul>
							<li>홈</li>
							<li>방명록</li>
							<li class="last">일반방명록</li>
						</ul>
					</div>
				</div>
				<!-- //content-head -->

				<div id="guestbook">
					<form id="guestForm" action="${pageContext.request.contextPath}/guestbook/ajaxindex" method="get">
						<table id="guestAdd">
							<colgroup>
								<col style="width: 70px;">
								<col>
								<col style="width: 70px;">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<th><label class="form-text" for="input-uname">이름</label></td>
									<td><input id="input-uname" type="text" name="name"></td>
									<th><label class="form-text" for="input-pass">패스워드</label></td>
									<td><input id="input-pass"type="password" name="password"></td>
								</tr>
								<tr>
									<td colspan="4"><textarea name="content" cols="72" rows="5"></textarea></td>
								</tr>
								<tr class="button-area">
									<td colspan="4" class="text-center"><button id=btnadd type="submit">등록</button></td>
								</tr>
							</tbody>
							
						</table>
						<!-- //guestWrite -->
						
					</form>
					
					<!-- 모달 창 컨텐츠 -->
               <div id="myModal" class="modal">
                  <div id="guestbook" class="modal-content">
                     <div class="closeBtn">×</div>
                     <div class="m-header">
                        패스워드를 입력하세요
                     </div>
                     <div class="m-body">
                        <input class="m-password" type="password" name="password" value=""><br>
                        <input class="m-no" type="text" name="no" value="">
                     </div>
                     
                     <div class="m-footer">
                        <button class="btnDelete" type="button">삭제</button>
                     </div>
                  </div>
               </div>
						
					<div id="guestbookListArea">
					<!-- 
						<table class="guestRead">
							<colgroup>
								<col style="width: 10%;">
								<col style="width: 40%;">
								<col style="width: 40%;">
								<col style="width: 10%;">
							</colgroup>
							<tr>
								<td>${guestbookVo.no}</td>
								<td>${guestbookVo.name}</td>
								<td>${guestbookVo.regDate}</td>
								<td><a href="${pageContext.request.contextPath}/guestbook/deleteform?no=${guestbookVo.no}">[삭제]</a></td>
							</tr>
							<tr>
								<td colspan=4 class="text-left">${guestbookVo.content}</td>
							</tr>
						</table> -->
						<!-- //guestRead -->
					
					</div>
				</div>
				<!-- //guestbook -->
			
			</div>
			<!-- //content  -->
		</div>
		<!-- //container  -->

		<!-- //footer -->
		<c:import url="/WEB-INF/views/include/footer.jsp"></c:import>
		<!-- //footer -->
		
	</div>
	<!-- //wrap -->

</body>

<script>
//DOM tree 생성되었을때
document.addEventListener("DOMContentLoaded", function(){
	
	//돔트리가 생성완료 
	//리스트요청 데이타만 받을거야
	axios({
		method: 'get',           // put, post, delete                   
		url: '${pageContext.request.contextPath}/api/guestbooks',
    	headers: {"Content-Type" : "application/json; charset=utf-8"}, //전송타입
        //params: guestbookVo,  //get방식 파라미터로 값이 전달
        //data: guestbookVo,   //put, post, delete 방식 자동으로 JSON으로 변환 전달

        responseType: 'json' //수신타입	
	}).then(function (response) {
	   	//console.log(response); //수신데이타
		//console.log(response.data); //수신데이타

		//리스트자리에
		//글을 추가한다
		for(let i=0; i<response.data.length; i++){
			let guestVo  = response.data[i];
			render(guestVo,"down"); //1개의 글을 render()에게 전달 --> render() 리스트위치에 그린다
		}
		
		
	}).catch(function (error) {
	   console.log(error);
	});
	
	//등록버튼 클릭했을때(데이터만 받을꺼야)///////////////////////
	let guestForm = document.querySelector("#guestForm");
	console.log("guestForm");
	
	guestForm.addEventListener("submit", function(){
		event.preventDefault();
		console.log("글쓰기버튼 클릭");
		
		//폼의데이터수집
		let name = document.querySelector('[name="name"]').value;
		let password = document.querySelector('[name="password"]').value;
		let content = document.querySelector('[name="content"]').value;
		
		let guestVo = {
			name: name,
			password: password,
			content: content
		};
		console.log(guestVo);
		
		//서버로 데이터 전송
	axios({
		method: 'post', // put, post, delete
		url: '${pageContext.request.contextPath}/api/guestbooks',
		headers: {"Content-Type" : "application/json; charset=utf-8"}, //전송타입
		params: guestVo, //get방식 파라미터로 값이 전달
		//data: guestbookVo, //put, post, delete 방식 자동으로 JSON으로 변환 전달
			
		responseType: 'json' //수신타입
	}).then(function (response) {
		console.log(response); //수신데이타
		console.log(response.data);
		let guestbookVo = response.data
			
		//그리기
		render(guestbookVo, "up");
			
		//폼비우기
		event.preventDefault();
			
	}).catch(function (error) {
		console.log(error);
	});
		
		
	});//guestForm.addEventListener
	
	//모달창 호출 버튼을 클릭했을때
	let guestbookListArea = document.querySelector("#guestbookListArea");
	guestbookListArea.addEventListener("click",function(event){
		console.log(event.target.tagName);
		
		if(event.target.tagName=="BUTTON"){
			
			/*
			console.log("모달창 보이기");
			let modal = document.querySelector(".modal");
			modal.style.display = "block";
			*/
			
			//hidden 의 value-> no값 입력
			let noTag = document.querySelector('[name="no"]');
			noTag.value = event.target.dataset.no;
			
			
		}
		
			
	});
	
	//모달창에 삭제버튼을 클릭했을때
	let btnDelete = document.querySelector('.btnDelete');
	btnDelete.addEventListener("click",function(event){
		console.log("클릭");
		
		let no = document.querySelector('.m-no').value;
		let password = document.querySelector('.m-password').value;
		
		//데이터모으고
		let guestbookVo={
			no: no,
			password: password
		}
		console.log(guestbookVo);
		//서버로 전송// /*url/api/guestbooks/delete post*/
		
		axios({
			method: 'post', // put, post, delete
			url: '${pageContext.request.contextPath}/api/guestbooks/delete',
			headers: {"Content-Type" : "application/json; charset=utf-8"}, //전송타입
			params: guestbookVo, //get방식 파라미터로 값이 전달
			//data: guestbookVo, //put, post, delete 방식 자동으로 JSON으로 변환 전달
			
			responseType: 'json' //수신타입
		}).then(function (response) {
			console.log(response); //수신데이타
		
		}).catch(function (error) {
			console.log(error);
		});
		
		
		
	});//document.addEventDelete
	
	
	
	

	
});//document.addEventListener


		
///////함수들////////////

//방명록 글 그리기 //up //down
function render(guestbookVo, dir){
	//console.log("render()");
	//console.log(guestbookVo);
	
	let guestbookListArea = document.querySelector("#guestbookListArea");

	let str='';
	str+=' <table class="guestRead"> ';
	str+=' 		<colgroup> ';
	str+='			<col style="width: 10%;"> ';
	str+='			<col style="width: 40%;"> ';
	str+='			<col style="width: 40%;"> ';
	str+='			<col style="width: 10%;"> ';
	str+='		</colgroup> ';
	str+='		<tr> ';
	str+='			<td>'+ guestbookVo.no +'</td> ';
	str+='			<td>'+ guestbookVo.name +'</td> ';
	str+='			<td>'+ guestbookVo.regDate +'</td> ';
	str+='			<<td><button class="btnModal" type="button" data-no="'+ guestbookVo.no +'">삭제</button></td> ';
	str+='		</tr> ';
	str+='		<tr> ';
	str+='			<td colspan=4 class="text-left">'+ guestbookVo.content +'</td> ';
	str+='		</tr> ';
	str+=' </table> ';
	
	if(dir == "down"){
		guestbookListArea.insertAdjacentHTML("beforeend",str);
	}else if(dir == "up"){
		guestbookListArea.insertAdjacentHTML("afterbegin",str);
	}else{
		console.log("방향체크");
	}
	
}

</script>

</html>