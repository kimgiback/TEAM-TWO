<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/forgot_m_id_pwd.css">
<script src="http://code.jquery.com/jquery-1.11.2.js"></script>

<script type="text/javascript">


	let random_value = null;
	
	
	function idcheck(f){
	

		
		//alert("dd");
		
		
		/*아이디 값 확인*/
		//alert(f);
		let check_id = f.checkid.value.trim();
		//alert(check_id);
		//alert("dd");
		
		
		if(check_id==null||check_id==''){
			alert("아이디를 입력해주십시오.");
			return;
		}
		
		$.ajax({
			type:"post",
			url:"midcheck",
			data:{id : check_id},
			success:function(data){
				//alert("성공");
				
				console.log(eval(data)[0]);
				
				let get_id = eval(data)[0];
				
				let alert_result = get_id["result"];
				console.log(alert_result);
				
				if(alert_result=="yes"){
					alert("존재하지 않는 아이디입니다.");
				} else{
					
					
					/*비밀번호 찾기에서 아이디 다 찾고 확인 누르면 나옴*/
					
					
					//button01 : 첫 바디, button02 : 두번째 바디
					let m_pwd_button01 = document.getElementById('forgot_m_pwd_name_body');
					let m_pwd_button02 = document.getElementById('hide_pwd_body');
					
					
					m_pwd_button01.style.display = "none";
					m_pwd_button02.style.display = "block";
					
				}
			},
			error:function(){
				alert("실패");
			}
		});
		
		
		
	
	}
	
	
	

	function check_phone(f) {
		
		let phone = f.phone.value.trim();
		
		
		if(phone==null||phone==''){
			alert("휴대폰 번호를 입력해주십시오.");
			return;
		}
		
		//alert("성공");
		$.ajax({
			
			url:"phone_authentication",
			data:{
				/*name: name,*/
				phone : phone
			},
			type:"post",
			success:function(data){
				console.log(eval(data)[0]["value"]);
				
				random_value = eval(data)[0]["value"];
			},
			error:function(){
				
			}
			
		});
	}
	
	
	
	function m_pwd_forgot_check01(f) {
		
		/*이름*/
		let name = f.name.value.trim();
		
		/*휴대전화번호*/
		let phone = f.phone.value.trim();
		
		/*인증번호*/
		let input_number = f.input_number.value.trim();
		
		/*아이디*/
		let id = f.checkid.value.trim();
		
		console.log(input_number);
		console.log(random_value);
		
		
		if(input_number==random_value){
			alert("휴대폰 인증이 성공하였습니다!");
			
			//비밀번호 랜덤 업데이트
			$.ajax({
				url:"m_pwd_entire_check",
				type:"get",
				data:{
					name : name,
					phone : phone,
					id : id
				},
				success:function(data){
					
					
					let result = eval(data)[0]["result"];
					console.log(result);
					
					if(result=="not_equal"){
						alert("입력한 정보로 회원정보를 찾을 수 없습니다");
					}else if(result=="equal"){
						alert("회원님의 휴대전화로 임시비밀번호를 발송했습니다.");
						
						
						location.href="/gift";
					}
					
				},
				error:function(){
					alert("에러가 발생했습니다.");
				}
				
			});
			//window.location.href="/gift";
		}else if(input_number!=random_value){
			alert("인증번호가 일치하지 않습니다.");	
		}else {
			alert("오류가 발생했습니다. 다시 시도해 주십시오.");
		}
	}
	
	//임시비밀번호 보내기
	function send_temp_pwd(f) {
		alert("알람");
	}
	


</script>

</head>
<body>
<%@ include file="../commons/header.jsp"%> 
	<form>
		<div id = "forgot_m_pwd_name_body">
			<a id="caption_finding_m_pwd">비밀번호 찾기</a>
			<a id="caption_finding_m_pwd_mini">아이디를 입력해주세요</a>
			<div class="forgot_m_id_pwd_row">
				<input type="text" name="checkid" id="forgot_m_pwd_idcheck_textinput">
			</div>
			<input type="button" id="m_pwd_check_final_button" value="확인" onclick="idcheck(this.form)">
		</div>
	
		<div class = "forgot_m_id_pwd_body" id="hide_pwd_body">
			<a id="caption_finding_m_pwd">비밀번호 찾기</a>
			<div class="forgot_m_id_pwd_row">
				<div class="forgot_m_id_pwd_text">이름</div>
				<input type="text" class="forgot_m_id_pwd_textinput" name="name">
			</div>
			<div class="forgot_m_id_pwd_row">
				<div class="forgot_m_id_pwd_text">휴대전화</div>
				<input type="text" class="forgot_m_id_pwd_textinput" name="phone">
			</div>
			<div class="forgot_m_id_pwd_row">
				<input type="button" id="forgot_m_id_pwd_textbutton" value="인증번호 발송" onclick="check_phone(this.form)">
			</div>
			<div class="forgot_m_id_pwd_row">
				<div class="forgot_m_id_pwd_text">인증번호</div>
				<input type="text" class="forgot_m_id_pwd_textinput" name="input_number">
			</div>
			<input type="button" id="m_pwd_check_final_button" value="비밀번호 찾기" onclick="m_pwd_forgot_check01(this.form)">
		</div>
	</form>
<%@ include file="../commons/footer.jsp"%> 
</body>
</html>