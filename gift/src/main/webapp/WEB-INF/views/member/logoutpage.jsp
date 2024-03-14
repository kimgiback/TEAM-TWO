<%@page import="org.apache.jasper.tagplugins.jstl.core.Remove"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="resources/js/httpRequest.js"></script>

<!-- script 위에 태그 안붙여서  -->
<script type="text/javascript">

	function logout(f) {
		//alert("로그아웃되었습니다.");
		<% session.removeAttribute("m_idx"); // 한개만 삭제
			//session.invalidate(); // 초기화
			
			//컨트롤러 넘기려고 했지만 실패..
			
		%>
		//location.href="/gift/testpage";
		//location.href='login.jsp';
		
		
		//xhr.sendRequest(param,"memberlogout","POST");
		
	}
	
</script>
</head>

<body>

	<c:out value="${m_idx}"/>번째 고객님이십니다.

<table>
	<thead></thead>
	<tr>
		<td></td>
	</tr>
</table>

</body>
</html>