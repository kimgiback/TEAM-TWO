<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/board/userQna_list.css">
<script src="resources/js/board/userQna_list.js"></script>
</head>
<body>
<%@ include file="../commons/header.jsp"%>

    <main>  
        <section class="board content"> 
            <div class="inner">
                <!-- sub-menu -->
                <div class="subMenu">
                    <ul class="tab">
                        <li>                        
                            <button type="button" class="menuBtn" onclick="location.href='userQna_form'">1:1 문의</button>                            
                        </li>
                        <li>    
                            <button type="button" class="menuBtn" onclick="location.href='userQna_list'">내 문의 보기</button>                        
                        </li>
                    </ul>
                </div>

                <!-- board(MyInquiry) -->
                <div class="inner">
                    <div class="titleBox">
                        <h2 class="title"><a>＞</a>내 문의 보기</h2>
                    </div>
                    <table>
                        <colgroup>
                            <col>
                            <col>
                            <col>
                            <col>
                            <col>
                        </colgroup>
                        <thead>
                            <tr>
                                <th class="no">번호</th>
                                <th class="select">질문유형</th>
                                <th class="subject">제목</th>
                                <th class="name">작성자</th>
                                <th class="date">날짜</th>
                            </tr>
                        </thead>
                        <tbody>                                                    
							<c:choose>
								<c:when test="${empty m_idx}">
									<!-- m_idx 가 세션에 비어있는 경우 -->
									
								</c:when>				
								<c:when test="${not empty m_idx}">
									<c:forEach var="dto" items="${list}">
										<tr>
											<td class="no">${dto.qna_no}</td>
			                                <td class="select">주문 취소</td>
			                                <td class="subjectTd">     
			                                    <div class="subjectBox">
			                                        <p class="subject" onclick="showContents();">${dto.qu_title}</p>
			                                        <div class="myInquiry">
			                                            <P>   
			                                            	${dto.qu_content}                                             
			                                                기프티 쿠폰의 주문 취소는 [마이페이지 > 결제내역 > 취소하고자 하는 상품 클릭] 을 에서 취소하실 수 있으며, 구매 일로부터 7일 이내에는 주문 취소가 가능합니다. 주문을 취소할 경우 결제 승인을 취소하며, 주문 취소 시 수신자에게는 쿠폰 사용 불가 안내 메시지가 전달됩니다. 단, 휴대폰 소액결제로 결제한 주문자가 결제 월이 지난 이후, 주문 취소를 원할 경우에 한하여, 유효기간 내 환불이 가능합니다. (통신사 정책에 따라 휴대폰 소액결제의 이월취소는 불가)
			                                            </P>
			                                        </div>                                                               
			                                    </div>    
			                                </td>
			                                <td class="name">${memberDTO.m_name}</td>
			                                <td class="date">${dto.regidate}</td>
		                                </tr>
	                                </c:forEach>
								</c:when>
							</c:choose>                                        
                        </tbody>
                    </table>
                    <button id="closeMyInquiry" onclick="closeContents();">문의글 닫기</button>
                </div>

                <!-- pageNo -->
                <!-- <div class="boxWrap">
                    <div class="pageNoBox"><span class="pageNo">${pageMenu}</span></div>
                </div>    -->         
            </div>
        </section>
    </main>
    
<%@ include file="../commons/footer.jsp"%>
</body>
</html>