<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form role="write" method="post" action="/bu/board/buReplyWrite">
		<p>
			 <label for="qna_no"></label>
			 <input type="text" id="qna_no" name="qna_no" value="${qna_no }">
		</p>
		<p>
		 	<label for="re_title">제목 : </label>
		 	<input type="text" id="re_title" name="re_title">
		</p>
		<p>
		 	<label for="re_content">내용 : </label>
		 	<textarea rows="30" cols="50" id="re_content" name="re_content"></textarea>
		</p>
		<p>
			<button type="submit">글쓰기</button>
		</p>
	</form>
</body>
</html>