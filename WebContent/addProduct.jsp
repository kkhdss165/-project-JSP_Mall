<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix ="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<link rel = "stylesheet"	href = "./resources/css/bootstrap.min.css">
<script type = "text/javascript">
function CheckAddProduct()
{
	var productId = document.getElementById("productId");
	var name = document.getElementById("name");
	var unitPrice = document.getElementById("unitPrice");
	

	//상품 아이디 체크
	if (!check(/^P[0-9]{4,11}$/,productId, 
		"[상품코드]\nP와 숫자를 조합하여 5~12자까지 입력하세요\n첫 글자는 반드시 P로 시작하세요"))
		return false;
	
	//상품명 체크
	if (name.value.length<4 || name.value.length > 12)
		{
			alert("[상품명]\n최소 4자에서 최대 12자까지 입력하세요");
			name.select();
			name.focus();
			return false;
		}
	
	//상품 가격 체크
	if (unitPrice.value.length == 0 || isNaN(unitPrice.value))
		{
			alert("[가격]\n숫자만 입력하세요");
			unitPrice.select();
			unitPrice.focus();
			return false;
		}
	

	if (unitPrice.value < 0)
	{
		alert("[가격]\n음수는 입력할 수 없습니다");
		unitPrice.select();
		unitPrice.focus();
		return false;
	}
	else if (!check(/^\d+(?:[.]?[\d]?[\d])?$/,unitPrice,"[가격]\n소수점 둘째 자리까지만 입력하세요"))
		{
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

<title>상품 등록</title>
</head>
<body>
	<fmt:setLocale value='<%=request.getParameter("language") %>'/>
	<fmt:bundle basename="bundle.message">
	<jsp:include page = "menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3"><fmt:message key="title" /></h1>
		</div>
	</div>
	
	<div class="container">
		<div class="text-right">
			<a href="?language=ko" >Korean</a>|<a href="?language=en" >English</a>
		</div>
		<form name ="newProduct" action="./processAddProduct.jsp" 
		class="form-horizontal" method ="post" enctype="multipart/form-data">
			<div class ="form-group row">
				<label class = "col-sm-2"><fmt:message key="productId" /></label>
				<div class = "col-sm-3">
					<input type="text" id="productId" name = "productId" class = "from-control">
				</div>
			</div>
			<div class ="form-group row">
				<label class = "col-sm-2"><fmt:message key="pname" /></label>
				<div class = "col-sm-3">
					<input type="text" id="name" name="name" class = "from-control">
				</div>
			</div>
			<div class ="form-group row">
				<label class = "col-sm-2"><fmt:message key="unitPrice" /></label>
				<div class = "col-sm-3">
					<input type="text" id="unitPrice" name="unitPrice" class = "from-control">
				</div>
			</div>
			<div class ="form-group row">
				<label class = "col-sm-2"><fmt:message key="description" /></label>
				<div class = "col-sm-3">
					<textarea name="description" cols="50" rows="2" class = "from-control"></textarea>
				</div>
			</div>
			<div class ="form-group row">
				<label class = "col-sm-2"><fmt:message key="category" /></label>
				<div class = "col-sm-3">
					<input type="radio" name="category" value="Top"><fmt:message key="category_Top" />
					<input type="radio" name="category" value="Bottom"><fmt:message key="category_Bottom" />
					<input type="radio" name="category" value="Outer"><fmt:message key="category_Outer" />
				</div>
			</div>
			<div class ="form-group row">
				<label class ="col-sm-2"><fmt:message key="productImage" /></label>
				<div class = "col-sm-5">
					<input type="file" name="productImage" value="from-control">
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