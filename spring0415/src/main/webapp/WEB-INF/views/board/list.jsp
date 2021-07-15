<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <%@taglib prefix="pageObject" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" content="width=device-width, initial-scale=1"> 
<!--   <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<!--   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> -->
<!--   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!--   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->
<title>게시판 리스트</title>
<style type="text/css">
.dataRow:hover{
	background: #eee;
	cursor: pointer;
}
</style>
</head>
<body>
<div class="container">
<h1>게시판 리스트</h1>
<table class="table">
<thead>
<tr>
	<th>글번호</th>
	<th>제목</th>
	<th>작성자</th>
	<th>작성일</th>
	<th>조회수</th>
</tr>
</thead>
<tbody>
<c:forEach items="${list }" var="vo">
	<tr class="dataRow" onclick="location='view.do?no=${vo.no }'">
		<td>${vo.no }</td>
		<td>${vo.title}</td>
		<td>${vo.writer }</td>
		<td><fmt:formatDate value="${vo.writeDate }" pattern="yyyy년 MM월 dd일"/></td>
		<td>${vo.hit }</td>
	</tr>
</c:forEach>
</tbody>
<tfoot>
<tr>
<td colspan="5">
<a href="write.do?perPageNum=${pageObject.perPageNum }" class="btn btn-primary">글쓰기</a>
</td>
</tr>
</tfoot>
</table>
</div>
</body>
</html>