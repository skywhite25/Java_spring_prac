<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board View</title>
<!-- BootStrap Library 등록 CDN 방식 : SiteMesh에서 Decorator.jsp에서 한꺼번에 해결 -->
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> -->
<!-- <script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!-- <script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->

<!-- 아이콘 부트스트랩 -->
<script src="https://kit.fontawesome.com/a076d05399.js"></script>

<!-- util.js 포함 : 반드시 reply.js 위에 추가를 해야 함 -->
<script type="text/javascript" src="/js/util.js"></script>

<!-- reply Model JS 포함 -->
<script type="text/javascript" src="/js/reply.js"></script>
	
<style type="text/css">
.title_label {
	border: 2px dotted #ddd;
	color: gray;
}
ul.chat{
	list-style: none;
}
ul.chat > li{
	margin-bottom: 10px; 
}
</style>
<script type="text/javascript">
   $(function() {
//        $(document).keydown(function (e) {
//           if (e.which === 116) {
//               if (typeof event == "object") {
//                   event.keyCode = 0;
//               }
//               return false;
//           } else if (e.which === 82 && e.ctrlKey) {
//               return false;
//           }
//       });
	  // ${(empty msg)? "":"alert('')"} => 내용이 비어있으면 빈 칸이 뜨고 비어있지 않으면 뒤에 "alert('"+= msg +="')"이 뜬다.
	  // "alert('"+= msg +="')" -> 삼항연산자 => 그냥 '+'는 숫자가 아니기 때문에 오류발생 -> '+='
      ${(empty msg)? "":"alert('"+= msg +="')"}

	  // tooltip적용 js
// 	  $('[data-toggle="tooltip"]').tooltip();
	  
   	  // modal안에 삭제 버튼 이벤트
      $("#modal_deleteBtn").click(function() {   
//          alert("Modal_delete");
         $("#modal_form").submit();
      });
      
      // 댓글 처리 JS 부분
      console.log("======================================================================");
      console.log("JS ReplyList Test");
      
      // 전역변수 선언 - $(function(){~~~}); 33번 줄 안에 선언된 함수에서는 공통으로 사용가능
      var no = ${vo.no};
      console.log("JS ReplyList no : " + no);
      var repPage = 1;
      var repPerPageNum = 5;
      var replyUL = $(".chat")
      
      // 글보기를 하면 바로 댓글리스트 호출
      showList();
      
      // function showList() - no, page, perPageNum : 전역변수로 선언되어 있으므로 변수명 사용
      function showList(){
      replyService.list(
    		// 서버에 넘겨 줄 데이터
    		{no:no, repPage:repPage, repPerPageNum:repPerPageNum},
    		// 성공했을 때의 함수, data라는 이름으로 list가 들어온다.
//     		function(list){
    		function(data){
    		
    			// list 데이터 확인
//     			alert("list");
    			// data 데이터 확인 -> JSON 데이터 = [Object object]
    			// 	- data.list / data.pageObject
    			// 문자열로 만들어서 데이터 표시하기 - 눈으로 확인
//     			alert(JSON.stringify(data));
    			var list = data.list;
// 				return;	// 데이터만 확인하고 처리는 하지 않도록 하기 위함    			

    			var str = "";
    			// li tag 생성 --------------
    			// 데이터가 없을 경우의 처리
    			if(!list || list.length == 0){
//     				alert("데이터 없음")
    				str += "<li>데이터가 존재하지 않습니다.</li>"
    			}else{ // 데이터가 있을 경우의 처리
//     				alert("데이터 있음");
    				for(var i = 0; i < list.length; i++){
    					console.log(list[i]);
    					// tag 만들기 - 데이터 한 개당 li tag 하나가 생긴다.
    					str += "<li class='left clearfix' data-rno='"+ list[i].rno +"'>";
    					str += "<div>";
    					str += "<div class='header'>";
    					str += "<strong class='primary-font replyWriterData'>" + list[i].writer + "</strong>";
    					// class="muted" - 글자색을 회색으로 만들어 주는 BS CSS
    					str += "<small class='pull-right text-muted'>"
    						+ replyService.displayTime(list[i].writeDate)
    						+ "</small>";
    					str += "</div>";
    					str += "<p><pre style='background:none;' class='replyContentData'>" + list[i].content + "</pre></p>";
    					str += "<div class='text-right'>";
    					str += "<button class='btn btn-light btn-xs replyUpdateBtn'>수정</button>";
    					str += "<button class='btn btn-light btn-xs replyDeleteBtn'>삭제</button>";
    					str += "</div>";
    					str += "</div>";
    					str += "</li>";
    				}
    			}
    			replyUL.html(str); // 댓글리스트 데이터를 표시
    			// 댓글의 페이지네이션 표시
    			var pageObject = data.pageObject; // 서버에서 넘어오는 데이터에서 pageObject를 꺼냄
    			var str = ajaxPage(pageObject)
    			$("#reply_nav").html(str);
      		 } // function(data)
      	);
   	} // showList()
   	
   	// 댓글 모달창의 전역 변수
   	var replyModal = $("#replyModal");
   	
   	// 댓글 등록 버튼 이벤트 처리 : 댓글의 모달창 정보 조정과 보이게 --------------------------------
   	$("#writeReplyBtn").click(function(){
//    		alert("댓글등록");

		// 댓글 모달창의 제목 변경
		$("#replyModalTitle").text("댓글 작성")
		
		// 작업할 데이터의 입력란을 보이게 안보이게
		$("#replyModal .form-group").show();
		$("#replyRnoDiv").hide();
		
		// 작업할 버튼을 보이게 안보이게
		var footer = $("#replyModal .modal-footer");
		footer.find("button").show();
		footer.find("#replyModalUpdateBtn, #replyModalDeleteBtn").hide()
	
		// reply > Form input 데이터 삭제 -> 이거 안하면 댓글쓰다가 취소해도 댓글창에 작성했던 글이 그냥 남아있어
		// input 중에서 replyno는 제외
		replyModal.find("input, textarea").not("#replyNo").val("");
		
   		replyModal.modal("show");
   	});
   	
   	// 댓글 모달창의 등록 버튼에 대한 이벤트 처리 - 입력된 데이터를 가져와서 JSON 데이터 만들기 - 서버에 전송
   	$("#replyModalWriteBtn").click(function(){
   		var reply = {};	
   		reply.no= $("#replyNo").val();
   		reply.content = $("#replyContent").val();
   		reply.writer = $("#replyWriter").val();
   		reply.pw = $("#replyPw").val();
//    		reply.perPageNum = repPerPageNum;
//    		alert(reply);
//    		alert(JSON.stringify(reply));

		// Ajax를 이용한 댓글 등록 처리
		replyService.write(reply, 
			// 성공했을때의 처리 함수
			function(result){
				alert(result);
				replyModal.modal("hide");
				showList();
		});
   	});
   
   	// 댓글 수정 폼 : 모달 창 열기(replyModal) ---------------------------------
   	// 댓글번호, 내용, 작성자, 비밀번호
   	$(".chat").on("click",".replyUpdateBtn",function(){
//    		alert("수정");
   		// 모달 창 제목 바꾸기
   		$("#replyModalTitle").text("댓글 수정");
   		// 작성 할 데이터 입력란을 보이게/안 보이게 설정
   		$("#replyModal .form-group").show();
   		$("#replyNoDiv").hide();
   		
   		// 작업할 버튼을 보이게/안 보이게
   		var footer= $("#replyModal .modal-footer");
   		footer.find("button").show();
   		footer.find("#replyModalWriteBtn, #replyModalDeleteBtn").hide();
   		
   		// 데이터 수집
   		// 전체 데이터를 포함하고 있는 태그 : li
   		var li = $(this).closest("li");
   		
   		// html tag 안에 속성으로 data-rno="2"값을 넣어 둔 것은 obj.data("rno")로 찾아서 쓴다.
   		var rno = li.data("rno");
		var content= li.find(".replyContentData").text();
		var writer= li.find(".replyWriterData").text();
   		// 데이터 세팅
   		$("#replyRno").val(rno);
   		$("#replyContent").val(content);
   		$("#replyWriter").val(writer);
   		// 비밀번호는 지움
   		$("#replyPw").val("");
   		
		// rno는 사용하지 않기 때문에 보이지 않게 설정
		replyModal.modal("show");
   	});
   	
   	// 모달창 수정 버튼 이벤트 - 수정 처리 ---------------------------
   	$("#replyModalUpdateBtn").click(function(){
//    		alert("수정 처리");
   		// 데이터 수집
   		var reply = {};
   		reply.rno = $("#replyRno").val();
   		reply.content = $("#replyContent").val();
   		reply.writer = $("#replyWriter").val();
   		reply.pw = $("#replyPw").val();
   		
   		// 수집한 데이터 확인
//   		alert(JSON.stringify(reply));
		$("#replyNoDiv, #replyContentDiv, #replyWriterDiv").show();

		// reply.js 안에 있는 replyService.update를 호출해서 실행
   		replyService.update(reply,
   			function(result, status){

//    				alert("성공 : " + status);
   				// 성공 메시지 출력
   				if(status == "notmodified")
   					alert("댓글 수정 실패");
   				else{
	   				alert(result);
	   				// 리스트 다시 표시
	   				showList();
   				}
   			},	
   		
   			function(err, status){
//    				alert("실패 : " + status);
   				// 실패 메시지 출력
   				alert(err);
   			}
   		); // replyService.update()
   		// 모달 창은 숨겨 둔다.
   		replyModal.modal("hide");
   	
   	}); // 	$("#replyModalUpdateBtn").click(function()
  
   	// 댓글 삭제 폼 : 모달 (replyModal) ---------------------------------
   	$(".chat").on("click",".replyDeleteBtn",function(){
//    		alert("삭제");
   	
		// 모달 창 제목 바꾸기
   		$("#replyModalTitle").text("댓글 삭제");
   		
		// 작성 할 데이터 입력란을 보이게/안 보이게 설정
   		$("#replyModal .form-group").show();
// 		alert($("#replyNoDiv"));
// 		$("#replyContentDiv").hide();
//    		$("#replyNoDiv").hide();
//    		$("#replyWriterDiv").hide();
		$("#replyNoDiv, #replyContentDiv, #replyWriterDiv").hide();

   		// 작성 할 데이터 입력란을 보이게/안 보이게 설정
		var footer = $("#replyModal .modal-footer");
		footer.find("button").show();
		footer.find("#replyModalWriteBtn, #replyModalUpdateBtn").hide();
		
		// 댓글 번호 가져오기
		var li = $(this).closest("li");
		var rno = li.data("rno");
		
		// 댓글 번호 셋팅
		$("#replyRno").val(rno);
		
		// 댓글 비밀번호 삭제
   		$("#replyPw").val("");
	
		// 댓글 모달 확인하기
		replyModal.modal("show");
	});
   	
   	// 댓글 삭제 처리
   	$("#replyModalDeleteBtn").click(function(){
//    		alert("삭제");
// 		데이터 수집
		var reply = {};
		reply.rno = $("#replyRno").val();
		reply.pw = $("#replyPw").val();
		
		// reply.js 안에 있는 replyService.delete(reply JSON, 성공함수, 오류함수)
		replyService.delete(reply, 
			function(result, status){
				// status - 비밀번호가 틀려서 삭제가 되지 않으면 "NOT_MODIFIED"
// 				alert("result : " + result + "\nstatus : " + status);
				if(status == "success"){
					alert(result);
					// 성공적으로 삭제를 한 경우는 리스트 재 출력
					showList();
				}else{
					alert("댓글 삭제 실패")
				}
			},
			function(err){
				alert(err);
			}
		);
		replyModal.modal("hide");
   	});
   	
   	// 댓글의 페이지 번호 클릭이벤트 - 태그가 나중에 나옴 -> on()
   	// $(원래 있었던 태그선택)
   	$("#reply_nav").on("click", ".reply_nav_li", 
 		function(){
//  		alert("댓글 페이지네이션 클릭");
			// this => li 태그 안에 있는 class="move"
			if($(this).find("a").hasClass("move")){
// 				alert("페이지로 이동 O");
				repPage = $(this).data("page");
// 				alert(repPage + "페이지로 이동");
				showList();
			}else{
// 				alert("페이지로 이동 X");
			}
			return false;
 		}
   	);
   	
}); // $(function(){...});
</script>
</head>
<body>
	<div class="container">
		<h1>게시판 글 보기</h1>
		<ul class="list-group">
			<li class="list-group-item row">
				<div class="col-md-2 title_label">no</div>
				<div class="col-md-10">${vo.no }</div>
			</li>
			<li class="list-group-item row">
				<div class="col-md-2 title_label">제목</div>
				<div class="col-md-10">${vo.title }</div>
			</li>
			<li class="list-group-item row">
				<div class="col-md-2 title_label">내용</div>
				<div class="col-md-10">
					<pre>${vo.content }</pre>
				</div>
			</li>
			<li class="list-group-item row">
				<div class="col-md-2 title_label">작성자</div>
				<div class="col-md-10">${vo.writer }</div>
			</li>
			<li class="list-group-item row">
				<div class="col-md-2 title_label">작성일</div>
				<div class="col-md-10">
					<fmt:formatDate value="${vo.writeDate }" pattern="yyyy.MM.dd" />
				</div>
			</li>
			<li class="list-group-item row">
				<div class="col-md-2 title_label">조회수</div>
				<div class="col-md-10">${vo.hit }</div>
			</li>
		</ul>
		<a href="update.do?no=${vo.no }&page=${pageObject.page }&perPageNum=${pageObject.perPageNum}&key=${pageObject.key}&word=${pageObject.word}" class="btn btn-primary">수정</a>
		<a class="btn btn-primary" onclick="return false;"
		data-toggle="modal" data-target="#delete" >삭제</a>
		<a href="list.do?page=${pageObject.page }&perPageNum=${pageObject.perPageNum}&key=${pageObject.key}&word=${pageObject.word}" class="btn btn-primary">리스트</a>

