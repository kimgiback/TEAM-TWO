<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>



<script src="resources/js/HttpRequest.js"></script>
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
		
		
		let url = "mjoininsert";
		let param = "id="+encodeURIComponent(id)+"&pwd="+encodeURIComponent(pwd)+"&name="+encodeURIComponent(name)+"&addr="+encodeURIComponent(addr)+"&email"+encodeURIComponent(email)+"&phonne"+encodeURIComponent(phone);
		
		//alert(param);
		sendRequest(url,param,"POST");
	}
	
	

</script>


</head>
<body>
    <form>
        <table id="join_table">
            <tr>
                <td class="join_col_style">
                	<div>아이디</div>
                    <input type="text" placeholder="아이디를 입력해주세요" name="join_id_text" id="login_id_text">
                </td>
            </tr>
            <tr>
                <td class="join_col_style">
                	<div>비밀번호</div>
					<input type="password" placeholder="비밀번호를 입력해주세요" name="join_pw_text" id="login_pw_text">
                </td>
            </tr>
            <tr>
                <td class="join_col_style">
                	<div>이름</div>
                    <input type="text" placeholder="성함을 입력해주세요" name="join_name_text" id="login_id_text">
                </td>
            </tr>
            <tr>
                <td class="join_col_style">
                	<div>주소</div>
					<input type="text" placeholder="주소를 입력해주세요" name="join_addr_text" id="login_pw_text">
                </td>
            </tr>
            <tr>
                <td class="join_col_style">
               		<div>이메일</div>
                    <input type="text" placeholder="이메일을 입력해주세요" name="join_email_text" id="login_id_text">
                </td>
            </tr>
            <tr>
                <td class="join_col_style">
                	<div>전화번호</div>
					<input type="text" placeholder="전화번호를 입력해주세요" name="join_phone_text" id="login_pw_text">
                </td>
            </tr>
            <tr>
            	<td>
            		<input type="button" value="가입" onclick="send(this.form)">
            	</td>
            </tr>
        </table>
    </form>
</body>
</html>

