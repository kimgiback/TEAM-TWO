<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page trimDirectiveWhitespaces="true" %> <!-- html 공백 제거 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/item/item.css">
<script src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
<script type="text/javascript">

function cart(item_no) {
	let url = "${pageContext.request.contextPath}/cart_ajax";
	let param = "item_no=" + item_no;
		
	sendRequest(url, param, cartRs, "GET");
}

function cartRs() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		let data = xhr.responseText;
		let json = (new Function('return' + data))();
		
		if (json.result == 'add_success' || json.result == 'update_success') {
			if (confirm('추가 성공~ 장바구니로 이동?')) {
				location.href='${pageContext.request.contextPath}/cartList';
			}
			return;
		}
		
		alert('로그인 후 이용해주세요');
		location.href='${pageContext.request.contextPath}/mlogin';
	}
}

function wish(item_no) {
	let url = "${pageContext.request.contextPath}/wish_ajax";
	let param = "item_no=" + item_no;

	sendRequest(url, param, wishRs, "GET");
}

function wishRs() {
	if (xhr.readyState == 4 && xhr.status == 200) {

		let data = xhr.responseText;
		let json = (new Function('return' + data))();

		if (json.result == 'login_null') {
			alert('로그인 후 이용해주세요');
			location.href='${pageContext.request.contextPath}/mlogin';
			return;			
		}
		
		let likePush = document.getElementById('userLike');
			
		if (!likePush.classList.contains('likePush')){
			likePush.classList.add('likePush');
			likePush.childNodes[0].style.backgroundImage="url('${pageContext.request.contextPath}/resources/images/icn_like_pressed.png')";
			return;
		} else if (likePush.classList.contains('likePush')) {
			likePush.classList.remove('likePush');
			likePush.childNodes[0].style.backgroundImage="url('${pageContext.request.contextPath}/resources/images/icn_like_default.png')";
		}
	}
}

function payitem(f) {
	
	f.submit();
}
</script>
</head>
<body>
<form action="payitem" method="get" name="f">
<div id="wrapper">

	<!-- 헤더영역 -->
	<jsp:include page="../commons/header.jsp"></jsp:include>

    <section id="sub-product" class="section">

      <div id="detailArea">
        <!-- 상품 정보 -->
        <div class="detailInner clearfix">
        	<div class="imgWrap">
            	<img src="${pageContext.request.contextPath}/resources/images/item/${item.img_name}">
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
		                <span id="price" class="price">
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
	              <a onclick="cart(${item.item_no})">
	                <div id="userCart" class="btnCart"><em></em></div>
	              </a>
	              <!-- 찜 -->
	              <c:choose>
	              	<c:when test="${wish eq 'exists'}">
	              		<a onclick="wish(${item.item_no})">
	               			<div id="userLike" class="btnLike likePush"><em></em></div>
	              		</a>
	              	</c:when>
	              	<c:when test="${wish eq 'no'}">
	              		<a onclick="wish(${item.item_no})">
	               			<div id="userLike" class="btnLike"><em></em></div>
	              		</a>
	              	</c:when>
	              	<c:when test="${wish eq 'null'}">
	              		<a onclick="wish(${item.item_no})">
	               			<div id="userLike" class="btnLike"><em></em></div>
	              		</a>
	              	</c:when>
	              </c:choose>
	                <!-- 구매하기 -->
	              <c:choose>
	              <c:when test="${!empty m_idx}">
	              <a href="payitem?item_no=${item.item_no }">
	                <div class="btnBuy">구매하기</div>
	              </a>
	              </c:when>
	              <c:when test="${empty m_idx}">
	              <a href="/gift/mlogin">
	              	<div class="btnBuy">구매하기</div>
	              </a>
	              </c:when>
	              </c:choose>

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

  </form>  
</body>
<script type="text/javascript">

// 가격 콤마
function numberWithCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

document.addEventListener("DOMContentLoaded", function() {	
	let price = document.getElementById("price").getElementsByTagName("em")[0].innerText;
	document.getElementById("price").getElementsByTagName("em")[0].innerText = numberWithCommas(price);
});

</script>
</html>