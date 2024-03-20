<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
  
  .button_container {
  	position:relative;
  	display: flex; 
    margin-bottom: 20px;
  }
    /* 이미지에 대한 스타일 */
    .item_image {
    	position:relative;
        width: 325px;
        height: 325px;
        margin-top: 75px;
        vertical-align:top;
    }

    /* 버튼에 대한 스타일 */
    .item_button {
        position: absolute; /* 절대 위치 설정 */
        font-size: 19px; /* 폰트 크기 설정 */
        border-radius: 5px; /* 버튼 모서리를 둥글게 만듦 */
        cursor: pointer; /* 커서 타입 설정 */
        left:1px;
       	margin-top: 45px; 
       	background-color:transparent;
       	border:none;
       	font-weight: bold;
    }
    
    .item_name {
    margin-top: 10px; /* 이미지와 상품 이름 사이 간격 조정 */
    font-weight: bold;
  }
    
   
</style>
</head>
<body>
<c:forEach var="dto" items="${Buyinglist }">
	<div class="button_container">
        <!-- 이미지 -->
        <img src="" alt="" class="item_image" style="background-image: url('이미지 주소');">
        <!-- 버튼 -->
        <input type="button" value="${dto.brand}" class="item_button" onclick="">
    </div>
			<div class="item_name">${dto.item_name }</div>
				<table border="1" align="center">
					<tr>
						<td colspan="2">정상가</td>
						<td>${dto.item_price }</td>
					</tr>
					<tr>
						<td colspan="2">제공가</td>
						<td>${dto.item_price }</td>
					</tr>
					<tr>
						<td colspan="2">교환처</td>
						<td>${dto.brand }</td>
					</tr>
					<tr>
						<td colspan="2">이용안내</td>
						<td>기간연장 및 환불불가</td>
					</tr>
					<tr>
						<td align="right"><input type="button" value="구매하기" onclick=""></td>
					</tr>
						
				</table>

	
	<hr>
	
	<h3>[상품명]</h3>
	
	<h3>${dto.item_name }</h3>
	<h3>[상품 정보]</h3>
	<h3>${dto.item_info }</h3>
	
	</c:forEach>
	
</body>
</html>