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
			<h1 class="display-3">상품 목록</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<%@include file ="dbconn.jsp" %>
			<%
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = "select * from product";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				
				while(rs.next())
				{
						String desc;
						
						if (rs.getString("p_description").length() < 50)
							desc = rs.getString("p_description");
						else
						{
							desc = rs.getString("p_description").substring(0,50);
							desc = desc.trim() + " . . .";
						}
			%>
			<div class="col-md-4">
				<img src="c:/upload/<%=rs.getString("p_fileName")%>" style="width : 100%">
				<h4><%=rs.getString("p_name") %></h4>
				<hr>
				<p><%=desc%>
				<h5>평점 <%=(double)Math.round(rs.getDouble("p_gpa")*100)/100 %>/5(<%=rs.getLong("p_sales") %>)</h5>
				<h5><%=rs.getString("p_unitPrice")%>원
				<a style="float:right;"href="./product.jsp?id=<%=rs.getString("p_id") %>" class="btn btn-secondary" role="button"> 상세 정보 &raquo;</a></h5>
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
		</div>
		<hr>
	</div>
	<jsp:include page = "footer.jsp" />
</body>
</html>