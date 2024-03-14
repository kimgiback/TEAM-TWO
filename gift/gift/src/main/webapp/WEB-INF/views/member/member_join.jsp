    <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/member_imfor_insert.css">

<!-- 

<script
  src="https://code.jquery.com/jquery-3.7.1.js"
  integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
  crossorigin="anonymous">
</script>

 -->

<script src="resources/js/httpRequest.js"></script>
<link rel="../../../resources/css/member/memberjoin.css">

<script type="text/javascript">


	
	function send(f) {
		let id = f.join_id_text.value.trim();
		let pwd = f.join_pw_text.value.trim();
		let name = f.join_name_text.value.trim();
		let addr = f.join_addr_text.value.trim();
		let email = f.join_email_text.value.trim();
		let phone = f.join_phone_text.value.trim();
		
	
		if(id==''){
			alert("아이디를 입력해주세요");
			return;
		}
		
		if(pwd==''){
			alert("비밀번호를 입력해주세요");
			return;
		}
		
		if(name==''){
			alert("이름을 입력해주세요");
			return;
		}
		
		if(addr==''){
			alert("주소를 입력해주세요");
			return;
		}
		
		if(email==''){
			alert("이메일을 입력해주세요");
			return;
		}
		
		if(phone==''){
			alert("휴대폰 번호를 입력해주세요");
			return;
		}
		
		//alert(id);
		//alert(pwd);
		//alert(name);
		//alert(addr);
		//alert(email);
		//alert(phone);
		
		
		let url = "mjoininsert";
		let param = "id="+encodeURIComponent(id)+"&pwd="+encodeURIComponent(pwd)+"&name="+encodeURIComponent(name)+"&addr="+encodeURIComponent(addr)+"&email="+encodeURIComponent(email)+"&phone="+encodeURIComponent(phone);
		
		let checked_id = document.getElementById("searched_member_id_for_join");
		if(checked_id.innerText == ''){
			alert('아이디 확인이 필요합니다.');
		}else{
			//파라미터 오류가 났어서 수정한적있음.
			
			//alert(param);
			sendRequest(url,param,callback,"POST");
		}
	}
	
	function callback() {
		if(xhr.readyState==4 & xhr.status==200) {
			alert("회원가입이 정상적으로 이루어졌습니다.");
			location.href='/gift/mlogin';
		}
	}	
	

	/*
		function callback(f) { // 데이터를 받고 요청에 성공
			if(xhr.readyState == 4 & xhr.status == 200) {
				alert('d');
			}
		}
	*/
	
	function idcheck(f) {
		//alert("아이디 체크 시험");
		
		//id값만 가져와 컨트롤러에 요청 보냄
		//onclick=idcheck(this.form)에서 this.form안붙여서 값 못가져옴.
		
		//id값, 파라미터로 만들어 링크 보낼 값
		let param_id = f.join_id_text.value.trim();
		let send_id = 'id='+param_id;
		
		
		if(param_id==''){ 
			alert('아이디를 입력해주세요'); 
			return;
		} else {
			//alert("가져온 아이디는 "+param_id);
			//id, url, get
			sendRequest( "midcheck", send_id, checkidback, "POST");
		}
		
		//리턴 못함..? 가능
		
		
		
		

	}
	
	function checkidback() {
		if(xhr.readyState==4 & xhr.status==200){
			
			//xhr.responseText를 써야 가져올수있음
			let check = xhr.responseText;
			
			//eval(param)로 함수 실행
			let check_result = eval(check);
			
			//변수에 집어넣음
			//뒤에 키값도 붙여야 함.
			let final_result = check_result[0]["result"];
			
			//콘솔에서 임시 확인
			console.log(final_result);
			
			
			if(final_result == 'no') {
				alert("중복된 아이디가 있습니다. 다시 입력해 주십시오.");
			} else if(final_result == 'yes'){
			//id가 데이터베이스에 조회 시도 후 null로 나온다면,
			//"searched_member_id_for_join"의 innerText에 값을 집어넣으려 함
			let checked_id = document.getElementById("searched_member_id_for_join");
			
			checked_id.innerText = "해당 아이디를 사용할 수 있습니다.";
			
			}
			
		}
	}

</script>


</head>
<body>
    <form>
        <table id="join_table">
        	<caption id="member_insert_title">회원가입</caption>
            <tr>
                <td class="join_col_style">
                	<div class="member_insert_intro_text">아이디</div>
                    <input type="text" placeholder="아이디를 입력해주세요" name="join_id_text" class="member_join_text">
                    <input type="button" value="아이디 중복확인" onclick="idcheck(this.form)" class="member_insert_id_check">
                    <div id="searched_member_id_for_join"></div>
                </td>
            </tr>
            <tr>
                <td class="join_col_style">
                	<div class="member_insert_intro_text">비밀번호</div>
					<input type="password" placeholder="비밀번호를 입력해주세요" name="join_pw_text" class="member_join_text">
                </td>
            </tr>
            <tr>
                <td class="join_col_style">
                	<div class="member_insert_intro_text">이름</div>
                    <input type="text" placeholder="성함을 입력해주세요" name="join_name_text" class="member_join_text">
                </td>
            </tr>
            <tr>
                <td class="join_col_style">
                	<div class="member_insert_intro_text">주소</div>
					<input type="text" placeholder="주소를 입력해주세요" name="join_addr_text" class="member_join_text">
                </td>
            </tr>
            <tr>
                <td class="join_col_style">
               		<div class="member_insert_intro_text">이메일</div>
                    <input type="text" placeholder="이메일을 입력해주세요" name="join_email_text" class="member_join_text">
                </td>
            </tr>
            <tr>
                <td class="join_col_style">
                	<div class="member_insert_intro_text">전화번호</div>
					<input type="text" placeholder="전화번호를 입력해주세요" name="join_phone_text" class="member_join_text">
                </td>
            </tr>
            <tr>
            	<td>
            		<input type="button" value="회원가입" onclick="send(this.form)" class="member_insert_select_detail">
            	</td>
            </tr>
        </table>
    </form>
</body>
</html>


    
