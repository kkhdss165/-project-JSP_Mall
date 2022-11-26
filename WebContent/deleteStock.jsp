<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ include file ="dbconn.jsp" %>
<%
	String productId = request.getParameter("id");
	String productSize = request.getParameter("size");

	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String sql = "select * from product";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	if(rs.next())
	{
		sql = "delete from stock where p_id = ? AND p_size = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,productId);
		pstmt.setInt(2,Integer.valueOf(productSize));
		pstmt.executeUpdate();
	}
	else
		out.println("일치하는 상품이 없습니다");
	
	
	if (rs != null)
		rs.close();
	if (pstmt != null)
		pstmt.close();
	if (conn != null)
		conn.close();
	
	response.sendRedirect("editStock.jsp?edit=delete");
%>