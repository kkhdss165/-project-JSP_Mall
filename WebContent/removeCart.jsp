<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>
<%
	String id = request.getParameter("id");
	String size = request.getParameter("size");
	

	if (id == null || id.trim().equals(""))
	{
		response.sendRedirect("products.jsp");
		return;
	}
	
	
	ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartlist");
	Product goodsQnt = new Product();
	for (int i=0;i<cartList.size();i++)
	{
		goodsQnt = cartList.get(i);
		if (goodsQnt.getProductID().equals(id)&&goodsQnt.getSize()==Integer.parseInt(size))
		{
			cartList.remove(goodsQnt);
		}
	}
	
	response.sendRedirect("cart.jsp");
%>
