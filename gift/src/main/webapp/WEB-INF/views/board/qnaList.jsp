<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 제이쿼리 -->
 <script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
 
</head>
<body>
	<div class="qnaContent">
		<table class="qnaList">
			<tr>
				<th>작성자idx</th>
				<th>질문유형</th>
				<th>제목</th>
				<th>작성자</th>
				<th>등록일</th>
			</tr>
			
			<c:forEach var="qna" items="${qnaList }">
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>