    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/board/userQna_form.css?after">
<script src="resources/js/board/userQna_form.js"></script>
</head>
<body>
<%@ include file="../commons/header.jsp"%> 
    <main>
        <section class="contents">
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

                <!-- inquiry-form -->
                <div class="inquiryBox">
                    <h2><a>＞</a>1:1 문의</h2>
                    <form action="userQna_insert" method="post" name="f">
                        <table class="inquiry">                            
                            <colgroup>
                                <col>
                                <col>
                            </colgroup>  
                            <tbody>                        
                                <tr>
                                    <th>질문 유형 선택</th>
                                    <td>
                                        <select name="typeChoice" id="typeChoice" class="selType01 type170">
                                            <option value="기타">기타</option>                                                                                       
                                            <option value="사용하기">사용하기</option>                                                            
                                            <option value="결제">결제</option>                                
                                            <option value="발송문의">발송문의</option>                                                
                                            <option value="선물보내기">선물보내기</option>                                                 
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>작성자 이름</th>
                                    <td>
	                                    <div class="writerBox">
                                    		<c:forEach var="dto" items="${memberDTO}">   
	                                    		<input type="hidden" name="writer" id="writer" value="${dto.m_name}">
												${dto.m_name}
	                                    	</c:forEach>                                                                    
	                                    </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <th>휴대폰 번호</th>
                                    <td>
	                                    <div class="phoneNoBox">
                                    		<c:forEach var="dto" items="${memberDTO}">
	                                    		<input type="hidden" name="phoneNo" id="phoneNo" value="${dto.m_phone}">
												${dto.m_phone}
	                                    	</c:forEach>                       
	                                    </div>   
                                    </td>
                                </tr>
                                <tr>
                                    <th>제목</th>
                                    <td><input type="text" class="w810" value="" id="title" name="title" size="30" placeholder="제목을 입력하세요(30자 내외)"></td>
                                </tr>
                                <tr class="inquiry_contents">
                                    <th>내용</th>
                                    <td>
                                        <textarea id="content" name="content" class=""></textarea>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </form>
                </div>

                <!-- info-agree -->
                <div class="info_policy">
                    <div class="title_policy">
                        <a class="title_policy_a">(필수)</a><strong>개인정보 수집 및 이용동의</strong>
                    </div>
                    <div class="con_policy_box">                                        
                        <div class="con_policy">
                            <table class="agreeTable">                        
                                <colgroup>
                                    <col>
                                    <col>
                                    <col>
                                </colgroup>
                                <thead>
                                    <tr>
                                        <th scope="col">항목</th>
                                        <th scope="col">목적</th>
                                        <th scope="col">보유 기간</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>이름, 이메일 주소, 연락처(휴대폰 번호)</td>
                                        <td>고객 확인 및 답변 회신</td>
                                        <td><strong>문의 처리일로 부터 3년</strong></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>                    
                    </div>                    
                    <div class="agreeCheckBox">
                        <div>
                            <ul>
                                <li>
                                    <p class="agreeCheckInfo"><input type="checkbox" name="agreeCheck" id="agreeCheck" value="Y"><a>개인정보 수집 및 이용에 동의합니다.</a></p>
                                </li>
                                <li>
                                    <p class="agreeCheckInfo"><a>gift에서 위와 같이 개인정보를 수집, 이용하는 것에 대해 거부하실 수 있으며, 거부 시 1:1 문의가 불가합니다</a></p>
                                </li>
                            </ul>              
                        </div>
                    </div>                    
                </div>   

                <!-- submit or cancel  -->
                <div class="btnBox">                        
                    <button type="button" class="registry sign" onclick="send_check(${noLogin});">등록</button>
                    <button type="button" class="registry cancel" onclick="location.reload();">취소</button>                        
                </div>
            </div>           
        </section>
    </main>
<%@ include file="../commons/footer.jsp"%>
</body>
</html>
    
