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
	<form role="form">
            <p>
                <label for="buId">아이디 </label><input type="text" id="buId" name="bu_id">
                <button id="buIdCheck" type="button">중복체크</button>
                
                <script>
                	let formObj2 = $("form[role='form']");
                	
                	$("#buIdCheck").click(function(){
                		formObj2.attr("action", "/bu/member/buIdCheck")
                		formObj2.attr("method", "post");
                		formObj2.submit();
                	})
                </script>
                
                <!-- id유지기능 필요 -->
                <c:if test="${checkMsg == false }">
                	<span>중복된 아이디</span>
                </c:if>
                <c:if test="${checkMsg == true }">
                	<span>사용할 수 있는 아이디입니다!</span>
                </c:if>
            </p>
            <p>
                <label for="buPwd">비밀번호 </label><input type="password" id="buPwd" name="bu_pwd">
            </p>
            <p>
                <label for="buName">이름 </label><input type="text" id="buName" name="bu_name">
            </p>
            <p>
                <label for="buAddress">주소 </label><input type="text" id="buAddress" name="bu_address">
                주소검색
            </p>
            <p>
                <label for="buEmail">이메일 </label><input type="email" id="buEmail" name="bu_email">
            </p>
            <p>
                <label for="buPhone">전화번호 </label><input type="text" id="buPhone" name="bu_phone">
            </p>
            <p>
                <button id="buLogin" type="button">회원가입</button>
                
                <script>
                	let formObj1 = $("form[role='form']");
                	
                	$("#buLogin").click(function(){
                		formObj1.attr("method", "post");
                		formObj1.attr("action", "/bu/member/buRegister");
                		
             			formObj1.submit();
                	})
                
                </script>
            </p>
        </form>
</body>
</html>