<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>
<%
	String id = request.getParameter("id");
	String size = request.getParameter("size");
	
	boolean is_find = false;	//같은 제품명을 찾지 못할경우를 처리하기위한 boolean
	
	if (id == null || id.trim().equals(""))
	{
		response.sendRedirect("products.jsp");
		return;
	}
	
	
	ArrayList<Product> list = (ArrayList<Product>) session.getAttribute("cartlist");
	
	if (list == null) //상품리스트가 없을때 (초기상태)
	{
		System.out.println("!");
		
		Product goodQnt = new Product();
		goodQnt.setProductID(id);
		goodQnt.setSize(Integer.parseInt(size));
		goodQnt.setQuantity(1);
		
		list = new ArrayList<Product>();
		list.add(goodQnt);
		
		session.setAttribute("cartlist",list);
		
		is_find = true;
	}
	else
	{
		for(int i=0; i<list.size(); i++)
		{
			Product goodQnt = list.get(i);
			if(goodQnt.getProductID().equals(id)&& goodQnt.getSize()==Integer.parseInt(size))
			{
				goodQnt.setQuantity(goodQnt.getQuantity()+1);
				is_find = true;
			}
					
		}
	}
	
	if (is_find == false)
	{
		Product goodQnt = new Product();
		goodQnt.setProductID(id);
		goodQnt.setSize(Integer.parseInt(size));
		goodQnt.setQuantity(1);
		
		list.add(goodQnt);
	}
	
	
	response.sendRedirect("products.jsp");
%>
