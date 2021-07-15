<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ tag trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ attribute name="pageObject" required="true"
 type="com.webjjang.util.PageObject" %>
<%@ attribute name="listURI" required="true"
 type="java.lang.String" %>
<%@ attribute name="query" required="false"
 type="java.lang.String" %>

<% request.setAttribute("noLinkColor", "#eee"); %>
<% request.setAttribute("noMove", ""); %>
<% request.setAttribute("nonoMove", ""); %>

<link rel="stylesheet" href="../css/aa.css" type="text/css" media="all" />

<div  class="pagination">
<ul>
  	<li data-page=1>
		<c:if test="${pageObject.page > 1 }">
	  		<a href="${listURI }?page=1&perPageNum=${pageObject.perPageNum}${query}"
	  		  title="" >
	  		  &laquo;
	  		</a>
  		</c:if>
		<c:if test="${pageObject.page == 1 }">
	  		<a href="" onclick="return false;"
	  		 ${noMove }>${cnt}
	  		 &laquo;
	  		</a>
	  	</c:if>
	</li>

	<c:forEach begin="${pageObject.startPage }" end="${pageObject.endPage }" var="cnt">
  	<li ${(pageObject.page == cnt)?"class=\"active\"":"" } 
  	 data-page=${cnt }>
  	 	<!-- 페이지와 cnt가 같으면 링크가 없음 -->
  	 	<c:if test="${pageObject.page == cnt }">
  			<a href="" onclick="return false;"
  			 ${nonoMove }>${cnt}</a>
  	 	</c:if>
  	 	<!-- 페이지와 cnt가 같지 않으면 링크가 있음 -->
  	 	<c:if test="${pageObject.page != cnt }">
  			<a href="${listURI }?page=${cnt }&perPageNum=${pageObject.perPageNum}${query}"
	  		 title="" >${cnt}</a>
  		</c:if>
  	</li>
	</c:forEach>
	<c:if test="${pageObject.page < pageObject.totalPage }">
	  	<li data-page=${pageObject.totalPage }>
	  		<a href="${listURI }?page=${pageObject.totalPage }&perPageNum=${pageObject.perPageNum}${query}"
	  		  title="">
				&raquo;
	  		</a>
	  	</li>
  	</c:if>
	<c:if test="${pageObject.page == pageObject.totalPage }">
	  	<li data-page=${pageObject.totalPage }>
	  		<a href="" onclick="return false;"
	  		 ${noMove }>
	  		 &raquo;
	  		</a>
	  	</li>
  	</c:if>
</ul> 
</div>


