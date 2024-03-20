<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/buReplyForm.css">
<!-- 제이쿼리 -->
 <script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
</head>
<body>
    <!-- 헤더영역 -->
	<jsp:include page="../commons/header.jsp"></jsp:include>
	
	<form role="updateForm">
		<div>
		 	<input type="hidden" id="re_no" name="re_no" value="${update.re_no}">
		</div>

		<div class="form-group">
		 	<label for="re_title">제목</label>
		 	<input type="text" id="re_title" name="re_title">
		</div>

		<div class="form-group">
		 	<label for="re_content">내용</label>
		 	<textarea rows="30" cols="50" id="re_content" name="re_content"></textarea>
		</div>

		<div>
			<button id="update">글쓰기</button>
			
			<script>
			let formObj = $("form[role='updateForm']");
			
			$("#update").on("click", function(){
				formObj.attr("method", "post");
				formObj.attr("action", "/gift/bu/board/buReplyUpdate");
				formObj.submit();
			})
		</script>
		</div>
	</form>
	
	<!-- 푸터영역 -->
	<jsp:include page="../commons/footer.jsp"></jsp:include>
</body>
</html>