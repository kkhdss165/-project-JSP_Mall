<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%
	String sessionId = (String) session.getAttribute("sessionId");
%>
<nav class = "navbar navbar-expand	navbar-dark bg-dark">
	<div class = "contanier">
		<div  align ="left" class = "navbar-header">
			<a style="float:left;" class = "navbar-brand" href ="<c:url value='/welcome.jsp' />">JSP_MALL</a>
		</div>
		<div>
			<ul class="navbar-nav mr-auto" >
				<li class="nav-item"><a class="nav-link" 
				href ="<c:url value='/cart.jsp' />">장바구니</a></li>
				<c:choose>
					<c:when test="${empty sessionId}">
						<li class="nav-item"><a class="nav-link" 
						href = "<c:url value='/member/loginMember.jsp' />">로그인</a></li>

					</c:when>
					<c:otherwise>
						<li style ="padding-top: 7px; color:white">[<%=sessionId %>님]</li>
						<li class="nav-item"><a class="nav-link" 
						href ="<c:url value='/member/logoutMember.jsp' />">로그아웃</a></li>
						<li class="nav-item"><a class="nav-link" 
						href ="<c:url value='/member/informationMember.jsp' />">회원 정보</a></li>
					</c:otherwise>
				</c:choose>
				<li class="nav-item"><a class="nav-link" 
				href ="<c:url value='/products.jsp' />">상품 목록</a></li>
				<li class="nav-item"><a class="nav-link" 
				href ="<c:url value='/administrator.jsp' />">관리자 메뉴</a></li>
			</ul>
		</div>
	</div>
</nav>