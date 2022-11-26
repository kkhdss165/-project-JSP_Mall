<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file ="dbconn.jsp" %>
<html>
<head>
<link rel = "stylesheet"	href = "./resources/css/bootstrap.min.css">


<title>배송 정보</title>
</head>
<body>
	<jsp:include page = "menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">배송 정보</h1>
		</div>
	</div>
	<% 
		String sessionId = (String) session.getAttribute("sessionId");
		
		String m_name ="";
		String m_phone ="";
		String m_address ="";
	
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from member where id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, sessionId);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			m_name = rs.getString("name");
			m_phone =rs.getString("phone");
			m_address =rs.getString("address");
		}
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
	%>
	<div class="container">
		<form action ="./processShippingInfo.jsp" class ="form-horizontal" method ="post">
			<input type ="hidden" name="cartId" value="<%=request.getParameter("cartId") %>"/>
			<div class ="form-group row">
				<label class="col-sm-2">성명</label>
				<div class="col-sm-3">
					<input name ="name" type="text" class="form-control" value="<%=m_name %>"/>
				</div>
			</div>
			<div class="form-group  row">
				<label class="col-sm-2">전화번호</label>
				<div class="col-sm-3">
					<input name="phone" type="text" class="form-control"  value="<%=m_phone %>">

				</div>
			</div>
			<div class ="form-group row">
				<label class="col-sm-2">주소</label>
				<div class="col-sm-3">
					<input name ="addressName" type="text" class="form-control"  value="<%=m_address %>"/>
				</div>
			</div>
			<div class ="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<a href ="./cart.jsp?cartId=<%=request.getParameter("cartId")%>" class="btn btn-secondary" role="button"> 이전 </a>
					<input type=submit class="btn btn-primary" value="등록"/>
					<a href="./checkOutCancelled.jsp" class="btn btn-secondary" role="button"> 취소 </a>
				</div> 
			</div>
		</form>
		<hr>
	</div>

	<jsp:include page = "footer.jsp" />
</body>
</html>