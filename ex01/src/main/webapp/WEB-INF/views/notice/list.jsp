<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <%@ taglib prefix="pageObject" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NOTICE LIST</title>

<!-- BootStrap 라이브러리 등록 - CDN 방식 : sitemesh에서 decorator.jsp에서 한꺼번에 해결-->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
<style type="text/css">
.dataRow:hover{
	background: #eee;
	cursor: pointer;
}
</style> 
<script type="text/javascript">
$(function(){
	// ${(empty msg)? "":"alert('')"} => 내용이 비어있으면 빈 칸이 뜨고 비어있지 않으면 뒤에 "alert('"+= msg +="')"이 뜬다.
	// "alert('"+= msg +="')" -> 삼항연산자 => 그냥 '+'는 숫자가 아니기 때문에 오류발생 -> '+='
	${(empty msg)? "":"alert('"+= msg +="')"}
	
	$(".dataRow").click(function(){
		var no = $(this).find(".no").text();
		
		var query = ${(empty pageObject)?"''":"'&page=" += pageObject.page
				+= "&perPageNum=" += pageObject.perPageNum += "'"};
				
		query += ${(empty pageObject.word)?"''":"'&key=" += pageObject.key
				+= "&word=" += pageObject.word+= "'"};
				
		
		location = "view.do?no=" + no + "&inc=0" + query;
	});
});
</script>
</head>
<body>
<div class="container">
	<h1 class="row">공지사항 목록</h1>
	<form>
			<input name="page" value="1" type="hidden"/>
			<input name="perPageNum" value="${pageObject.perPageNum }" type="hidden"/>
		<div class="input-group">
		<span class="input-group-addon">
			<select name="key">
				<option value="t" ${(pageObject.key == "t")?"selected":"" }>제목</option>			
				<option value="c" ${(pageObject.key == "c")?"selected":"" }>내용</option>			
				<option value="tc" ${(pageObject.key == "tc")?"selected":"" }>제목+내용</option>			
				<option value="all" ${(pageObject.key == "all")?"selected":"" }>모두</option>			
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
	<ul class="list-group">
	<c:if test="${empty list }">
		<!-- 데이터가 존재하지 않는 경우 -->
		<li class="list-group-item">
			데이터가 존재하지 않습니다.
		</li>
	</c:if>
	<c:if test="${!empty list }">
		<c:forEach items="${list }" var="vo">
		<li class="list-group-item dataRow">
			<div>
			<span class="no">${vo.no }</span>.
				${vo.title }
			</div>
			<div>
			<fmt:formatDate value="${vo.startDate }"/>
			</div>
			<div>
			<fmt:formatDate value="${vo.endDate }"/>
			</div>
		</li>
		</c:forEach>
	</c:if>
	</ul>
	<!-- a tag, js : location, 주소입력 ==> get 방식. post 방식은 지정을 해야한다. -->
	<a href="write.do?perPageNum=${pageObject.perPageNum }" class="btn btn-default">등록</a>
	<div>
		<pageObject:pageNav listURI="list.do" pageObject="${pageObject }" query="&key=${pageObject.key }&word=${pageObject.word }"  />
	</div>
</div>
</body>
</html>