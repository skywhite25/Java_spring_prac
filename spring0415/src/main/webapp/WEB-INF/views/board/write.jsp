<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!--  <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<!--   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> -->
<!--   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!--   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->
<title>게시판 글쓰기 폼</title>
<script type="text/javascript">
$(function(){
	$("#back").click(function(){
		history.back();
	});
});
</script>
</head>
<body>
<div class="container">
	<h1>게시판 글쓰기</h1>
	<form action="write.do" method="post">
		<div class="form-group">
			<label for="title">제목</label>
			<input name="title" class="form-control" id="title" required="required">
		</div>	
		<div class="form-group">
			<label for="content">내용</label>
			<textarea rows="7" name="content" class="form-control" id="content" required="required"></textarea>
		</div>	
		<div class="form-group">
			<label for="writer">작성자</label>
			<input name="writer" class="form-control" id="writer" required="required">
		</div>	
	<button class="btn btn-default">등록</button>
	<button type="reset" class="btn btn-default">새로입력</button>
	<button type="button" class="btn btn-default" id="back">취소</button>
	</form>
</div>
</body>
</html>