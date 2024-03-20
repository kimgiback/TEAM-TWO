<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main/item.css">
</head>
<body>
  <div id="wrapper">

    <header>
        header
    </header>

    <section id="sub-product" class="section">
      <div id="wishcartArea"> <!-- subcontents -->

            <h3 class="titline">장바구니</h3>

            <div class="wishcartTop">
              <!--체크박스전체선택 -->
              <input type="checkbox" name="userCartCheckAll" value="" id="productSelectAll" class="type03">전체선택
              <label for=""productSelectAll"></label>
              <!-- 체크박스선택삭제 -->
              <button>삭제</button>
            </div>

            <table class="wishcartList tableStyle03">
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
                  <tr class="tbody_tr1 style">

                    <!-- 체크박스 id,value변화 -->
                    <td>
                      <input type="checkbox" name="userCartCheck" value="" id="productSelect" class="type03"> 
                      <label for=""productSelect1"></label>
                    </td>

                    <!-- 상품 -->
                    <td class="tleft">
                      <div class="basketBox">
                        <ul>
                          <!-- 이미지 -->
                          <li class="pimgArea">
                            <img src="">
                          </li>
                          <!-- 상품명 -->
                          <li class="tit">
                            <a style="cursor: pointer;" onclick="">카페라떼</a>
                          </li>
                          <li class="company">스타벅스</li>
                        </ul>
                      </div>
                    </td>

                    <!-- 수량 -->
                    <td>
                      1
                    </td>

                    <!-- 가격 -->
                    <td>
                      <div class="basket">
                        <ul>
                          <li class="toPrice">
                            <span class="f_num">5,000</span>
                            <span class="f_s14">원</span>
                          </li>
                        </ul>
                      </div>
                    </td>

                  </tr>
                </tbody>
                <tbody>
                  <tr class="tbody_tr1 style">

                    <!-- 체크박스 id,value변화 -->
                    <td>
                      <input type="checkbox" name="userCartCheck" value="" id="productSelect" class="type03"> 
                      <label for=""productSelect1"></label>
                    </td>

                    <!-- 상품 -->
                    <td class="tleft">
                      <div class="basketBox">
                        <ul>
                          <!-- 이미지 -->
                          <li class="pimgArea">
                            <img src="">
                          </li>
                          <!-- 상품명 -->
                          <li class="tit">
                            <a style="cursor: pointer;" onclick="">카페라떼</a>
                          </li>
                          <li class="company">스타벅스</li>
                        </ul>
                      </div>
                    </td>

                    <!-- 수량 -->
                    <td>
                      1
                    </td>

                    <!-- 가격 -->
                    <td>
                      <div class="basket">
                        <ul>
                          <li class="toPrice">
                            <span class="f_num">5,000</span>
                            <span class="f_s14">원</span>
                          </li>
                        </ul>
                      </div>
                    </td>

                  </tr>
                </tbody>
            </table>

          <!-- 페이징 -->
          <div class="paging wish_page" id="paging">
            <span class="number">
                1&nbsp;2&nbsp;3
            </span>
          </div>

          <div class="cartTotal">
            <!-- 총가격 -->
            <div class="totalPrice">
              <ul>
                <li class="descTxt">결제금액 : </li>
                <li class="price">
                  <span class="f_num f_point02" id="total_pay_price">5,000</span>원
                </li>
              </ul>
            </div>
            <!-- 버튼 -->
            <div class="btnArea">
              <ul>
                <li class="descTxt">선택한 상품</li>
                <li>
                  <a style="cursor: pointer;" class="btn_type09" onclick="">
                    <span class="icogift"></span>
                    <span class="txt">구매하기</span>
                  </a>
                </li>
                <li>
                  <a style="cursor: pointer;" class="btn_type11" onclick="">
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
</html>