<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix ="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<link rel = "stylesheet"	href = "./resources/css/bootstrap.min.css">
<script type = "text/javascript">
function CheckAddProduct()
{
	var productId = document.getElementById("productId");
	var size = document.getElementById("size");
	var unitsInStock = document.getElementById("unitsInStock");
	

	//상품 아이디 체크
	if (!check(/^P[0-9]{4,11}$/,productId, 
		"[상품코드]\nP와 숫자를 조합하여 5~12자까지 입력하세요\n첫 글자는 반드시 P로 시작하세요"))
		return false;
	
	//사이즈 체크
	if (size.value.length == 0 || isNaN(size.value))
		{
			alert("[사이즈]\n숫자만 입력하세요");
			size.select();
			size.focus();
			return false;
		}
	

	if (size.value < 0)
	{
		alert("[사이즈]\n음수는 입력할 수 없습니다");
		size.select();
		size.focus();
		return false;
	}
	
	//재고 수 체크
	if (unitsInStock.value.length == 0 ||isNaN(unitsInStock.value))
	{
		alert("[재고 수]\n숫자만 입력하세요");
		unitsInStock.select();
		unitsInStock.focus();
		return false;
	}
	
	
	if (unitsInStock.value < 0)
	{
		alert("[재고 수]\n음수는 입력할 수 없습니다");
		unitsInStock.select();
		unitsInStock.focus();
		return false;
	}
	
	function check(regExp, e, msg)
	{
		if (regExp.test(e.value))
			{
				return true;
			}
		alert(msg);
		e.select();
		e.focus();
		return false;
	}
	
	document.newProduct.submit();
	
}
</script>

<title>재고 등록</title>
</head>
<body>
	<fmt:setLocale value='<%=request.getParameter("language") %>'/>
	<fmt:bundle basename="bundle.message">
	<jsp:include page = "menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3"><fmt:message key="title2" /></h1>
		</div>
	</div>
	
	<div class="container">
		<div class="text-right">
			<a href="?language=ko" >Korean</a>|<a href="?language=en" >English</a>
		</div>
		<form name ="newProduct" action="./processAddStock.jsp" 
		class="form-horizontal" method ="post" enctype="multipart/form-data">
			<div class ="form-group row">
				<label class = "col-sm-2"><fmt:message key="productId" /></label>
				<div class = "col-sm-3">
					<input type="text" id="productId" name = "productId" class = "from-control">
				</div>
			</div>
			<div class ="form-group row">
				<label class = "col-sm-2"><fmt:message key="size" /></label>
				<div class = "col-sm-3">
					<input type="text" id="size" name="size" class = "from-control">
				</div>
			</div>
			<div class ="form-group row">
				<label class = "col-sm-2"><fmt:message key="unitsInStock" /></label>
				<div class = "col-sm-3">
					<input type="text" id="unitsInStock" name="unitsInStock" class = "from-control">
				</div>
			</div>
			<div class ="form-group row">
				<div class = "col-sm-offer-2 col-sm-10">
					<input type="button" name="btn btn-primary" value="<fmt:message key="button" />" onclick="CheckAddProduct()">
				</div>
			</div>
			<hr>
		</form>
	</div>
	</fmt:bundle>
	<jsp:include page = "footer.jsp" />
</body>
</html>