<!-- 	댓글의 시작 -->
<div class="row">
	<div class="col-lg-12" style="margin-top: 20px; ">
		<div class="panel panel-info">
		    <div class="panel-heading">
		    	<i class="fas fa-cat"> - 댓글</i>
		    	<button id="writeReplyBtn" class="btn btn-primary btn-xs pull-right">새 댓글</button>
		    </div>
     		<div class="panel-body">
     			<ul class="chat">
<!-- 					데이터가 있는 만큼 반복처리, li tag 생성 -->
<!-- 					rno를 표시하지 않고 태그 안에 속성으로 숨겨 놓음 data-rno="12" -->
					<li class="left clearfix" data-rno="12">
						<div>
							<div class="header">
								<strong class="primary-font">김태훈</strong>
								<small class="pull-right text-muted">2021.04.21 14:12</small>
							</div>
							<p>요</p>
							<div class="text-right">
								<button class="btn btn-light btn-xs replyUpdateBtn">수정</button>
								<button class="btn btn-light btn-xs replyDeleteBtn">삭제</button>
							</div>
						</div>
					</li>
     			</ul>
     		</div>
<!-- 		댓글 panel-body의 끝 -->
		<div class="panel-footer">
			<ul class="pagination" id="reply_nav">
				<li><a href="">1</a></li>
				<li class="active"><a href="">2</a></li>
			</ul>
		</div>
		</div>
