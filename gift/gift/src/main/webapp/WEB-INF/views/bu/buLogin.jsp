<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>buLogin</title>

<!-- 제이쿼리 -->
 <script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>

</head>
<body>
    <div class="container">
        <div class="login">
            <h1>로그인</h1>
        </div>
        <!-- 세션에 login 객체가 없으면 -->
        <c:if test="${buLogin == null}">
	        <div class="loginForm">
	            <form role="form">
	                <p>
	                    <label for="buId">아이디 </label><input type="text" id="buId" name="bu_id">
	                </p>
	                <p>
	                    <label for="buPwd">비밀번호 </label><input type="password" id="buPwd" name="bu_pwd">
	                </p>
	                <p>
	                    <button id="buIdSave" type="button">아이디 저장 '체크박스'만들기</button><span>아이디 저장</span>
	                </p>
	                <p>
	                    <button id="buLogin" type="button">로그인</button>
	                    
	                    <script>
	                    	let formObj1 = $("form[role='form']");
	                    	
	                    	$("#buLogin").click(function(){
	                    		formObj1.attr("method", "post");
	                    		formObj1.attr("action", "/bu/member/buLogin");
	                    		
	                    		formObj1.submit();
	                    	})
	                    </script>
	                </p>
	                <p>                
	                    <button id="buRegister" type="button">회원가입</button>
	                
	                	<script>
	                		$("#buRegister").click(function(){
	                			self.location = "/bu/member/buRegisterForm";
	                		})
	                	</script>
	                </p>
	            </form>
	        </div>
        </c:if>
        
        <!-- 세션에 login 객체가 있으면 -->
        <c:if test="${buLogin != null }">
        	<div id="loginSuccess">
        		<p>${buLogin.bu_name }님 환영합니다!</p>
        		<p>
        			<button type="button" id="logout">로그아웃</button>
        			
        			<script>
        				$("#logout").click(function(){
        					self.location="bu/member/buLogout";
        				})
        			</script>
        		</p>
        		<!-- 임시로 고객센터, 상품등록 넣음 -->
        		<p>
        			<a href="bu/board/buQnaList">고객센터</a>
        		</p>
        		        		<p>
        			<a href="/buItem/insertForm">상품등록</a>
        		</p>
        	</div>
        </c:if>
        
        <!-- redirect에서 로그인 실패시 -->
        <c:if test="${msg == false }">
        	<div id="loginErr">
        		<p>로그인 실패입니다. 다시 로그인해주세요.</p>
        	</div>
        </c:if>
    </div>
</body>
</html>