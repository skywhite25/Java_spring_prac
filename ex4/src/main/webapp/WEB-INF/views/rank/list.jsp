<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
table {
	font-family: arial, sans-serif;
	border-collapse: collapse;
	width: 100%;
}

td, th {
	border: 1px solid #eee;
	text-align: left;
	padding: 8px;
}

tr:nth-child(even) {
	background-color: #eeeeee;
}
</style>
<meta charset="UTF-8">
<title>리스트</title>
<style type="text/css">
#image_gallery, .line {
	clear: both;
	padding: 50px;
	}

.line {
	height: 20px;
}
</style>
<script type="text/javascript">
$(function(){
	$(document).ready(function(){

	var month = $("#list_month").val();		
	
	$("#list_month").change(function(){
		location = "list.do?date=" + $(this).val() + "-01";
	});
	$("#list_lev").change(function(){
// 		location = "list.do?date=" + $("month").val() + "-01" + "&lev=" + $(this).val();
		location = "list.do?lev=" + $(this).val();
	});
	});
});
</script>
</head>
<body>
<h1>리스트</h1>
<div style="padding: 10px;">
	<div class="pull-right form-inline">
		<label>난이도</label>
			<select class="form-control" id="list_lev">
				<option value="">선택</option>
				<option ${(lev == 3)?"selected":"" } value="1">상</option>
				<option ${(lev == 2)?"selected":"" } value="2">중</option>
				<option ${(lev == 1)?"selected":"" } value="3">하</option>
			</select>
	</div>
</div>
<div class="pull-left form-inline">
	<input type="month" id="list_month">
</div>
 
<div class="line"></div>
<table class="container">
<!-- 검색 -->
	<div>
	<h1 class="row">게시판 목록</h1>
		<form>
			<input name="page" value="1" type="hidden"/>
			<input name="perPageNum" value="${pageObject.perPageNum }" type="hidden"/>
		<div class="input-group">
		<span class="input-group-addon">
			<select name="key">
				<option value="t" ${(pageObject.key == "i")?"selected":"" }>아이디</option>			
			</select>
		</span>
		    <input type="text" class="form-control" placeholder="Search" name="word" value="${pageObject.word }">
		    <div class="input-group-btn">
		      <button class="btn btn-default" type="submit">
		        <i class="glyphicon glyphicon-search"></i>
		      </button>
		    </div>
		  </div>
		</form>
	</div>	
	<tr>
<!-- 		<th>rno</th> -->
		<th>순위</th>
<!-- 		<th>no</th> -->
<!-- 		<th>lev</th> -->
		<th>아이디</th>
		<th>점수</th>
		<th>테스트시간</th>
	</tr>
	<c:forEach items="${list }" var="vo" varStatus="status">
		<tr>
<%-- 			<c:forEach var="i" begin="1" end="10" varStatus="loop"> --%>
<%-- 			<c:if test="${loop.first }"> --%>
<%-- 			<td><c:out value = "${i }"/><p><td> --%>
<%-- 			</c:if> --%>
<%-- 			</c:forEach> --%>
<%-- 			<td>${vo.no }</td> --%>
<%-- 			<td>${vo.lev }</td> --%>
<%-- 			<c:forEach items="${rank }" var="vo"> --%>
			<td>${status.count }</td>
<%-- 				<td>${vo.rno }</td> --%>
<%-- 			</c:forEach> --%>
			<td>${vo.id}</td>
			<td>${vo.score}</td>
			<td><fmt:formatDate value="${vo.testDate }" /></td>
		</tr>
	</c:forEach>
</table>
<div class="line"></div>
	<div id="image_gallery">
	 <div class="row">
	 	<c:forEach items="${ilist }" var="vo" varStatus="vs" >
	 		<!-- c:forEach 속성 중에서 varStatus="vs" => index나 count를 사용할 수 있는 객체 -->
	 		<c:if test="${(vs.index > 0) && (vs.index % 3 == 0)}">
	 			<!-- 인덱스 번호가 0이상이고 4의 배수이면 한줄(class="row")을 만든다.  -->
	 			${"</div>"} 
	 			${"<div class='row'>"} 
	 		</c:if>
	 		<!-- BootStrap Grid : 한줄은 12칸으로 나눠서 운영하는 시스템 -->
		  <div class="col-md-3 dataRow">
		    <div class="thumbnail">
		        <img src="${vo.fileName }" alt="Lights" style="width:100%; height: 350px;">
		        <div class="caption">
		          <p>[<span class="no">${vo.no }</span>] ${vo.title }</p>
		          <div class="row" style="padding : 0 15px;">
			          <div class="pull-left">${vo.id }</div>
			          <div class="pull-right">
			          	<fmt:formatDate value="${vo.writeDate }" pattern="yyyy.MM.dd" />
			          </div>
		          </div> 
		        </div>
		    </div>
		  </div>
		  <!-- 썸네일 종료 -->
	  </c:forEach>
	</div>
</div>
<div class="line"></div>
<textarea rows="3" cols="200" style="padding : 40px; margin: 40px;">123123</textarea>
<div class="line"></div>
<c:if test="${!empty login }">
	<div style=" margin: 40px;">
		<a href="/image/list.do" class="btn btn-primary">관리</a>
	</div>
</c:if>
</body>
</html>