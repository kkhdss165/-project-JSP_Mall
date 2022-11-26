<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import = "java.sql.*" %>
<html>
<head>
<link rel = "stylesheet"	href = "./resources/css/bootstrap.min.css">
<title>상품 편집</title>
<%
	String edit = request.getParameter("edit");
%>
</head>
<body>
	<jsp:include page = "menu.jsp" />
	<div class ="jumbotron">
		<div class = "container">
			<h1 class = "display-3">재고 관리</h1>
		</div>
	</div>
	<%@ include file ="dbconn.jsp" %>
	<div class = "container">
		<div class ='row' align="left">
	<%
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from product";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery(sql);
		while (rs.next())
		{
			
	%>

				<div class="col-md-4">
				<dib align="left">
					<img src="c:/upload/<%=rs.getString("p_fileName")%>" style="width : 100%">
				<% 
					String productId = rs.getString("p_id");
					
					PreparedStatement pstmt2 = null;
					ResultSet rs2 = null;
					
					String sql2 = "select * from stock where p_id = ?";
					pstmt2 = conn.prepareStatement(sql2);
					pstmt2.setString(1, productId);
					rs2 = pstmt2.executeQuery();
					
					while(rs2.next())
					{
				%>
				
						<%
							if (edit.equals("update")){
						%>
							<p><%=rs.getString("p_name") %>(<%=rs2.getInt("p_size")%>) - (<%=rs2.getLong("p_unitsInStock")%>)개
							<a href="./updateStock.jsp?id=<%=rs.getString("p_id") %>&size=<%=rs2.getInt("p_size")%>"
							 >수정</a>
						<%
							} else if (edit.equals("delete")){
						%>	
							<p><%=rs.getString("p_name") %>(<%=rs2.getInt("p_size")%>) - (<%=rs2.getLong("p_unitsInStock")%>)개
							<a href="./deleteStock.jsp?id=<%=rs.getString("p_id") %>&size=<%=rs2.getInt("p_size")%>"
							 >삭제</a>
						<%
							}
						%>

					<%
							}
						if (rs2 != null)
							rs2.close();
						if (pstmt2 != null)
							pstmt2.close();
					%>
					</div>
			<hr>
			<%
				}
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			%>
		</div>
	</div>
	<br>
	<jsp:include page = "footer.jsp" />
</body>
</html>