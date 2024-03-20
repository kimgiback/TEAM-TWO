<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bu/buItemRegister.css">
<!-- 제이쿼리 -->
 <script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>

</head>
<body>
	<!-- 헤더영역 -->
	<jsp:include page="../commons/header.jsp"></jsp:include>
	
<div class="itemregi">
    <h1>상품 등록</h1>
</div>
<form name="item" enctype="multipart/form-data" method="post" action="/buItem/insert">
	<input type="hidden" name="category_no" value="00">
	<input type="hidden" name="brand" value="00">
	<input type="hidden" name="payment" value="00">
	<div class="itemName">
		상품명 : <input type="text" name="item_name">
	</div>
	<div class="itemPrice">
		가격 : <input type="text" name="item_price">
	</div>
	<div class="itemStock">
		수량 : <input type="text" name="item_stock">
	</div>
	<div class="itemInfo">
		상품설명 : <textarea cols="30" rows="30" name="item_info"></textarea>
	</div>
	<div class="itemImage">
		상품 이미지 : <input type="file" name="item_image">
	</div>
	<div class="buttons">
		<button id="register" type="submit">등록</button>
		<button id="list" type="button">목록</button>
		
		<script>
		</script>
	</div>
</form>

	<!-- 푸터영역 -->
	<jsp:include page="../commons/footer.jsp"></jsp:include>
	
</body>
</html>