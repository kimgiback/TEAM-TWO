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


</head>

<body>

	<c:out value="${m_idx}"/>번째 고객님이십니다.

<table>
	<thead></thead>
	<tr>
		<td><input type="button" value="로그아웃" onclick="location.href='mlogout'"></td>
	</tr>
</table>

</body>
</html>
    
