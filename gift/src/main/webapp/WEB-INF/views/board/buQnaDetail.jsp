<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board/buQnaDetail.css">
<!-- 제이쿼리 -->
 <script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>

</head>
<body>
	<!-- 헤더영역 -->
	<jsp:include page="../commons/header.jsp"></jsp:include>
	
<!-- qna 하나 + 댓글 리스트, 댓글 쓰기 수정 삭제 -->
<div class="content">
	<h2>QnA 게시글</h2>
	<form role="qnaForm" class="qna">
		<div>
			<label for="qu_select">질문 유형선택</label>
			<input type="text" id="qu_select" name="qu_select"
				value="${qna.qu_select }" readonly="readonly">
		</div>
		<!-- 작성자명, 휴대전화번호 idx로 찾아서 보내주기 -->
		<div>
			<label for="member_name">작성자 이름</label>
			<input type="text" id="member_name" name="member_name"
				value="" readonly="readonly">
		</div>
		<div>
			<label for="member_phone">휴대전화 번호</label>
			<input type="text" id="member_phone" name="member_phone"
				value="" readonly="readonly">
		</div>
		<div>
			<label for="qu_title">제목</label>
			<input type="text" id="qu_title" name="qu_title"
				value="${qna.qu_title }" readonly="readonly">
		</div>
		<div>
			<label for="qu_content">내용</label>
			<input type="hidden" id="qu_content" name="qu_content"
				value="${qna.qu_content }" readonly="readonly">
	        <textarea class="qu_content">
	        	${qna.qu_content }
	        </textarea>
		</div>
	</form>
	
	<br/>
	<h2>QnA 답변</h2>
	
	<div class="replyList">
		<c:forEach var="reply" items="${replyList}">
		<!-- 수정, 삭제시 필요한 re_no 정보만 제출 -->
		<form role="replyForm" class="replyOne">
			<p>
				<input type="hidden" id="re_no" name="re_no"
					value="${reply.re_no }" readonly="readonly">
			</p>
		</form>
		

		<div class="writer">
		<div class="ti">작성자</div><div class="ticon">${writer.bu_name}</div> 
		</div>
		<div class="re_title">
			<div class="ti">제목</div><div class="ticon">${reply.re_title}</div>
		</div>
		<div class="re_content">
    	<div class="ti">내용</div>
	      <textarea class="re_con">
			${reply.re_content }
	      </textarea>
		</div>
		<div>
		
			<button type="button" id="replyUpdate">답글 수정</button>
			<button type="button" id="replyDelete">답글 삭제</button>
			
			<script>
				let replyForm1 = $("form[role='replyForm']");
				
				$("#replyUpdate").click(function(){
					replyForm1.attr("method", "get");
					replyForm1.attr("action", "/gift/bu/board/buReplyUpdateForm");
					replyForm1.submit();
				})
				
				let replyForm2 = $("form[role='replyForm']");
				
				$("#replyDelete").click(function(){
					replyForm2.attr("method", "post");
					replyForm2.attr("action", "/gift/bu/board/buReplyDelete");
					replyForm2.submit();
				})
			</script>
		</div>
		</c:forEach>
	
	</div>
	
	<br/>
	<h2>답변등록</h2>
	
	<div class="replyBtnPart">
		<div>
			<button type="button" id="replyWrite">문의답글 등록</button>
			
			<script>
				$("#replyWrite").click(function(){
					let qna_no = ${qna.qna_no};
					
					self.location="/gift/bu/board/buReplyWriteForm?qna_no="
							+qna_no;
				})
			</script>
		</div>
	</div>
</div>
	<!-- 푸터영역 -->
	<jsp:include page="../commons/footer.jsp"></jsp:include>
</body>
</html>