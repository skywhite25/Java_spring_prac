<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board update</title>

<!-- BootStrap 라이브러리 등록 - CDN 방식 : sitemesh에서 decorator.jsp에서 한꺼번에 해결-->
<!--   <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<!--   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> -->
<!--   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!--   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->
  
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
<h1>게시판 글수정 폼</h1>
  <form action="update.do" method="post">
	<input name="page" type="hidden" value="${param.page }" /> 
	<input name="perPageNum" type="hidden" value="${param.perPageNum}" /> 
	<input name="key" type="hidden" value="${param.key}" /> 
	<input name="word" type="hidden" value="${param.word}" /> 
	<div class="form-group">
		<label for="no">번호</label> <input name="no" type="text"
			class="form-control" id="no" value="${vo.no }" readonly="readonly">
	</div>
	<div class="form-group">
      <label for="title">제목</label>
	<!-- pattern=".{4,100}" => 정규표현식(4자이상 100자 미만) -> 구글링 -->      
	<!-- placeholder : 입력 칸 안내 -->      
	<!-- required : 필수 입력 -->      
	<!-- title : 패턴이 맞지 않을 때 같이 나오는 메시지 -->      
      <input name="title" type="text" class="form-control" id="title"
      pattern=".{4,100}" maxlength="100" required="required" title="4자이상 100자 이하 입력" placeholder="4자이상 100자 이하 입력" value="${vo.title }">
    </div>
	<div class="form-group">
		<label for="content">내용</label>
		<textarea name="content" class="form-control" rows="5" id="content" placeholder="4자이상 1000자 이하 입력">${vo.content }</textarea>
	</div>
    <div class="form-group">
      <label for="writer">작성자</label>
      <input name="writer" type="text" class="form-control" id="writer" required="required" 
      pattern="[A-Za-z가-힣][0-9A-Za-z가-힣]{1,9}" placeholder="이름은 2자부터 10자까지 가능" title="이름은 2자부터 10자까지 가능" required="required" value="${vo.writer }">
      <!-- pattern="[A-Za-z 가-힣]" => 앞 자리가 알파벳과 한글만 가능(정규표현식) -->
      <!-- pattern="~~[0-9A-Za-z가-힣]{1,9}" => 뒤 자리부터는 알파벳과 한글만 가능 9글자까지(정규표현식) -->
    </div>
	<div class="form-group">
      <label for="pw">비밀번호 : 본인 확인용</label>
      <input name="pw" type="password" class="form-control" id="pw" 
      pattern="[^가-힣^ㄱ-ㅎ]{4,20}" required="required" placeholder="4자부터 20자까지 가능" title="한글은 입력할 수 없습니다.">
      <!-- pattern="[^가-힣^ㄱ-ㅎ]{4,20}" => 한글을 사용불가, 4자부터 20자까지 가능(정규표현식) -->
    </div>
    <button class="btn btn-default">등록</button>
    <button type="reset" class="btn btn-default">취소</button>
    <button type="button" class="btn btn-default cancelBackBtn">뒤로가기</button>
  </form>
</div>
</body>
</html>