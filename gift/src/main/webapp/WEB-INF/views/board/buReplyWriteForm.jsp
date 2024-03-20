<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/buReplyForm.css">
</head>
<body>

    <!-- 헤더영역 -->
	<jsp:include page="../commons/header.jsp"></jsp:include>
	
	<form role="write" method="post" action="/gift/bu/board/buReplyWrite">
		<div class="form-group">
			 <label for="qna_no"></label>
			 <input type="text" id="qna_no" name="qna_no" value="${qna_no }">
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
			<button type="submit">글쓰기</button>
		</div>
	</form>
	
	<!-- 푸터영역 -->
	<jsp:include page="../commons/footer.jsp"></jsp:include>
</body>
</html>