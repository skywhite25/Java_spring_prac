<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- BootStrap Library 등록 CDN 방식 : SiteMesh에서 Decorator.jsp에서 한꺼번에 해결 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<style type="text/css">
.title_label {
	border: 1px dotted #ddd;
}
</style>
<script type="text/javascript">
$(function() {	 
		// ${(empty msg)? "":"alert('')"} => 내용이 비어있으면 빈 칸이 뜨고 비어있지 않으면 뒤에 "alert('"+= msg +="')"이 뜬다.
	  // "alert('"+= msg +="')" -> 삼항연산자 => 그냥 '+'는 숫자가 아니기 때문에 오류발생 -> '+='
      ${(empty msg)? "":"alert('"+= msg +="')"}

      $("#modal_Btn").click(function() {   // modal안에 삭제 버튼 이벤트
         alert("Modal_delete");
         $("#modal_form").submit();
      });
});
</script>

<title>Notice View</title>
</head>
<body>
	<div class="container">
		<h1>공지사항 글보기</h1>
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
				<div class="col-md-2 title_label">공지시작일</div>
				<div class="col-md-10">
					<fmt:formatDate value="${vo.startDate }" pattern="yyyy.MM.dd hh:mm" />
				</div>
			</li>
			<li class="list-group-item row">
				<div class="col-md-2 title_label">공지종료일</div>
				<div class="col-md-10">
					<fmt:formatDate value="${vo.endDate }" pattern="yyyy.MM.dd hh:mm" />
				</div>
			</li>
		</ul>
		<a href="update.do?no=${vo.no }&page=${pageObject.page }&perPageNum=${pageObject.perPageNum}&key=${pageObject.key}&word=${pageObject.word}" class="btn btn-default">수정</a>
		<button class="btn btn-default" data-toggle="modal"
			data-target="#delete">삭제</button>
		<a href="list.do?page=${pageObject.page }&perPageNum=${pageObject.perPageNum}&key=${pageObject.key}&word=${pageObject.word}" class="btn btn-default">리스트</a>
	</div>
	<div class="modal fade" id="delete" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"></button>
					<h4 class="modal-title">공지사항 글을 삭제하시겠습니까?</h4>
				</div>
				<div class="modal-body">
					<form action="delete.do" method="post" id="modal_form">
					<input type="hidden" name="no" value="${vo.no }">	
						<input type="hidden" name="perPageNum" value="${pageObject.perPageNum }">
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" id="modal_Btn">삭제</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>