<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>
<html>
<head>
<link rel = "stylesheet"	href = "./resources/css/bootstrap.min.css">
<%
	String cartId = session.getId();

	String sessionId = (String) session.getAttribute("sessionId");
	
	boolean is_login = false;
	
	if (sessionId != null)
		is_login = true;
	
	System.out.println(is_login);
	System.out.println(cartId);
	System.out.println(sessionId);
%>	
<title>장바구니</title>
</head>
<body>
	<jsp:include page = "menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">장바구니</h1>
		</div>
	</div>
	<%@include file ="dbconn.jsp" %>
	<div class="container">
		<div class="row">
			<table width ="100%">
				<tr>
					<td align="left"><a href ="./deleteCart.jsp?cartId=<%=cartId%>">삭제하기</a></td>
					<%
						if(is_login == false)
						{
					%>
					<td align="right"><a href ="member/loginMember.jsp">로그인 후 주문하기</a></td>
					<% 
						}
						else
						{
					%>
					<td align="right"><a href ="./shippingInfo.jsp?cartId=<%=cartId%>">주문하기</a></td>
					<% 
						}
					%>
				</tr>
			</table>
		</div>
		<div style ="padding-top: 50px">
			<table class = "table table-hover">
				<tr>
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
				</tr>
				<%
				
					int sum = 0;
					int delivery_charge = 0;// 배송비
					ArrayList<Product> cartList = (ArrayList<Product>)session.getAttribute("cartlist");
					if (cartList == null)
						cartList = new ArrayList<Product>();
					
					PreparedStatement pstmt = null;
					ResultSet rs = null;
					
					for (int i=0;i<cartList.size();i++)
					{
						Product product = cartList.get(i);
						
						String productId = product.getProductID();
						
						//System.out.println(product.getProductID());
						
						String sql = "select * from product where p_id = ?";
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, productId);
						rs = pstmt.executeQuery();
						
						int total;
						
						if(rs.next()){
							total = rs.getInt("p_unitPrice") * (int)product.getQuantity();
							sum = sum + total;
						}
						else
							total = 0;
				%>
				<tr>
					<th><%=rs.getString("p_name")%> - <%=product.getSize() %></th>
					<th><%=rs.getInt("p_unitPrice") %></th>
					<th><%=product.getQuantity() %></th>
					<th><%=total %></th>
					<th><a href ="./removeCart.jsp?id=<%=product.getProductID() %>&size=<%=product.getSize() %>" class ="badge badge-danger">삭제</a></th>
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
				<%
					if(sum < 50000 && sum != 0)
					{
						delivery_charge = 3000;	
					}
					sum = sum + delivery_charge;
				%>
				<%
					if(sum != 0)
					{
				%>
				<tr>
					<th>배송비(5만원 이상 무료)</th>
					<th></th>
					<th></th>
					<th><%=delivery_charge%></th>
					<th></th>
				</tr>
				<%
					}
				%>
				<tr>
					<th></th>
					<th></th>
					<th>결제금액</th>
					<th><%=sum %></th>
					<th></th>
				</tr>
			</table>
			<a href ="./products.jsp" class="btn btn-secondary"> &laquo; 쇼핑 계속하기</a>
		</div>
		<hr>
	</div>
	<jsp:include page = "footer.jsp" />
</body>
</html>