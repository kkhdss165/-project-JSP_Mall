<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="dto.Product" %>
<%@include file ="dbconn.jsp" %>
<html>
<head>
<link rel = "stylesheet"	href = "./resources/css/bootstrap.min.css">
	
<title>주문 완료</title>
</head>
<body>
	<%
		String sessionId = (String) session.getAttribute("sessionId");
	
		String shipping_cartId = "";
		String shipping_name = "";
		String shipping_shippingDate = "";
		String shipping_country = "";
		String shipping_zipCode = "";
		String shipping_addressName = "";
		
		Cookie[] cookies = request.getCookies();
		
		if (cookies != null)
		{
			for(int i = 0; i<cookies.length; i++)
			{
				Cookie thisCookie = cookies[i];
				String n = thisCookie.getName();
				if (n.equals("Shipping_cartId"))
				{
					shipping_cartId = URLDecoder.decode((thisCookie.getValue()),"utf-8");
				}
				if (n.equals("Shipping_shippingDate"))
				{
					shipping_shippingDate = URLDecoder.decode((thisCookie.getValue()),"utf-8");
				}
			}
		}
	%>
	<jsp:include page = "menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">주문 완료</h1>
		</div>
	</div>

	<div class="container">
		<h2 class="alert alert-danger">주문해주셔서 감사합니다.</h2>
		<p> 주문은 <% out.println(shipping_shippingDate); %>에 배송될 예정입니다!
		<p> 주문번호 : <% out.println(shipping_cartId); %>
	</div>
	<%
		String productId = "";
		int productSize = 0;
		int productQuantity = 0; 
		int sum = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;	
	
		ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
		if (cartList == null)
			cartList = new ArrayList<Product>();
		
		for (int i=0; i< cartList.size(); i++)
		{
			Product product = cartList.get(i);
			productId = product.getProductID();
			productSize = product.getSize();
			productQuantity = (int)product.getQuantity();
			
			String sql = "select * from product where p_id =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productId);
			rs = pstmt.executeQuery();
			
			
			if (rs.next())
			{	
				
				sum = rs.getInt("p_unitPrice") * productQuantity;
			}
			
			sql = "INSERT INTO odr value(?,?,?,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, shipping_cartId);
			pstmt.setString(2, sessionId);
			pstmt.setString(3, productId);
			pstmt.setInt(4, productSize);
			pstmt.setInt(5, productQuantity);
			pstmt.setInt(6, sum);
			pstmt.setString(7, "");
			pstmt.setInt(8, -1);
			pstmt.executeUpdate();
			
			
			
		}
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
	%>
	<div class="container">
		<p> <a href="./products.jsp" class="btn btn-secondary"> &laquo; 상품 목록</a>
	</div>
	<jsp:include page = "footer.jsp" />
</body>
</html>
<%
	session.invalidate();

	for (int i=0; i<cookies.length; i++)
	{
		Cookie thisCookie = cookies[i];
		String n = thisCookie.getName();
		if (n.equals("Shipping_cartId"))
		{
			thisCookie.setMaxAge(0);
		}
		if (n.equals("Shipping_name"))
		{
			thisCookie.setMaxAge(0);
		}
		if (n.equals("Shipping_phone"))
		{
			thisCookie.setMaxAge(0);
		}
		if (n.equals("Shipping_shippingDate"))
		{
			thisCookie.setMaxAge(0);
		}
		if (n.equals("Shipping_addressName"))
		{
			thisCookie.setMaxAge(0);
		}
		
		response.addCookie(thisCookie);
	}
%>