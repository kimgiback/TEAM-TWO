<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page trimDirectiveWhitespaces="true" %> <!-- html 공백 제거 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main/item.css">
</head>
<body>
<div id="wrapper">

    <!-- 헤더영역 -->
    <header>
    	header
    </header>
    
    <section id="sub-product" class="section">

      <div id="detailArea">

        <!-- 상품 정보 -->
        <div class="detailInner clearfix">
        	<div class="imgWrap">
            	<img src="${pageContext.request.contextPath}/resources/images/item/${item.item_image}.jpg">
            	이미지
          	</div>
          	<div class="txtWrap">
            	<div class="txtWrap-min">
	              	<a href="">
	              		<div class="brandNm">
	                  	<!-- 브랜드 로고 -->
	                  		<div class="brandImg">
	                  		<c:choose>
	                  			<c:when test="${item.brand eq '스타벅스'}">
	                  				<img src="${pageContext.request.contextPath}/resources/images/main/brand1.jpg" alt="${item.brand}" class="img_brand">
	                  			</c:when>
	                  			<c:when test="${item.brand eq '뚜레쥬르'}">
	                  				<img src="${pageContext.request.contextPath}/resources/images/main/brand2.jpg" alt="${item.brand}" class="img_brand">
	                  			</c:when>
	                  			<c:when test="${item.brand eq '배스킨라빈스'}">
	                  				<img src="${pageContext.request.contextPath}/resources/images/main/brand3.jpg" alt="${item.brand}" class="img_brand">
	                  			</c:when>
	                  			<c:when test="${item.brand eq '버거킹'}">
	                  				<img src="${pageContext.request.contextPath}/resources/images/main/brand4.jpg" alt="${item.brand}" class="img_brand">
	                  			</c:when>
	                  			<c:when test="${item.brand eq '굽네치킨'}">
	                  				<img src="${pageContext.request.contextPath}/resources/images/main/brand5.jpg" alt="${item.brand}" class="img_brand">
	                  			</c:when>
	                  		</c:choose>
	                  		</div>
	                  		<span>${item.brand}</span>
	                	</div>
	              	</a>
	             	<div class="itemNm">${item.item_name}</div>
	             	<div class="itemPrice">
		                <span class="price">
		                	<em>${item.item_price}</em>
		                	<span>원</span>
		                </span>
	              	</div>
             		<div class="itemInfo">
                	<p><span>교환처</span>${item.brand}</p>
              		</div>
            	</div>
	            <div class="btnSet">
	              <!-- 장바구니 -->
	              <a href="">
	                <div class="btnCart" id="userCart"><em></em></div>
	              </a>
	              <!-- 찜 -->
	              <a href="">
	                <div class="btnLike" id="userLike"><em></em></div>
	              </a>
	              <!-- 구매하기 -->
	              <a href="">
	                <div class="btnBuy">구매하기</div>
	              </a>
	      		</div>
          </div>
        </div>

        <!-- 상품 설명 -->
        <div class="detailInfo">
        	<Strong>상품상세</Strong>
        	<p class="detailTxt">
			${item.item_info}
            </p>
		</div>

	</div>

    </section>
  </div>
  
    <!-- 푸터영역 -->
    <footer>
      footer
    </footer>
    
</body>
</html>