<%@ page contentType="text/html; charset=UTF-8"%>

<%@ page import="java.sql.*"%>
<%@ page errorPage="exceptionNoProductId.jsp" %>
<jsp:useBean id ="productDAO" class="dao.ProductRepository" scope="session" />
<html>
<head>
<link rel = "stylesheet"	href = "./resources/css/bootstrap.min.css">
	
<title>JSP_MALL(since2021)</title>
<script type ="text/javascript">
	function addToCart()
	{
		if (confirm("상품을 장바구니로 추가하시겠습니까?"))
		{
			document.addForm.submit();
		}
		else
		{
			document.addForm.reset();
		}
		
	}
</script>
</head>
<body>
	<jsp:include page = "menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품 정보</h1>
		</div>
	</div>
	<%@include file ="dbconn.jsp" %>
	<%
		String productId = request.getParameter("id");
	
		if (productId == null || productId.trim().equals(""))
		{
			response.sendRedirect("products.jsp");
			return;
		}
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from product where p_id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, productId);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
	%>
	<div class="container">
		<div class ="row">
			<div class = "col-md-5">
				<img src="c:/upload/<%=rs.getString("p_fileName")%>" style="width : 100%">
			</div>
			<div class = "col-md-6">
				<h3><%=rs.getString("p_name")%></h3>
				<p><pre><%=rs.getString("p_description")%></pre>
				<form name="addForm"  class="form-horizontal"  action ="./addCart.jsp?id=<%=rs.getString("p_id")%>" method ="post">
				<select name="size">
				<% 
					String productId2 = request.getParameter("id");
					
					PreparedStatement pstmt2 = null;
					ResultSet rs2 = null;
					
					String sql2 = "select * from stock where p_id = ?";
					pstmt2 = conn.prepareStatement(sql2);
					pstmt2.setString(1, productId2);
					rs2 = pstmt2.executeQuery();
					
					while(rs2.next())
					{
				%>
					<option value="<%=rs2.getInt("p_size")%>"><%=rs.getString("p_name")%> - <%=rs2.getInt("p_size")%> </option>
				<%
					}
					if (rs2 != null)
						rs2.close();
					if (pstmt2 != null)
						pstmt2.close();
				%>	
				</select>
				<p> 
				<h4><%=rs.getString("p_unitPrice")%>원   
				
					<a href = "#" class="btn btn-warning" onclick="addToCart()">장바구니 담기</a>
					<a href = "./products.jsp" class="btn btn-info">상품 목록</a></h4>
				</form>
				
			</div>
		</div>
		<hr>
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
	<jsp:include page = "footer.jsp" />
</body>
</html>