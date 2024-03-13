    <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/item/wishCart.css">
<script src="resources/js/httpRequest.js"></script>
<script type="text/javascript">
	function qMinus(item_no) {
		
		let url = "${pageContext.request.contextPath}/cartList_quan_ajax";
		let param = "type=minus&item_no=" + item_no;
		
		sendRequest(url, param, qRs, "GET"); 
	}
	
	function qPlus(item_no) {
		
		let url="${pageContext.request.contextPath}/cartList_quan_ajax";
		let param = "type=plus&item_no=" + item_no;
		
		sendRequest(url, param, qRs, "GET");
	}
	
	function qRs() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			
			let data = xhr.responseText;
			let json = (new Function('return' + data))();
			
			console.log(json.result);
			
			if (json.result == 'one') {
				return;
			}
			
			if (json.result == 'over') {
				alert('재고');
				return;
			}
			
			let item_no = json.item.item_no;
			let item_price = json.item.item_price;
			let cart_quantity = json.item.cart_quantity;
					
			document.getElementById("itemQ" + item_no).innerText = cart_quantity;
			document.getElementById("itemP" + item_no).innerText = numberWithCommas(item_price * cart_quantity);
		
			updateTotalPrice();
		}
	}
/* 선택한 상품들을 배열에 넣어놨음 컨트롤러에서 jsp 출력만 하면 됨 */
	let checkedItems = [];
	
	function buy() {
		
		checkboxes.forEach(function(checkbox) {
			if (checkbox.checked) {
				checkedItems.push(checkbox.value);
			}
		});
		
		if (checkedItems.length == 0) {
			alert("선택된 상품이 없습니다.");
			return;
		}
		
		// 구현
	}
/*---------------------------------------------------  */
	function del() {
		
		checkboxes.forEach(function(checkbox) {
			if (checkbox.checked) {
				checkedItems.push(checkbox.value);
			}
		});
		
		if (checkedItems.length == 0) {
			alert("선택된 상품이 없습니다.");
			return;
		}
		
		let url = "${pageContext.request.contextPath}/cartList_del_ajax";
		let param = JSON.stringify({items: checkedItems}); // 배열을 JSON 문자열로 변환
		
		createRequest();
		xhr.open("POST", url, true);
		xhr.setRequestHeader("Content-Type", "application/json");
		xhr.onreadystatechange = delRs;
		xhr.send(param);
	}
	
	function delRs() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			
			checkedItems.forEach(function(item) {
	            let deletedRow = document.getElementById("check" + item);
	            if (deletedRow) {
	                deletedRow.parentNode.parentNode.remove();
	            }
	        });
			
			updateTotalPrice();
		}
	}
	
