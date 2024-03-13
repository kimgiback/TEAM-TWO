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
<script src="${pageContext.request.contextPath}/resources/js/httpRequest.js"></script>
<script type="text/javascript">

function del(item_no) {
	
	let url = "wishList_del_ajax";
	let param = "item_no=" + item_no;
	
	sendRequest(url, param, delRs, "GET");
}

function delRs() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		
		let data = xhr.responseText;
		let json = (new Function('return' + data))();
		
		if (json.result == 'del_success') {
			alert('삭제 성공');
			
			let deletedRow = document.getElementById("tbody_tr" + json.item_no);
			deletedRow.remove();
			
			return;
		}
		
		alert('삭제 실패');
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
      <div id="wishCartArea"> 

            <h3 class="titline">찜</h3>
            <table class="wishCartList tableStyle03">
                <colgroup>
                  <col style>
                  <col style="width: 200px">
                  <col style="width: 140px">
                </colgroup>
                <thead>
                  <tr>
                    <th scope="col">상품</th>
                    <th scope="col">가격</th>
                    <th scope="col">삭제</th>
                  </tr>
                </thead>
                <tbody>
                
                <c:forEach var="list" items="${wishItemList}">
                <tr id="tbody_tr${list.item_no}" class="tbody_tr style">
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
                            <a style="cursor: pointer;" onclick="">${list.item_name}</a>
                          </li>
                          <li class="company">${list.brand}</li>
                        </ul>
                      </div>
                    </td>

                    <!-- 가격 -->
                    <td>
                      <div class="basket">
                        <ul>
                          <li class="toPrice">
                            <span class="f_num"><fmt:formatNumber value="${list.item_price}" pattern="#,###"/></span>
                            <span class="f_s14">원</span>
                          </li>
                        </ul>
                      </div>
                    </td>

                    <!-- 삭제 -->
                    <td>
                      <a onclick="del(${list.item_no})">
                        <div id="del" class="btnDel">
                        <img src="${pageContext.request.contextPath}/resources/images/close_pop.png">
						</div>
                      </a>
                    </td>

                  </tr>
                  </c:forEach>
                  
                </tbody>
            </table>
      </div>

    </section>
  </div>

    <footer>
      footer
    </footer>
</body>
</html>
    
