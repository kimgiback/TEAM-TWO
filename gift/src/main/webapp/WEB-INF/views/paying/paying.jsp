
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pay/paying.css">

<script src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
<script type="text/javascript">

function card(paymentType) {
    var payment = paymentType;
    var item_no = document.querySelector('input[name="item_no"]').value;
    
    let url = "card";
    
    let param = "payment=" + payment +
                "&item_no=" + item_no;
    
    sendRequest(url, param, CardCheck, "post");
    
    
}

function CardCheck() {
    if (xhr.readyState == 4 && xhr.status == 200) {
    	
    	var item_no = document.querySelector('input[name="item_no"]').value;
    	
        let data = xhr.responseText;
        let json = eval(data); // JSON 형식의 응답 데이터를 JavaScript 배열로 변환
           
        // 서버로부터 받은 데이터를 확인하여 팝업 창을 닫거나 다른 동작을 수행합니다.
        if (json[0].result == "success") {
            // 서버에서 처리가 성공했을 경우
            alert("결제수단이 변경되었습니다.");
            //클릭한 값 결제수단에 반영
            var paymentValue =  document.querySelector('input[name="payment"]').value; // 서버에서 반환된 결제수단 값
            document.querySelector('.active').innerText = paymentValue;
            console.log(paymentValue);
            location.href = "payitem?item_no=" + item_no;
            
          
        } else if (json[0].result == "fail") {
            // 서버에서 처리가 실패했을 경우
        	alert("결제수단 변경에 실패했습니다.");
           
        }
        
    }    
}

// 버튼 클릭 이벤트 처리 함수
function handleButtonClick(event) {
	var paymentType = event.target.value;
	
    var localButtons = document.querySelectorAll('.button'); // 지역 변수로 변경
    // 모든 버튼에서 'active' 클래스 제거
    localButtons.forEach(function(btn) {
        btn.classList.remove('active');
    });

    // 현재 클릭한 버튼에만 'active' 클래스 추가
    event.target.classList.add('active');

    // 클릭한 버튼의 값을 결제 수단에 바로 반영
    document.querySelector('input[name="payment"]').value = paymentType;
    document.querySelector('#payment').innerText = paymentType;

    // card 함수 호출
    card(paymentType);
    
}

document.addEventListener("DOMContentLoaded", function() {
    var buttons = document.querySelectorAll('.button');

    // 각 버튼에 클릭 이벤트 리스너 등록
    buttons.forEach(function(btn) {
        btn.addEventListener('click', handleButtonClick);
    });
});

function buying() {
	
	let item_no = document.querySelector('input[name="item_no"]').value;
	let m_idx = document.querySelector('input[name="m_idx"]').value;
	let payment = document.querySelector('input[name="payment"]').value;
	
	let url = "BuyingCheck";
	let param ="item_no="+item_no+
				"&m_idx="+m_idx+
				"&payment="+payment;
	
	sendRequest(url, param, BuyingCheck, "post");
	
}


function BuyingCheck() {
   
	var item_no = document.querySelector('input[name="item_no"]').value;
	
            if (xhr.readyState == 4 && xhr.status == 200) {
                	var data = xhr.responseText;
                	var json = (new Function('return' + data))();
                	
            if (!confirm("정말 결제하시겠습니까? 진짜로??")) {
                	  alert("결제를 취소하셨습니다.상품 화면으로 돌아갑니다."); 
                	  return;
                	    } 
            
            else if (json[0].result == "yes") {
                   	 alert("결제에 성공하셨습니다. 상품 화면으로 돌아갑니다.");
                   	location.href = "payitem?item_no=" + item_no;
               	 } 	else if(json[0].result="no") {
                   	 alert("결제에 실패하셨습니다. 결제화면으로 돌아갑니다.");
                   	location.href = "payitem?item_no=" + item_no;
                	}
          
            	}
    		}
		
		function payitem(f) {
			    
			f.submit();
		}
		
    </script>

</head>
<body>

<!-- 헤더영역 -->
	<jsp:include page="../commons/header.jsp"></jsp:include>
	
	
<div class="pay-wrap">
  <h2 class="bLine">결제정보</h2>
  <form action="payitem" method="post" name="f">
  <div class="col-type=01 justify-cont">
  
    <div class="one">
      <div class="gift-info row-type03">
  
        <div class="pimg gift-img">
          <img src="${pageContext.request.contextPath}/resources/images/item/${ItemOne.img_name}">
        </div>
  
        <div class="gift-info-desc order">
          <input type="hidden" name="payment" value="${ItemOne.payment}"> 
                           <input type="hidden" name="item_no" value="${ItemOne.item_no}">
                           <input type="hidden" name="m_idx" value="${ItemOne.m_idx}">
  
          <span class="brandNm">${ItemOne.brand}</span>
          <p class="goodsNm">${ItemOne.item_name}</p>
          <p class="count">총 <span class="phoneCnt">1</span>개</p>
          <div class="itemPrice"><span class="price">${ItemOne.item_price}</div>
        </div>
  
      </div>
  
      <div class="row-type03">
        <h3>결제 수단</h3>
        <ul class="grid-container _tab04" id="pay_method_area">
          <li>
            <input type="button" value="신용카드" onclick="card('신용카드')" class="button" name="credit_button">
          </li>
          <li>
            <input type="button" value="휴대전화" onclick="card('휴대전화')" class="button" name="phone_button">
          </li>
          <li>
            <input type="button" value="삼성페이" onclick="card('삼성페이')" class="button" name="pay_button">
          </li>
          <li>
            <input type="button" value="계좌이체" onclick="card('계좌이체')" class="button" name="send_button">
          </li>
        </ul>	
      </div>
  
    </div>
  </form>
  
  
    <div class="two">
      <div class="box-type01">
        <h3>결제 금액</h3>
        <table>
          <tbody>
            <tr>
              <th>상품 금액</th>
              <td><strong id="total_sale_price">${ItemOne.item_price }</strong>원</td>
            </tr>
            <tr>
                      <th>할인 금액</th>
                     <td>0원</td>
                  </tr>
            <tr>
                      <th>쿠폰</th>
                     <td>0원</td>
                  </tr>
  
        </table>

        <table class="t-foot">
          <tbody id="pay_method_name">
            <tr>
              <th>결제 수단</th>
              <td id="pg_name">${ItemOne.payment }</td>
            </tr>
          </tbody>
          <tfoot>
            <tr>
              <th>결제 금액</th>
              <td><strong id="final_price">${ItemOne.item_price }</strong>원</td>
            </tr>
          </tfoot>
        </table>

      </div>
  
    </div>
  
  </div>
  
  <div class="btnBuyArea">
    <input type="button" value="결제하기" onclick="buying()">
  </div>
  
<!-- 푸터영역 -->
	<jsp:include page="../commons/footer.jsp"></jsp:include>
	
  </body>
</html>