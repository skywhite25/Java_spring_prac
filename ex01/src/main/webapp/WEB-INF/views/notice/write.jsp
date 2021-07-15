<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice Write</title>

<!-- BootStrap 라이브러리 등록 - CDN 방식 : sitemesh에서 decorator.jsp에서 한꺼번에 해결-->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
<script type="text/javascript">
$(function(){
	$(".cancelBackBtn").click(function(){
		history.back();
	});
});
</script>  
  
</head>
<body>
<div class="container">
<h1>공지사항 글쓰기 폼</h1>
  <form action="write.do" method="post">
    <div class="form-group">
      <label for="title">제목</label>
    </div>
      <input name="title" type="text" class="form-control" id="title"
      pattern=".{4,100}" maxlength="100" required="required" title="4자이상 100자 이하 입력" placeholder="4자이상 100자 이하 입력">
	<!-- pattern=".{4,100}" => 정규표현식(4자이상 100자 미만) -> 구글링 -->      
	<!-- placeholder : 입력 칸 안내 -->      
	<!-- required : 필수 입력 -->      
	<!-- title : 패턴이 맞지 않을 때 같이 나오는 메시지 -->      
	<div class="form-group">
		<label for="content">내용</label>
		<textarea name="content" class="form-control" rows="5" id="content" placeholder="4자이상 1000자 이하 입력"></textarea>
	</div>
    <div class="form-group">
      <label for="startDate">공지시작일</label>
      <input name="startDate" type="date" class="form-control" id="startDate" required="required">
    </div>
    <div class="form-group">
      <label for="endDate">공지종료일</label>
      <input name="endDate" type="date" class="form-control" id="endDate" required="required">
    </div>
    
    <button class="btn btn-default">등록</button>
    <button type="reset" class="btn btn-default">취소</button>
    <button type="button" class="btn btn-default cancelBackBtn">뒤로가기</button>
  </form>
</div>
</body>
</html>