<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
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

<script type="text/javascript">

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
	location.href="${pageContext.request.contextPath}/item/cartbuying?items="+checkedItems;
	// 구현
}
/*---------------------------------------------------  */
 
//결제 수단을 선택할 때 호출되는 함수
 function card(paymentType) {
     var payment = paymentType;
     var item_no = document.querySelector('input[name="item_no"]').value;
     
     let url = "card";
     
     let param = "payment=" + payment +
                 "&item_no=" + item_no;
     
     sendRequest(url, param, CardCheck, "post");
 }

//결제 수단 변경 후 처리하는 함수
 function CardCheck() {
     if (xhr.readyState == 4 && xhr.status == 200) {
         var item_no = document.querySelector('input[name="item_no"]').value;
         
         let data = xhr.responseText;
         let json = eval(data); // JSON 형식의 응답 데이터를 JavaScript 배열로 변환
         
         // 서버로부터 받은 데이터를 확인하여 팝업 창을 닫거나 다른 동작을 수행합니다.
         if (json[0].result == "success") {
             // 서버에서 처리가 성공했을 경우
             alert("결제수단이 변경되었습니다.");
             
             // 클릭한 값 결제수단에 반영
             var paymentValue =  document.querySelector('input[name="payment"]').value; // 서버에서 반환된 결제수단 값
             document.querySelector('#payment').innerText = paymentValue;
             console.log(paymentValue);
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

 // 페이지 로딩 시 초기화 및 이벤트 등록
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
                     alert("결제에 성공하셨습니다. 홈 화면으로 돌아갑니다.");
                    location.href = "${pageContext.request.contextPath}";
                 }   else if(json[0].result="no") {
                     alert("결제에 실패하셨습니다. 장바구니화면으로 돌아갑니다.");
                    location.href="${pageContext.request.contextPath}/item/cartbuying?items="+checkedItems;
                    }
              
                }
            }
        


</script>
</head>
<body>
<c:set var="totalPrice" value="0" />
<c:forEach var="dto" items="${cartbuyItem}">
    <c:set var="totalPrice" value="${totalPrice + dto.item_price}" />
    <div class="button_container">
        <img src="${pageContext.request.contextPath}/resources/images/item/${dto.img_name}.jpg" width="200" height="200" class="image">
        <input type="button" value="${dto.brand}" class="item_button" onclick="">
    </div>
    <div class="item_name"></div>
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
    </table>
</c:forEach>
<hr>
<table border="1">
    <tr>
        <td>결제 금액</td>
    </tr>
    <tr>
        <td colspan="2">상품 금액</td>
        <td>${totalPrice }</td>
    </tr>
    <tr>
        <td colspan="2">할인 금액</td>
        <td>0원</td>
    </tr>
    <tr>
        <td colspan="2">쿠폰</td>
        <td>0원</td>
    </tr>
    <tr>
        <td colspan="2">결제 수단</td>
       <td><input type="text" name="payment" value="삼성페이" readonly="readonly"></td>
    </tr>
    <tr>
        <td colspan="2">결제 금액</td>
        <td>${totalPrice }</td>
    </tr>
     <tr>
        <td><input type="button" value="결제하기" onclick="buying()"></td>
     </tr>   

</table>        
        
        <h2 style="margin-top: -94px;">결제수단</h2>
        <input type="button" value="신용카드" onclick="card('신용카드')" class="button" name="credit_button">
        <input type="button" value="휴대전화" onclick="card('휴대전화')" class="button" name="phone_button">
        <input type="button" value="삼성페이" onclick="card('삼성페이')" class="button" name="pay_button">
        <input type="button" value="계좌이체" onclick="card('계좌이체')" class="button" name="send_button">


</body>
</html>