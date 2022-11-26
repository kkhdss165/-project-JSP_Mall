<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="dto.Product" %>

<%
	request.setCharacterEncoding("UTF-8");

	String cartId = session.getId();
	
	
	String shipping_cartId = "";
	String shipping_name = "";
	String shipping_phone = "";
	String shipping_shippingDate = "";
	String shipping_addressName = "";
	
	Cookie[] cookies = request.getCookies();
	
	if(cookies != null)
	{
		for (int i = 0; i< cookies.length; i++)
		{
			Cookie thisCookie = cookies[i];
			String n = thisCookie.getName();
			if (n.equals("Shipping_cartId"))
			{
				shipping_cartId = URLDecoder.decode((thisCookie.getValue()),"utf-8");
			}
			if (n.equals("Shipping_name"))
			{
				shipping_name = URLDecoder.decode((thisCookie.getValue()),"utf-8");
			}
			if (n.equals("Shipping_phone"))
			{
				shipping_phone = URLDecoder.decode((thisCookie.getValue()),"utf-8");
			}
			if (n.equals("Shipping_shippingDate"))
			{
				shipping_shippingDate = URLDecoder.decode((thisCookie.getValue()),"utf-8");
			}
			if (n.equals("Shipping_addressName"))
			{
				shipping_addressName = URLDecoder.decode((thisCookie.getValue()),"utf-8");
			}
		}
	}
%>
<html>
<head>
<link rel = "stylesheet"	href = "./resources/css/bootstrap.min.css">
<title>주문 정보</title>
</head>
<body>
	<jsp:include page = "menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">주문 정보</h1>
		</div>
	</div>
	<%@include file ="dbconn.jsp" %>
	<div class="container col-8 alert alert-info">
		<div class="text-center">
			<h1>영수증</h1>
		</div>
		<div class="row justify-content-between">
			<div class="col-8" align="left">
				<strong>배송 정보</strong> 
				<br> 성명 : <% out.println(shipping_name); %>
				<br> 연락처 : <% out.println(shipping_phone); %>
				<br> 주소 : <% out.println(shipping_addressName); %><br>
			</div>
			<div class="col-4" align="right">
				<p> <em>배송일 : <% out.println(shipping_shippingDate); %></em>
			</div>
		</div>
		<div>
			<table class="table table-hover">
			<tr>
				<th class="text-center">제품</th>
				<th class="text-center">#</th>
				<th class="text-center">가격</th>
				<th class="text-center">소계</th>
			</tr>
			<%
				int sum = 0;
				int delivery_charge = 0;// 배송비
			
				String productId = "";
				PreparedStatement pstmt = null;
				ResultSet rs = null;
			
				ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
				if (cartList == null)
					cartList = new ArrayList<Product>();
				for (int i=0; i< cartList.size(); i++)
				{
					Product product = cartList.get(i);
					productId = product.getProductID();
					
					//System.out.println(productId);
					
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
				<td class="text-center"><em><%=rs.getString("p_name")%> - <%=product.getSize() %></em></td>
				<td class="text-center"><%=product.getQuantity()%></td>
				<td class="text-center"><%=rs.getString("p_unitPrice")%></td>
				<td class="text-center"><%=total%>원</td>
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
					<td class="text-center">배송비(5만원 이상 무료)</td>
					<td class="text-center"></td>
					<td class="text-center"></td>
					<td class="text-center"><%=delivery_charge%>원</td>
				</tr>
				<%
					}
				%>
			<tr>
				<td></td>
				<td></td>
				<td class="text-right"><strong>총액: </strong></td>
				<td class="text-center text-danger"><strong><%=sum%>원</strong></td>
			</tr>
			</table>
			
			<a href ="./shippingInfo.jsp?cartId=<%=shipping_cartId%>" class ="btn btn-secondary" role="button"> 이전 </a>
			<a href ="./thankCustomer.jsp" class ="btn btn-success" role="button"> 주문 완료 </a>
			<a href ="./checkOutCancelled.jsp" class ="btn btn-secondary" role="button"> 취소 </a>
		</div>
	</div>
	<jsp:include page = "footer.jsp" />
</body>
</html>