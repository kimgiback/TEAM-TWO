<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>buLogin</title>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bu/buLogin.css">
<!-- 제이쿼리 -->
 <script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>

</head>
<body>

	<!-- 헤더영역 -->
	<jsp:include page="../commons/header.jsp"></jsp:include>
	
    <div class="container">
        <div class="login">
            <h1>관리자 로그인</h1>
        </div>
        <!-- 세션에 login 객체가 없으면 -->
      <c:if test="${buLogin == null}">
        <div class="loginForm">
            <form role="form">
                <div class="inp">
                    <label for="buId">아이디 </label><input type="text" id="buId" name="bu_id">
                </div>
                <div class="inp">
                    <label for="buPwd">비밀번호 </label><input type="password" id="buPwd" name="bu_pwd">
                </div>
                <div class="btn">
                <div>
                    <button id="buLogin" type="button">로그인</button>
                    
                    <script>
                      let formObj1 = $("form[role='form']");
                      
                      $("#buLogin").click(function(){
                        formObj1.attr("method", "post");
                        formObj1.attr("action", "/gift/bu/member/buLogin");
                        
                        formObj1.submit();
                      })
                    </script>
                </div>
                <div>                
                    <button id="buRegister" type="button">회원가입</button>
                
                  <script>
                    $("#buRegister").click(function(){
                      self.location = "/gift/bu/member/buRegisterForm";
                    })
                  </script>
                </div>
              </div>
            </form>
        </div>
      </c:if>
        
             <!-- 세션에 login 객체가 있으면 -->
      <c:if test="${buLogin != null }">
        <div id="loginSuccess">
          <h3>${buLogin.bu_name }님 환영합니다!</h3>
            <!-- 임시로 고객센터, 상품등록 넣음 -->
              <div class="etcbtn">
                 <div class="go">
                    <a href="/gift/bu/board/buQnaList">고객센터</a>
                    </div>
                    <div class="sa">
                    <a href="/gift/buItem/insertForm">상품등록</a>
                    </div>
                </div>
            <div>
              <button type="button" id="logout">로그아웃</button>
              
              <script>
                $("#logout").click(function(){
                  self.location="/gift/bu/member/buLogout";
                })
              </script>
            </div>

        </div>
      </c:if>
        
        <!-- redirect에서 로그인 실패시 -->
        <c:if test="${msg == false }">
        	<div id="loginErr">
        		<h3>로그인 실패입니다. 다시 로그인해주세요.</h3>
        	</div>
        </c:if>
    </div>
    
    <!-- 푸터영역 -->
	<jsp:include page="../commons/footer.jsp"></jsp:include>
	
</body>
</html>