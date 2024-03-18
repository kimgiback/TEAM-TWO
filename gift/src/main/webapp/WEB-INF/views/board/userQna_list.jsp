    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/board/userQna_list.css?after">
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
                                <th class="headSubject">제목</th>
                                <th class="name">작성자</th>
                                <th class="date">날짜</th>
                            </tr>
                        </thead>
                        <tbody>                                                    
							<c:choose>
			
								<c:when test="${empty m_idx}">
									<c:forEach var="userQnaDTO" items="${list}">
										<tr>
											<td class="no">${userQnaDTO.qna_no}</td>
			                                <td class="select">${userQnaDTO.qu_select}</td>
			                                <td class="subjectTd">     
			                                    <div class="subjectBox">
			                                        <p class="subject" onclick="showContents();">${userQnaDTO.qu_title}</p>
			                                        <div class="myInquiry">
			                                            <P>   
			                                            	${userQnaDTO.qu_content}                                                                                        
			                                            </P>
			                                        </div>                                                               
			                                    </div>    
			                                </td>
			                                <td class="name">${memberDTO.m_name}</td>
			                                <td class="date">${userQnaDTO.regidate}</td>
		                                </tr>
	                                </c:forEach>
								</c:when>
							</c:choose>                                        
                        </tbody>
                    </table>
                    <button id="closeMyInquiry" onclick="closeContents();">문의글 닫기</button>
                </div>       
            </div>
        </section>
    </main>
    
<%@ include file="../commons/footer.jsp"%>
</body>
</html>
    
