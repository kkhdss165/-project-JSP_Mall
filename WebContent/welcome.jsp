<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.Date" %>
<html>
<head>
<link rel = "stylesheet"	href = "./resources/css/bootstrap.min.css">
	
<title>JSP_MALL(since2021)</title>
</head>
<body>
	<%@ include file = "menu.jsp" %>
	<%! String greeting = "Welcome!"; 
	String tagline = "Welcome to JSPMall!";%>
	<div class ="jumbotron">
		<div class = "contanier">
			<h4 class = "display-3">
				<%= greeting %>
			</h4>
		</div>
	</div>
	<div class = "container">
		<div class = "text-center">
			<h4>
				<%= tagline %>
			</h4>
			<%
				response.setIntHeader("Refresh",5);
				Date day =new java.util.Date();
				String am_pm;
				int hour = day.getHours();
				int minute = day.getMinutes();
				int second = day.getSeconds();
				if (hour / 12 == 0)
					am_pm = "AM";
				else
				{
					am_pm = "PM";
					hour = hour -12;
				}
				String CT = hour + ":" + minute + ":" + second + " " + am_pm;
				out.println("현재 접속 시각: " + CT + "\n");
			%>
		</div>
		<hr>
	</div>
	<hr>
	<%@ include file = "footer.jsp" %>
</body>
</html>