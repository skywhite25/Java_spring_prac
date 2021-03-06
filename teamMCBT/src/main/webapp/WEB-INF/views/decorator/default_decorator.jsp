<!-- sitemesh 사용을 위한 설정 파일 -->
<!-- 작성자 : 이영환 -->
<!-- 작성일 : 2020-06-30 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pageObject" tagdir="/WEB-INF/tags"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%
	System.out.println("default_decorator.do [path] : " + request.getContextPath());
request.setAttribute("path", request.getContextPath());
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MCBT :: <decorator:title /></title>
<!-- BootStrap 라이브러리 등록 전체적으로 진행을 했다. filter가 적용이 되면 개별적으로 한것은 다 지워야한다.-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
@font-face {
    font-family: 'CookieRun-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/CookieRun-Regular.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}

header, article, navbar-fixed-bottom {
	text-align: center;
	font-family: CookieRun-Regular;
	font-size: 17px;
}


header, navbar-fixed-bottom {
	background: AntiqueWhite;
}

pre {
	background: white;
	border: 0px;
}

/* Remove the navbar's default margin-bottom and rounded borders */
.navbar {
	margin-bottom: 0;
	border-radius: 0;
}

/* Add a gray background color and some padding to the footer */
.navbar-fixed-bottom {
	background-color: black;
	padding: 25px;
	color: #ddd;
}

.carousel-inner img {
	width: 100%; /* Set width to 100% */
	margin: auto;
	min-height: 200px;
}

/* Hide the carousel text when the screen is less than 600 pixels wide */
@media ( max-width : 600px) {
	.carousel-caption {
		display: none;
	}
}

article {
	min-height: 400px;
	margin-top: 80px; /* 메뉴 부분만큼의 마진 적용*/
	margin-bottom: 80px; /* copyRight 부분*/
}

#welcome {
	color: grey;
	margin: 0 auto;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		<c:if test="${!empty sessionScope.msg}">
		// 메시지 출력 - 등록처리, 수정처리, 삭제처리 후 메시지가 세션에 들어 있으면 출력된다.
		// 0.1초 후에 메시지 출력 - 화면에 내용이 나타나고 나서 경고창을 띄워서 하얀 상태의 화면을 피한다.
		setTimeout(function() {
			alert("${sessionScope.msg}");
		}, 20);
		// 메세지 출력 후 새로고침을 하더라도 다시 메시지가 출력되지 않게 세션의 msg를 지워준다.
		<% session.removeAttribute("msg"); %>
	</c:if>
		
		
		<c:if test ="${!empty login}">
		/*
			getMessageCnt();
			var myVar = setInterval(getMessageCnt, 3000);
			function getMessageCnt(){
				// 서버에 가서 사용자가 받은 새로운 메시지의 갯수를 가져오는 처리
				$("#messageCnt").load("/ajax/getMessageCnt.do",
						function(result, status){
					/// console.log(status);
					if(status=="error"){
						// 로그인 정보 오류가 나는 경우의 처리
						// 실시간으로 실행되고 있는 함수의 시간을 제거해서 멈추게 한다.
						clearTimeout(myVar);
						// 경고를 띄운다.
						alert("세션이 끊겨서 다시 로그인 하셔야 합니다.");
						// 경고의 확인을 누르면 로그인으로 이동시킨다.
						location = "/member/loginForm.do";
						}
					}
				);
			}
		*/
		</c:if>
	});
</script>
<decorator:head />
</head>
<body>
	<header>
		<!-- 		<div><img href="#"/></div> -->
		<nav class="navbar navbar-inverse navbar-fixed-top">
			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target="#myNavbar">
						<span class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="/main/main.do">MCBT</a>
				</div>
				<div class="collapse navbar-collapse" id="myNavbar">
					<ul class="nav navbar-nav">
						<li><a href="${path }/solve/main.do">문제풀기</a></li>
						<li><a href="${path }/rank/list.do">순위</a></li>
						<li><a href="${path }/board/list.do">게시판</a></li>
						<!-- $amp; : &, &lt; : <, &gt; : >. &ndsp; : blank -->
						<li><a href="${path }/tq/list.do">문제출제</a></li>
						<c:if test="${login.gradeNo == 9 }">
						<li><a href="${path }/test/list.do">문제제작</a></li>
						</c:if>
			<li><a href="${path }/member/list.do"><c:if test="${login.gradeNo >= 9 }">회원 페이지</c:if></a><li>
					</ul>
					<!-- 메인 메뉴 부분의 로그인 사용자 정보 -->
					<ul class="nav navbar-nav navbar-right">
						<c:if test="${empty login }">
							<!-- 로그인이 안되어 있는 경우의 메뉴 -->
							<li><a href="${path }/member/writeForm.do"> <span
									class="glyphicon glyphicon-user"></span> 회원가입
							</a></li>
							<li><a href="${path }/member/loginForm.do"><span
									class="glyphicon glyphicon-log-in"></span> Login</a></li>
						</c:if>
						<c:if test="${!empty login }">
							<!-- 로그인이 되어 있는 경우의 메뉴 -->
							<li><a href="${path }/member/view.do?id=${login.id }"> <span class="glyphicon glyphicon-user"></span>
									${login.name } <span class="badge" id="messageCnt">0</span>
							</a></li>
							<li><a href="${path }/member/logout.do"><span
									class="glyphicon glyphicon-log-out"></span> Logout</a></li>
									<!-- 관리자 -->					
						</c:if>
					</ul>
				</div>
			</div>
		</nav>
	</header>
	<article>
		<decorator:body />
	</article>
	<footer
		class="container-fluid text-center navbar navbar-inverse navbar-fixed-bottom">
		<p>team MCBT</p>
	</footer>
</body>
</html>