</script>
</head>
<body>
  <div id="wrapper">

    <header>
        header
        <input type="button" value="로고" onclick="location.href='${pageContext.request.contextPath}'">
	    <input type="button" value="장바구니" onclick="location.href='${pageContext.request.contextPath}/cartList'">
	    <input type="button" value="찜" onclick="location.href='${pageContext.request.contextPath}/wishList'">
	</header>

    <section id="sub-product" class="section">
      <div id="wishCartArea"> <!-- subcontents -->

            <h3 class="titline">장바구니</h3>

            <div class="wishCartTop">
              <!--체크박스 전체선택 -->
              <input type="checkbox" name="cartCheckAll" id="checkAll" checked="checked">&nbsp;전체선택
              <label for="productSelectAll"></label>
            </div>

            <table class="wishCartList tableStyle03">
                <colgroup>
                  <col style="width: 100px">
                  <col style>
                  <col style="width: 50px">
                  <col style="width: 200px">
                </colgroup>
                <thead>
                  <tr>
                    <th scope="col">&nbsp;</th>
                    <th scope="col">상품</th>
                    <th scope="col">수량</th>
                    <th scope="col">가격</th>
                  </tr>
                </thead>
                <tbody>
                
                <c:forEach var="list" items="${cartItemList}">
                  <tr class="tbody_tr style">
                    <!-- 체크박스 id,value변화 -->
                    <td>
                      <input type="checkbox" name="cartCheck" id="check${list.item_no}" value="${list.item_no}"> 
                      <label for="check"></label>
                    </td>
                    <!-- 상품 -->
                    <td class="tleft">
                      <div class="basketBox" onclick="location.href='${pageContext.request.contextPath}/item/${list.item_no}'">
                        <ul>
                          <!-- 이미지 -->
                          <li class="pimgArea">
                            <img src="${pageContext.request.contextPath}/resources/images/item/${list.item_image}.jpg">
                          </li>
                          <!-- 상품명 -->
                          <li class="tit">
                            <a>${list.item_name}</a>
                          </li>
                          <li class="company">${list.brand}</li>
                        </ul>
                      </div>
                    </td>
                    <!-- 수량 -->
                    <td>
                    	<div class="countWrap count">
	                        <button type="button" class="plus" onclick="qPlus(${list.item_no})">+</button>
	                        <span id="itemQ${list.item_no}" class="itemQ text_value">${list.cart_quantity}</span>
	                        <button type="button" class="minus" onclick="qMinus(${list.item_no})">-</button>
                    	</div>
                    </td>
                    <!-- 가격 -->
                    <td>
                      <div class="basket">
                        <ul>
                          <li id ="toPrice" class="toPrice">
                            <span id="itemP${list.item_no}" class="itemP text_value"><fmt:formatNumber value="${list.item_price * list.cart_quantity}" pattern="#,###"/></span>
                            <span class="">원</span>
                          </li>
                        </ul>
                      </div>
                    </td>
                  </tr>
                </c:forEach>
                  
                </tbody>
            </table>

          <div class="cartTotal">
            <!-- 총가격 -->
            <div class="totalPrice">
              <ul>
                <li class="descTxt">결제금액 : </li>
                <li class="price">
                  <span id="totalP" class="text_value"></span>원
                </li>
              </ul>
            </div>
            <!-- 버튼 -->
            <div class="btnArea">
              <ul>
                <li class="descTxt">선택한 상품</li>
                <li>
                  <a style="cursor: pointer;" class="btn_type09" onclick="buy()">
                    <span class="icogift"></span>
                    <span class="txt">구매하기</span>
                  </a>
                </li>
                <li>
                  <a style="cursor: pointer;" class="btn_type11" onclick="del()">
                  <span class="txt">삭제</span>
                  </a>
                </li>
              </ul>
            </div>
          </div>

      </div>

    </section>
  </div>

    <footer>
      footer
    </footer>

</body>
<script type="text/javascript">

let checkAll = document.getElementById("checkAll");
let checkboxes = document.getElementsByName("cartCheck");

document.addEventListener("DOMContentLoaded", function() {
	
	// 개별 선택
	checkboxes.forEach(function(checkbox) {
		
		checkbox.checked = checkAll.checked;
		
		checkbox.addEventListener("change", function() {
			console.log(checkbox.value);
			updateCheckAll();
			updateTotalPrice();
		});
	});
	
	// 전체 선택
	checkAll.addEventListener("change", function() {
		
		let isChecked = checkAll.checked;
		
		checkboxes.forEach(function(checkbox) {
			checkbox.checked = isChecked;
		});
		
		updateTotalPrice();
	});
	
	updateTotalPrice();
});

function updateCheckAll() {
	
	let anyUnchecked = false;
	
	checkboxes.forEach(function(checkbox) {
		if(!checkbox.checked) {
			anyUnchecked = true;
		}
	});
	
	checkAll.checked = !anyUnchecked;
}

function updateTotalPrice() {
	
	let totalPrice = 0;
	
	checkboxes.forEach(function(checkbox) {
		if (checkbox.checked)	{
			let itemPriceString = document.getElementById("itemP" + checkbox.value).innerText;
	        let itemPriceWithoutComma = parseInt(itemPriceString.replace(/,/g, ""));
	        totalPrice += itemPriceWithoutComma;
		}
	});
	
	document.getElementById("totalP").innerText = numberWithCommas(totalPrice);
}

//가격 콤마
function numberWithCommas(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
}
</script>
</html>
    
