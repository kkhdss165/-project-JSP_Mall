<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<link rel = "stylesheet"	href = "./resources/css/bootstrap.min.css">
<title>JSP_MALL(since2021)</title>
</head>
<body>
	<jsp:include page = "menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">관리자 메뉴</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">

			<div class="col-md-4">
				<p><a href="./addProduct.jsp" class="btn btn-warning" role="button"> 상품 추가 </a>
				<a href="./addStock.jsp" class="btn btn-warning" role="button"> 재고 추가 </a>
				<p><a href="./editProduct.jsp?edit=update" class="btn btn-info" role="button"> 상품 수정 </a>
				<a href="./editStock.jsp?edit=update" class="btn btn-info" role="button"> 재고 수정 </a>
				<p><a href="./editProduct.jsp?edit=delete" class="btn btn-secondary" role="button"> 상품 제거 </a>
				<a href="./editStock.jsp?edit=delete" class="btn btn-secondary" role="button"> 재고 삭제 </a>
			</div>
		</div>
		<hr>
	</div>
	<jsp:include page = "footer.jsp" />
</body>
</html>