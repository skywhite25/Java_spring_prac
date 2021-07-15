<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Server File Info</title>
</head>
<body>
<h1>서버 파일 정보</h1>
<c:forEach items="${uploadFile }" var="mf">
----------------------------<br>
FileName : ${mf.originalFilename }<br>	
FileSize : ${mf.size }<br>	
<img alt="${mf.originalFilename }" src="/upload/${mf.originalFilename }">
<a href="/upload/${mf.originalFilename }" download="${mf.originalFilename }">다운로드</a><br/>
</c:forEach>
</body>
</html>