<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import = "java.sql.*" %>
<html>
<head>
<link rel = "stylesheet"	href = "./resources/css/bootstrap.min.css">
<title>상품 수정</title>
</head>
<body>
	<jsp:include page = "menu.jsp" />
	<div class ="jumbotron">
		<div class = "container">
			<h1 class = "display-3">재고 수정</h1>
		</div>
	</div>
	<%@ include file ="dbconn.jsp" %>
	<%
		String productId = request.getParameter("id");
		String productSize = request.getParameter("size");
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from stock where p_id = ? and p_size = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,productId);
		pstmt.setString(2,productSize);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
	%>
	<div class = "container">
		<div class = "row">
			<div class="col-md-7">
				<form name ="newProduct" action="./processUpdateStock.jsp" 
				class="form-horizontal" method ="post" enctype="multipart/form-data">
					<div class ="form-group row">
						<label class="col-sm-2"> 상품 코드</label>
						<div class ="col-sm-3">
							<input type = "text" id="productId" name ="productId" 
							class="form-control" value='<%=rs.getString("p_id") %>'>
						</div>
					</div>
					<div class ="form-group row">
						<label class="col-sm-2">사이즈</label>
						<div class ="col-sm-3">
							<input type = "text" id="size" name ="size" 
							class="form-control" value='<%=rs.getInt("p_size") %>'>
						</div>
					</div>
					<div class ="form-group row">
						<label class="col-sm-2"> 재고 수</label>
						<div class ="col-sm-3">
							<input type = "text" id="unitsInStock" name ="unitsInStock" 
							class="form-control" value='<%=rs.getLong("p_unitsInStock") %>'>
						</div>
					</div>
					<div class ="form-group row">
						<div class ="col-sm-offset-2 col-sm-10">
							<input type = "submit" class="btn btn-primary" value ="수정">
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<%
		}
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
	%>
</body>
</html>