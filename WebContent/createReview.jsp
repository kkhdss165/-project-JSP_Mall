<%@ page contentType="text/html; charset=UTF-8"%>

<%@ page import="java.sql.*"%>
<%@ page errorPage="exceptionNoProductId.jsp" %>
<jsp:useBean id ="productDAO" class="dao.ProductRepository" scope="session" />
<html>
<head>
<link rel = "stylesheet"	href = "./resources/css/bootstrap.min.css">
<title>JSP_MALL(since2021)</title>

</head>
<body>
	<jsp:include page = "menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">리뷰 작성</h1>
		</div>
	</div>
	<%@include file ="dbconn.jsp" %>
	<%
		String o_id = "";
		String id = "";
		String p_id = "";
		String p_size = "";
		
		o_id = request.getParameter("o_id");
		id = request.getParameter("id");
		p_id = request.getParameter("p_id");
		p_size = request.getParameter("p_size");
		
	
	%>
		<div class = "container">
		<div class = "row">

			<div class="col-md-7">
				<form name ="newProduct" action="./processCreateReview.jsp?o_id=<%=o_id %>&id=<%=id %>&p_id=<%=p_id %>&p_size=<%=p_size %>" 
				class="form-horizontal" method ="post" enctype="multipart/form-data">
					<div class ="form-group row">
						<label class="col-sm-2">평점</label>
						<div class ="col-sm-7">
							<input type="radio" name="r_score" value="1"> 1
							<input type="radio" name="r_score" value="2"> 2
							<input type="radio" name="r_score" value="3" checked> 3
							<input type="radio" name="r_score" value="4"> 4
							<input type="radio" name="r_score" value="5"> 5
						</div>
					</div>
					<div class ="form-group row">
						<label class="col-sm-2">리뷰</label>
						<div class ="col-sm-10">
							<textarea name ="r_review" cols="100" rows="10"
							class ="form-control"></textarea>
						</div>
					</div>
					

					<div class ="form-group row">
						<div class ="col-sm-offset-2 col-sm-10">
							<input type = "submit" class="btn btn-primary" value ="작성">
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<jsp:include page = "footer.jsp" />
</body>
</html>