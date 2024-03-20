<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/commons/header.css">
</head>
<body>
	<header id="header">
		<div class ="inner-wrap">
			<div class ="top-menu">
				<a href="javascript:;" onclick="location.href='${pageContext.request.contextPath}/mlogin'">로그인</a>
				<a href="javascript:;" onclick="location.href='${pageContext.request.contextPath}/mjoin'">회원가입</a>
				<a href="javascript:;" onclick="location.href='${pageContext.request.contextPath}/userQna_list'">고객센터</a>
			</div>
			<div class ="header-wrap">
				<h1><a href="javascript:;" onclick="location.href='${pageContext.request.contextPath}'"></a></h1>
				<div class="util-wrap">
					<div class="util-menu">
						<a href="javascript:;" class="myIcon"></a>
						<a href="javascript:;" class="cartIcon" onclick="location.href='${pageContext.request.contextPath}/cartList'"></a>
						<a href="javascript:;" class="wishIcon" onclick="location.href='${pageContext.request.contextPath}/wishList'"></a>
					</div>
			</div>
		</div>
	</header>
</body>
</html>