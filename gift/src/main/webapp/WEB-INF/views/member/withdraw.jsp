<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/login_style.css">
<!-- ${pageContext.request.contextPath}넣어서 가능했음. -->

<script src="resources/js/httpRequest.js"></script>

<script src="http://code.jquery.com/jquery-1.11.2.js"></script>

</head>
<body>
<%@ include file="../commons/header.jsp"%> 
    <form id = "member_login_form">
        <table id="login_table">
			<caption id="member_login_title">회원탈퇴</caption>
            <tbody>
	            <tr>
	                <td class="member_withdraw_text">
	                    <label>지금 탈퇴하면 기존에 있던 정보는 제거됩니다.</label>
	                </td>
	            </tr>
	            <tr>
	            	<td class="member_withdraw_text">
	                	<label>탈퇴하시겠습니까?</label>
	                </td>
	            </tr>
	           
	            <tr>
		            <td>
		            	<input type="button" value="로그인" onclick="location.href='/gift/member_withdraw'"class="member_login">
		            </td>
	            </tr>
	             
            </tbody>
            	
            
            
        </table>
    </form>
<%@ include file="../commons/footer.jsp"%> 
</body>
</html>