<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/board/userQna_form.css">
<script type="text/javascript">
	

	
</script>
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
                    <h2><a>＞</a>문의하기</h2>
                    <form action="insert" method="post" name="f">
                        <table class="inquiry">                            
                            <colgroup>
                                <col>
                                <col>
                            </colgroup>  
                            <tbody>                        
                                <tr>
                                    <th>질문 유형 선택</th>
                                    <td>
                                        <select name="inquiry_type" id="typeChoice" class="selType01 type170">
                                            <option value="" selected="selected">선택</option>                                  
                                            <option value="10">사용하기</option>                                                                                       
                                            <option value="11">결제</option>                                                            
                                            <option value="13">발송문의</option>                                
                                            <option value="9">선물보내기</option>                                                
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>작성자 이름</th>
                                    <td>
                                    	<c:forEach var="dto" items="${memberList}">   
	                                    	<div class="writer">
	                                    		<%-- <input type="hidden" name="writer" value="${dto.m_name}">  --%>
												${dto.m_name}
	                                        </div> 
	                                    </c:forEach>                                                                    
                                    </td>
                                </tr>
                                <tr>
                                    <th>휴대폰 번호</th>
                                    <td>
                                    	<c:forEach var="dto" items="${memberList}">
	                                    	<div class="phoneNo">
	                                    		<%-- <input type="hidden" name="phoneNo" value="${dto.m_phone}">  --%>
												${dto.m_phone}
	                                        </div>   
	                                    </c:forEach>                       
                                    </td>
                                </tr>
                                <tr>
                                    <th>제목</th>
                                    <td><input type="text" class="w810" value="" id="title" name="title" size="50" placeholder="제목을 입력하세요(50자 내외)"></td>
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
                                    <p class="agreeCheckInfo"><input type="checkbox" name="agreeCheck" id="agreeCheck" onchange="agreeCheck(this);"><a>개인정보 수집 및 이용에 동의합니다.</a></p>
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
                    <button type="button" class="registry sign" onclick="send_check();">등록</button>
                    <button type="button" class="registry cancel" onclick="send_cancel();">취소</button>                        
                </div>
            </div>           
        </section>
    </main>
<%@ include file="../commons/footer.jsp"%>

</body>
</html>