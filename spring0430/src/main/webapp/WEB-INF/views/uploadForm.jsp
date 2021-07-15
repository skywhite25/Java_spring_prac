<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>File Upload</title>
</head>
<body>
<h1>파일 올릴거에요</h1>
<form action="uploadFormAction" method="post" enctype="multipart/form-data">
<!-- multiple -> 여러 파일 동시 업로드 가능 -->
첨부파일 <input type="file" name="uploadFile" multiple="multiple"><br>
<button>전송</button>
</form>
</body>
</html>