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
	
	int score = Integer.parseInt(multi.getParameter("r_score"));
	String review = multi.getParameter("r_review");
	
	String o_id = "";
	String id = "";
	String p_id = "";
	int p_size = 0;
	
	o_id = request.getParameter("o_id");
	id = request.getParameter("id");
	p_id = request.getParameter("p_id");
	p_size = Integer.parseInt(request.getParameter("p_size"));
	
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "select * from odr where o_id = ? AND id = ? AND p_id = ? AND p_size = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, o_id);
	pstmt.setString(2, id);
	pstmt.setString(3, p_id);
	pstmt.setInt(4, p_size);
	rs = pstmt.executeQuery();
	
	if (rs.next())
	{
		sql = "UPDATE odr SET p_review = ?, p_score = ? WHERE o_id = ? AND id = ? AND p_id = ? AND p_size = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, review);
		pstmt.setInt(2, score);
		pstmt.setString(3, o_id);
		pstmt.setString(4, id);
		pstmt.setString(5, p_id);
		pstmt.setInt(6, p_size);
		pstmt.executeUpdate();
		
		
		sql = "select * from product where p_id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, p_id);
		rs = pstmt.executeQuery();
		
		if (rs.next())
		{
			double sum = 0;
			long sales= rs.getLong("p_sales");
			double gpa = rs.getDouble("p_gpa");

			sum = sales * gpa;		//기존 점수 합
			sales++;
			sum = sum + score;
			gpa = sum / sales;
			
			System.out.println(gpa);
			
			sql = "UPDATE product SET p_sales = ?, p_gpa = ? WHERE p_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setLong(1, sales);
			pstmt.setDouble(2, gpa);
			pstmt.setString(3, p_id);
			pstmt.executeUpdate();

		}
	}
	if (rs != null)
		rs.close();
	if (pstmt != null)
		pstmt.close();
	if (conn != null)
		conn.close();
	
	
	
	response.sendRedirect("inquiryOrder.jsp");
%>