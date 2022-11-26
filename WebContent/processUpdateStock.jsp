<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ include file ="dbconn.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	
	String filename = "";
	String realFolder = "C://upload";
	int maxSize = 5 * 1024 * 1024;
	String encType = "utf-8";
	
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	String productId = multi.getParameter("productId");
	String ssize = multi.getParameter("size");
	String unitsInStock = multi.getParameter("unitsInStock");
	
	
	int size = Integer.valueOf(ssize);
	
	long stock;
	
	if (unitsInStock.isEmpty())
		stock = 0;
	else
		stock = Long.valueOf(unitsInStock);
	
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "select * from product where p_id = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, productId);
	rs = pstmt.executeQuery();
	
	if (rs.next())
	{
		sql = "UPDATE stock SET p_unitsInStock=? WHERE p_id=? AND p_size=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setLong(1, stock);
		pstmt.setString(2, productId);
		pstmt.setInt(3, size);
		pstmt.executeUpdate();
	}
	
	if (rs != null)
		rs.close();
	if (pstmt != null)
		pstmt.close();
	if (conn != null)
		conn.close();
	
	response.sendRedirect("editStock.jsp?edit=update");
%>