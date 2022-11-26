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
			<h1 class="display-3">주문 내역 조회</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<%@include file ="dbconn.jsp" %>
			<table class = "table table-hover">
				<tr>
					<th>주문번호</th>
					<th>상품명</th>
					<th>옵션(SIZE)</th>
					<th>수량</th>
					<th>결제 금액</th>
					<th>평점</th>
				</tr>
			<%
				String sessionId = (String) session.getAttribute("sessionId");
			
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = "select * from odr where id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, sessionId);
				rs = pstmt.executeQuery();
				
				
				while (rs.next())
				{	
					String p_name = "";
					String productId = rs.getString("p_id");
					
					PreparedStatement pstmt2 = null;
					ResultSet rs2 = null;
					String sql2 = "select * from product where p_id = ?";
					pstmt2 = conn.prepareStatement(sql2);
					pstmt2.setString(1, productId);
					rs2 = pstmt2.executeQuery();
					
					System.out.println(productId);
					
					if (rs2.next())
					{
						p_name = rs2.getString("p_name");
					}
					if (rs2 != null)
						rs2.close();
					if (pstmt2 != null)
						pstmt2.close();
			%>
				<tr>
					<th><%=rs.getString("o_id")%></th>
					<th><%=p_name%></th>
					<th><%=rs.getInt("p_size")%></th>
					<th><%=rs.getInt("p_quantity")%></th>
					<th><%=rs.getInt("p_amount")%>원</th>
			<% if(rs.getInt("p_score") == -1)
				{
			%>
					<th><a href ="./createReview.jsp?o_id=<%=rs.getString("o_id")%>&id=<%=rs.getString("id")%>&p_id=<%=rs.getString("p_id")%>&p_size=<%=rs.getInt("p_size")%>" 
					class ="badge badge-danger">리뷰작성</a></th>
			<% 
				}
				else{
			%>
					<th><%=rs.getInt("p_score")%>/5.0</th>
			<% 
				}
			%>	
				</tr>
			<%
				}
				
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			%>
			</table>
		</div>
		<hr>
	</div>
	<jsp:include page = "footer.jsp" />
</body>
</html>