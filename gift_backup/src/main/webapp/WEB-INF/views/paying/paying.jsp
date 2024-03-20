<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/paying/paying.css">
<script src="resources/js/HttpRequest.js"></script>

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
            location.href="pay_info";
            
          
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
    var paymentValue = event.target.value;
    document.querySelector('input[name="payment"]').value = paymentValue;
    document.querySelector('.active').innerText = paymentValue;

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
    </script>

</head>
<body>

	<h2 style="margin-top:100px;">결제 정보</h2>
		<hr>
		<div>
			<div class="container">
			    <img src="C:\Users\opp\Desktop\images.jpg" width="200" height="200" class="image">
				    <div class="text-container">
				    	<c:forEach var="dto" items="${Payinglist}">
				    	<input type="hidden" name="payment" value="${dto.payment }">
				    	<input type="hidden" name="item_no" value="${dto.item_no }">
					       <span class="brand">${dto.brand}</span>
					       <span class="item_name">${dto.item_name }</span>
					       <span class="quantity">총 n개</span>
					       <span class="item_price">${dto.item_price }</span>
				       </c:forEach>
				   </div>
			</div>
		</div>
			
	<table border="1">
		<c:forEach var="dto" items="${Payinglist}">
			<tr>
				<td>결제 금액</td>
			</tr>
			<tr>
				<td colspan="2">상품 금액</td>
				<td>${dto.item_price }</td>
			</tr>
			<tr>
				<td colspan="2">할인 금액</td>
				<td>0원</td>
			</tr>
			<tr >
				<td colspan="2">쿠폰</td>
				<td>0원</td>
			</tr>
			<tr>
				<td colspan="2">결제 수단</td>
				<td>${dto.payment }</td>
			</tr>
			<tr>
				<td colspan="2">결제 금액</td>
				<td>${dto.item_price }</td>
			</tr>
			 <tr>
			 	<td><input type="button" value="구매하기" onclick=""></td>
			 </tr>	
		 </c:forEach>
	</table>		
			
		<h2 style="margin-top: -94px;">결제수단</h2>
		<input type="button" value="신용카드" onclick="card('신용카드')" class="button" name="credit_button">
		<input type="button" value="휴대전화" onclick="card('휴대전화')" class="button" name="phone_button">
		<input type="button" value="삼성페이" onclick="card('삼성페이')" class="button" name="pay_button">
		<input type="button" value="계좌이체" onclick="card('계좌이체')" class="button" name="send_button">

</body>
</html>