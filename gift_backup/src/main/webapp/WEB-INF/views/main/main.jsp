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
<script type="text/javascript">

</script>
</head>
<body>
<div id="wrapper">

	<!-- 헤더영역 -->
	<header>
	    header
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
								<span class="hot" onclick="btnSort(this)">인기순</span>
								<span class="lowPrice" onclick="btnSort(this)">낮은가격순</span>
								<span class="highPrice" onclick="btnSort(this)">높은가격순</span>
							</div>
						</div>
						<!-- 목록 -->
						<div class="itemListWrap clearfix">
							<ul id="itemList" class="itemList clearfix">
							
							</ul>
						</div>						
					</div>
				</div>
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

// 로딩시 전체 카테고리 클릭
document.addEventListener("DOMContentLoaded", function() {
	cate(cateList[0]);
	cateList[0].classList.add('on');
});

// 카테고리 클릭시 클래스 on 추가/제거
for(let i=0; i < cateList.length; i++) {
	
	
	cateList[i].addEventListener("click", function() {
		cateList[0].classList.remove('on');
		cateList[i].classList.add('on');
	});
}
for(let i=0; i< cateList.length; i++) {
	cateList[i].addEventListener("blur", function() {
		cateList[i].classList.remove('on');
	}); 
}

//인기순, 낮은가격순, 높은가격순 클릭시 정렬된 아이템 리스트 출력
function btnSort(btn) {
	
	switch(true) {
		case btn.classList.contains('hot') :
			for (let i=0; i < cateList.length; i++) {				
				if (cateList[i].classList.contains('on')) {
					
					// 전체 카테고리
					if (cateList[i].classList.contains('categorylist_all')) {
						url = "btn_sort_ajax";
						param = "category=" + 0;
						console.log('와');
						
						sendRequest(url, param, btnSortRs, "GET");
						return;
					}
					
					// 특정 카테고리
					url = "btn_sort_ajax";
					param = "category=" + cateList[i].classList[1];
					console.log(cateList[i].classList[1]);
					
					sendRequest(url, param, btnSortRs, "GET");
				}
			}
			console.log('인기순');
			break;
			
		case btn.classList.contains('lowPrice') :
			console.log('낮은가격순');
			break;
			
		case btn.classList.contains('highPrice') :
			console.log('높은가격순');
			break;
	}
}

//카테고리 클릭시 아이템 리스트 출력
function cate(cate) {
	// 전체 카테고리
	if(cate.classList.contains('categorylist_all')) {
		url = "list_ajax";
		param = "category=" + 0;

		sendRequest(url, param, cateRs, "GET");
		return;
	}
	
	// 특정 카테고리
	url = "list_ajax";
	param = "category=" + cate.classList[1];
	
	sendRequest(url, param, cateRs, "GET");
}

let listTag;

function cateRs() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		
		let cntTag = document.getElementById('itemListCnt');
		listTag = document.getElementById('itemList');
		
		let data = xhr.responseText;
		globalData = JSON.parse(data);
		
		let json = (new Function('return' + data))();
     	let count = json.count;
     
		let list = json.list;
		
    	cntTag.innerText = count;

		// 기존 아이템 리스트 제거
	    while (listTag.firstChild) {
			listTag.removeChild(listTag.firstChild);
	    }
		
		printList(list);
	}
}

function btnSortRs() {
	if (xhr.readySatate == 4 && xhr.status == 200) {
		console.log('결과');
	}
}
	
// 새로운 아이템 리스트 추가
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
	    priceSpan.textContent = item.item_price;
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