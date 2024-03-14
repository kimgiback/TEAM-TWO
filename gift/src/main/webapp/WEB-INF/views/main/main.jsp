    <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/main/main.css">
<script src="resources/js/httpRequest.js"></script>
<script type="text/javascript"></script>
</head>
<body>
<div id="wrapper">

	<!-- 헤더영역 -->
	<header>
	    header
	    <input type="button" value="로고" onclick="location.href='${pageContext.request.contextPath}'">
	    <input type="button" value="장바구니" onclick="location.href='${pageContext.request.contextPath}/cartList'">
	    <input type="button" value="찜" onclick="location.href='${pageContext.request.contextPath}/wishList'">
	</header>

	<main>
		<!-- 광고 -->
		<section id="main-banner" class="section">
			<div class="swiper _swiper-01">
				<div class="swiper-wrapper">
				광고배너
				</div>
			</div>
		</section>
		
		<!-- 상품목록 -->
		<section id="main-product" class="section clearfix">
			<div class="wrap clearfix">	
				<!-- 카테고리 -->
				<div id="cateArea">
					<div class="cateListWrap">
						<ul class="cateList">
							<li id="category" class="category categorylist_all" onclick="cate(this)" tabindex="0">
								<a>
									<div class="img">
										<img src="resources/images/main/cate00.png" alt="전체">
									</div>
										<p>전체</p>
								</a>
							</li>
							<c:forEach var="cate" items="${cateInfo}" >
							<li id="category" class="category ${cate.category_no}" onclick="cate(this)" tabindex="0">
								<a>
									<div class="img">
										<img src="resources/images/main/cate0${cate.category_no}.png" alt="${cate.category_name}">
									</div>
										<p>${cate.category_name}</p>
								</a>
							</li>
							</c:forEach>
						</ul>			
					</div>
				</div>
				<!-- //카테고리 -->
				
				<!-- 상품 -->
				<div id="itemArea" class="clearfix">
					<div class="itemInner clearfix">
						<!-- 탭 -->
						<div class="tabWrap">
							<p class="total">총 
							<strong id="itemListCnt">${itemCount}</strong>
							개
							</p>
							<div class="tab">
								<span id="sortBtn" class="hit" onclick="btnSort(this)">인기순</span>
								<span id="sortBtn" class="priceAsc" onclick="btnSort(this)">낮은가격순</span>
								<span id="sortBtn" class="priceDesc" onclick="btnSort(this)">높은가격순</span>
							</div>
						</div>
						<!-- 목록 -->
						<div class="itemListWrap clearfix">
							<ul id="itemList" class="itemList clearfix">
							
							</ul>
						</div>						
					</div>
				</div>
				<div id="paging"></div>
				<!-- //상품 -->
			</div>
		</section>
	</main>
</div>

	<!-- 푸터영역 -->
    <footer>
		footer
	</footer>

</body>
<script type="text/javascript">

let cateList = Array.from(document.querySelectorAll("#category"));
let btnList = Array.from(document.querySelectorAll("#sortBtn"));

let listTag = document.getElementById('itemList');

//가격 콤마
function numberWithCommas(x) {
	  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}

// 로딩시 전체 카테고리 선택
document.addEventListener("DOMContentLoaded", function() {	
	cate(cateList[0]);
});

//카테고리별 상품 정렬
function sort(sort, page) {
	cateList.forEach(function(cateItem) {
	    if (cateItem.classList.contains('on')) {
	        if (cateItem.classList.contains('categorylist_all')) {
	            url = "list_ajax";
	            param = "cate_no=" + 0 + "&sort=" + sort + "&page=" + (page ? page : "");
	            sendRequest(url, param, cateRs, "GET");
	            return;
	        }
	        url = "list_ajax";
	        param = "cate_no=" + cateItem.classList[1] + "&sort=" + sort;
	        sendRequest(url, param, cateRs, "GET");
	    }
	});
} 

// 인기순, 낮은가격순, 높은가격순 클릭시 정렬된 상품 리스트 출력
function btnSort(btn) {
	
	btnList.forEach(function(btnItem) {
		btnItem.classList.remove('on');
	});
	btn.classList.add('on');

	switch(true) {
		case btn.classList.contains('hit') :
			sort('hit');
			console.log('인기순');
			break;
		case btn.classList.contains('priceAsc') :
			sort('priceAsc');
			break;
		case btn.classList.contains('priceDesc') :
			sort('priceDesc');
			break;
	}
}

// 카테고리 클릭시 상품 리스트 출력
function cate(cate) {
	
	cateList.forEach(function(cateItem) {
		cateItem.classList.remove('on');
	});
	cate.classList.add('on');
	
	btnSort(btnList[0]);
}

function cateRs() {
	if (xhr.readyState == 4 && xhr.status == 200) {

		let cntTag = document.getElementById('itemListCnt');
		let paging = document.getElementById('paging');
		
		let data = xhr.responseText;
		let json = (new Function('return' + data))();
		
     	let count = json.count;
		let list = json.list;
		let pageMenu = json.pageMenu;
		
		console.log(json);
		
    	cntTag.innerText = count;
    	paging.innerHTML = pageMenu;

	    while (listTag.firstChild) {
			listTag.removeChild(listTag.firstChild);
	    }
	    
		printList(list);
	}
}
	
function printList(list) {
	
	list.forEach(item => {
		let listItem = document.createElement('li');
	    listItem.classList.add('item');
	      
	    let link = document.createElement('a');
	    link.href = 'item/' + item.item_no;
	    link.classList.add('inner');
	     
	    let imgDiv = document.createElement('div');
	    imgDiv.classList.add('item_img');
	    let img = document.createElement('img');
	    img.src = 'resources/images/item/' + item.item_image + '.jpg';
	    imgDiv.appendChild(img);
	      
	    let txtWrapDiv = document.createElement('div');
	    txtWrapDiv.classList.add('txtWrap');
	    let brandSpan = document.createElement('span');
	    brandSpan.classList.add('brandNm');
	    brandSpan.textContent = item.brand;
	    let itemNameP = document.createElement('p');
	    itemNameP.classList.add('itemNm');
	    itemNameP.textContent = item.item_name;
	    let priceSpan = document.createElement('span');
	    priceSpan.classList.add('price');
	    priceSpan.textContent = numberWithCommas(item.item_price);
	    txtWrapDiv.appendChild(brandSpan);
	    txtWrapDiv.appendChild(itemNameP);
	    txtWrapDiv.appendChild(priceSpan);			
		      
		link.appendChild(imgDiv);
		link.appendChild(txtWrapDiv);
		listItem.appendChild(link);
		      
		listTag.appendChild(listItem);
	});
}

</script>
</html>
    
