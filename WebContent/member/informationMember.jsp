<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<html>
<head>
<link rel="stylesheet" href="../resources/css/bootstrap.min.css" />
<%
	String sessionId = (String) session.getAttribute("sessionId");
%>
<sql:setDataSource var="dataSource"
	url="jdbc:mysql://localhost:3307/JSPProjectDB"
	driver="com.mysql.jdbc.Driver" user="root" password="6868" />

<sql:query dataSource="${dataSource}" var="resultSet">
   SELECT * FROM MEMBER WHERE ID=?
   <sql:param value="<%=sessionId%>" />
</sql:query>	
<title>회원 수정</title>
</head>
<body onload="init()">
	<jsp:include page="/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">회원 정보</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">

			<div class="col-md-4">
				<p><a href="./updateMember.jsp" class="btn btn-warning" role="button"> 회원정보 수정 </a>
				<p><p><a href="/JSPProject/inquiryOrder.jsp" class="btn btn-info" role="button"> 주문내역 조회 </a>
			</div>
		</div>
		<hr>
	</div>
</body>
</html>