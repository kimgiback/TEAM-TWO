<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- 제이쿼리 -->
 <script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>

</head>
<body>
	<p>등록 실패했습니다. 정보를 다시 확인해주세요!</p>
	<p>
		<button type="button" id="toRegister">회원가입</button>
	
		<!-- 쓴 정보 유지하는 기능 필요 -->
		<script>
			$("#toRegister").click(function(){
				self.location="/bu/member/buRegisterForm";
			})
		</script>
	</p>
</body>
</html>