<!-- 		댓글 panel의 끝 -->
	</div>
</div>
</div>
<!-- container의 끝	 -->
<!-- 댓글 끝 -->
	
	
<!-- 	Modal - 게시판 글삭제 시 사용되는 모달 창 -->
	<div class="modal fade" id="delete" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"></button>
					<h4 class="modal-title">게시판 글 삭제 비밀번호 입력</h4>
				</div>
<!-- 	Modal - 게시판 글삭제 시 사용되는 모달 창의 끝 -->
				<div class="modal-body">
					<form action="delete.do" method="post" id="modal_form">
						<input type="hidden" name="no" value="${vo.no }">	
						<input type="hidden" name="perPageNum" value="${pageObject.perPageNum }">
						<div class="form-group">
							<label for="pw">비밀번호:</label> <input class="form-control"
								name="pw" id="pw" type="password" pattern="[^가-힣ㄱ-ㅎㅏ-ㅣ]{4,20}"
								required="required" maxlength="20" title="한글은 입력할 수 없습니다.">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="modal_deleteBtn">삭제</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal -->
	<div id="replyModal" class="modal fade" role="dialog">
		<div class="modal-dialog">
			<!-- 댓글 작성 모달 창-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title"><i class="fas fa-cat"></i>
					<span id="replyModalTitle">댓글 작성</span></h4>
				</div>
				<div class="modal-body">
					<form>
						<div class="form-group" id="replyRnoDiv">
							<label for="replyRno">번호</label> <input name="rno" type="text"
								class="form-control" id="replyRno" readonly="readonly">
						</div>
						<div class="form-group" id="replyNoDiv">
							<label for="replyNo">게시판번호</label> <input name="no" type="text"
								class="form-control" id="replyNo" readonly="readonly" value="${vo.no }">
						</div>
						<div class="form-group" id="replyContentDiv">
							<label for="replyContent">내용</label>
							<textarea rows="5" name="replyContent"  class="form-control" required="required" id="replyContent"></textarea>
						</div>
						<div class="form-group" id="replyWriterDiv">
							<label for="replyWriter" id="replyWriterDiv">이름</label>
							<input type="text" class="form-control" id="replyWriter" name="replyWriter"
							required="required" pattern="[A-Za-z가-힣][A-Za-z가-힣0-9]{1,9}">
						</div>
						<div class="form-group" id="replyPwDiv">
							<label for="replyPw">비밀번호</label>
							<input type="text" class="form-control" id="replyPw" name="replyPw"
							required="required" pattern=".{4,20}">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="replyModalWriteBtn">등록</button>
					<button type="button" class="btn btn-primary" id="replyModalUpdateBtn">수정</button>
					<button type="button" class="btn btn-primary" id="replyModalDeleteBtn">삭제</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
				</div>
			</div>

		</div>
	</div>
</body>
</html>