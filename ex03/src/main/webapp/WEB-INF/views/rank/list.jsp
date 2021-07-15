<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="pageObject" tagdir="/WEB-INF/tags" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리스트</title>
<style type="text/css">
	#image_gallery, .line{
		clear: both;
	}
	.line{
		height: 20px;
	}
</style>
</head>
<body>
<h1>리스트</h1>
<%-- ${list } --%>
<div class="line"></div>
<table class="container">
	<thead>
		<tr>
		<td>123</td>
		</tr>
	</thead>
	<tr>
		<th>순위</th>
		<th>no</th>
		<th>id</th>
		<th>score</th>
		<th>testDate</th>
	</tr>
<c:forEach items="${list }" var="vo">
	<tr class="dataRow">
		<td></td>
		<td>${vo.no }</td>
		<td>${vo.id}</td>
		<td>${vo.score}</td>
		<td><fmt:formatDate value="${vo.testDate }"/></td>
	</tr>
</c:forEach>
</table>
<div class="line"></div>
	<div id="image_gallery">
		 <div class="row">
		 	<c:forEach items="${list }" var="vo" varStatus="vs" >
<!-- 		 		c:forEach 속성 중에서 varStatus="vs" => index나 count를 사용할 수 있는 객체 -->
		 		<c:if test="${(vs.index > 0) && (vs.index % 4 == 0)}">
<!-- 		 			인덱스 번호가 0이상이고 4의 배수이면 한줄(class="row")은 만든다.  -->
		 			${"</div>"} 
		 			${"<div class='row'>"} 
		 		</c:if>
<!-- 		 		BootStrap Grid : 한줄은 12칸으로 나눠서 운영하는 시스템 -->
		 	</c:forEach>
		</div>
		<div class="col-md-3 dataRow">
			<div class="thumbnail">
				<img src="${vo.fileName }"
					style="width: 100%; height: 350px;">
				<div class="caption">
					<p>
						[<span class="no">${vo.no }</span>] ${vo.title }
					</p>
					<div class="row" style="padding: 0 15px;">
						<div class="pull-left">${vo.id }</div>
						<div class="pull-right">
							<fmt:formatDate value="${vo.writeDate }" pattern="yyyy.MM.dd" />
						</div>
					</div>
				</div>
			</div>
		</div>
</div>


<div class="line"></div>
	<c:if test="${!empty login }">
		<div>
			<a href="/image/list.do" class="btn btn-primary">관리</a>
		</div>
	</c:if>
</body>
</html>