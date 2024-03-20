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

            <h3 class="titline">찜</h3>
            <table class="wishcartList tableStyle03">
                <colgroup>
                  <col style>
                  <col style="width: 200px">
                  <col style="width: 50px">
                </colgroup>
                <thead>
                  <tr>
                    <th scope="col">상품</th>
                    <th scope="col">가격</th>
                    <th scope="col">삭제</th>
                  </tr>
                </thead>
                <tbody>
                  <tr class="tbody_tr1 style">

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

                    <!-- 삭제 -->
                    <td>
                      <a onclick="">
                        <img src="" alt="삭제">
                      </a>
                    </td>

                  </tr>
                </tbody>
                <tbody>
                  <tr class="tbody_tr1 style">

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

                    <!-- 삭제 -->
                    <td>
                      <a onclick="">
                        <img src="" alt="삭제">
                      </a>
                    </td>

                  </tr>
                </tbody>
                <tbody>
                  <tr class="tbody_tr1 style">

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

                    <!-- 삭제 -->
                    <td>
                      <a onclick="">
                        <img src="" alt="삭제">
                      </a>
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
      </div>

    </section>
  </div>

    <footer>
      footer
    </footer>
</body>
</html>