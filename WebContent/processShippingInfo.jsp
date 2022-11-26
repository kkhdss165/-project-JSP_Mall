<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("UTF-8");

	Date currentDatetime = new Date(System.currentTimeMillis());	
	String yy = String.valueOf(currentDatetime.getYear() + 1900);
	String mm = String.valueOf(currentDatetime.getMonth() + 1);
	String dd = String.valueOf(currentDatetime.getDate() + 2);
	
	String date = yy + "-" + mm + "-" + dd;
	

	Cookie cartId = new Cookie("Shipping_cartId", URLEncoder.encode(request.getParameter("cartId"),"utf-8"));
	Cookie name = new Cookie("Shipping_name", URLEncoder.encode(request.getParameter("name"),"utf-8"));
	Cookie phone = new Cookie("Shipping_phone", URLEncoder.encode(request.getParameter("phone"),"utf-8"));
	Cookie shippingDate = new Cookie("Shipping_shippingDate",date);
	Cookie addressName = new Cookie("Shipping_addressName", URLEncoder.encode(request.getParameter("addressName"),"utf-8"));

	
	
	cartId.setMaxAge(24*60*60);
	name.setMaxAge(24*60*60);
	phone.setMaxAge(24*60*60);
	shippingDate.setMaxAge(24*60*60);
	addressName.setMaxAge(24*60*60);
	
	response.addCookie(cartId);
	response.addCookie(name);
	response.addCookie(phone);
	response.addCookie(shippingDate);
	response.addCookie(addressName);
	
	response.sendRedirect("orderConfirmation.jsp");
%>
