package com.korea.gift;

import java.lang.reflect.Member;
import java.net.http.HttpClient.Redirect;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.DefaultMessageCodesResolver;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.MemberDAO;
import dto.MemberDTO;
import lombok.RequiredArgsConstructor;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoEmptyResponseException;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.exception.NurigoUnknownException;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;
//import service.MemberService;
import util.Common;

@RequiredArgsConstructor
@Controller
public class MemberController {


   final MemberDAO memberDAO;
   

   
   //로그인 변수
   MemberDTO dto = null;
   

   //회원가입 변수
   //@Autowired autowire붙으면 에러
   //final 붙어도 에러
   MemberDTO insert_dto = null;

   @Autowired
   HttpSession session;

   //HttpServletRequest request; 이건 httpsession을 어노테이션 붙여 필요없어짐.
   


   //로그인 페이지 이동
   @RequestMapping(value="mlogin")//, method = RequestMethod.GET 생략가능하며 둘다처리해줌.
   public String member() {
	  Integer m_idx = (Integer) session.getAttribute("m_idx");

	  if(m_idx != null) {
		  return "redirect:/";
	  }
	return Common.Member.VIEW_PATH + "login.jsp";

	  
     
   }
   
   //아이디 찾기 페이지 이동
   @RequestMapping("selectmidfor")
   public String selectmidfor() {
	   
	   return Common.Member.VIEW_PATH + "forgot_member_id.jsp";
   }
   
   //아이디 찾기 페이지 이동
   @RequestMapping("selectmpwdfor")
   public String selectmpwdfor() {
	   
	   return Common.Member.VIEW_PATH + "forgot_member_pwd.jsp";
   }
   
   
   //로그인 처리
   @RequestMapping(value="mloginconf")//, method = RequestMethod.POST
   @ResponseBody
   public String login(String id, String pwd) {
      
      System.out.println("아이디 : " + id);
      System.out.println("비밀번호 : " + pwd);
      
      HashMap<String, String> map = new HashMap<String, String>();
      map.put("id",id);
      map.put("pwd", pwd);
      
      dto = memberDAO.login(map);
      
      if(dto == null) {
         System.out.println("아이디나 비밀번호가 일치하지 않습니다.");
        
         return "[{'data':'null_data'}]";
         
      }else {
    	  
         System.out.println("로그인 준비함");
         
      }



      //The left-hand side of an assignment must be a variable - 상수로 인한 타입 미스매치
      //Invalid left-hand side in assignment
      
//      부적절한 위치에서 할당 행위를 하려고 할 때 대표적인 발생하는 에러로서, 흔한 문법 오류이다.
//      가장 흔한 실수하는 부분이 논리연산자 부분에 변수 할당하려고 했을때 자주 발생한다.
//      출처: https://inpa.tistory.com/entry/ERROR-⚠️-Invalid-left-hand-side-in-assignment [Inpa Dev 👨‍💻:티스토리]
      
      
      //세션에 들어갈 데이터 변수에 값 지정
      int m_idx = dto.getM_idx();
      String m_name = dto.getM_name();
      
      //세션 설정
      session.setAttribute("m_idx", m_idx);
      
      //세션 추가 설정 - 이름
      session.setAttribute("m_name", m_name);
      
      
      
      
      //세션 조회
      int idx_session = (int) session.getAttribute("m_idx");
      System.out.println("너의 세션값은 " + idx_session);
      
      //세션 타이밍 설정
      session.setMaxInactiveInterval(180000); // 180,000sec
      
      
      //json형태 값을 변수에 지정 후 리턴
      String data = "[{'data':'having_data'}]";
      
      return data;
   }


   /*
    * @RequestMapping public String login(MemberDTO dto){ 
    * return
    * memberDAO.login(memberDAO); }
    */
   
   
   
   
   //이미 존재하는 아이디 찾기(회원가입 시)
   
   @RequestMapping("midcheck")
   @ResponseBody
   public String m_idcheck(String id) {
	   System.out.println("midcheck들어옴");
	   System.out.println(id);
	   
	   
	   String checked_id = memberDAO.check_id(id);
	   
	   
	   if(checked_id==null) {
		   System.out.println("사용 가능한 아이디입니다.");
		   return "[{'result':'yes'}]";
	   } else {
	   System.out.println("이미 중복된 아이디가 있습니다."+checked_id);
	   return "[{'result':'no'}]";
	   }
	   
	   
	   
   }
   
   
   //회원가입 페이지
   
   @RequestMapping(value="mjoin", method = RequestMethod.GET)
   public String join() {
      return Common.Member.VIEW_PATH + "member_join.jsp";
   }
   
   
   //회원가입 기능(순수 가입기능만 있어 mybatis에서 가야 걸러내 아이디 중복 시 오류가 나버림)
   //responsebody 어노테이션 안붙여서 check your resolve setup! 뜸
   @RequestMapping("mjoininsert")
   @ResponseBody
   public void memberinsert(String id, String pwd, String name, String addr, String email, String phone){
      
      if(id==null) {
    	  System.out.println("null!");
      }else {
    	  System.out.println(id+'+'+pwd+'+'+name+'+'+addr+'+'+email+'+'+phone);
      }
      
      HashMap<String, String> m_join_insert = new HashMap<String, String>();
      m_join_insert.put("id", id);
      m_join_insert.put("pwd", pwd);
      m_join_insert.put("name", name);
      m_join_insert.put("addr", addr);
      m_join_insert.put("email", email);
      m_join_insert.put("phone", phone);
      
      memberDAO.insert(m_join_insert);
      
      System.out.println("dao연산 완료");
      
      
   }
   
   @RequestMapping("testpage")
   public String testpage() {
	   return Common.Member.VIEW_PATH + "/testpage.jsp";
   }
   
   
   
   
   
   
   //logout
   

   @RequestMapping("mlogout")
   public String mlogout() {
	   session.removeAttribute("m_idx");
	   return Common.Member.VIEW_PATH+"/login.jsp";
   }
   
   

   //member_idcheck
   
   
   @RequestMapping("mloginidsave")
   @ResponseBody
   public Cookie member_login_idcheck(String id, HttpServletResponse response){
	   System.out.println("ㅎㅇ");
	   System.out.println("체크한 아이디는 "+ id);
	   
	   Cookie cookie = new Cookie("saved_id", id);
	   cookie.setMaxAge(60*60*24*7); // 1주일 쿠키
	   
	   System.out.println(cookie.getValue());
	   cookie.setSecure(true);
	   
	   response.addCookie(cookie);
	   return cookie;
   }
   
   @RequestMapping("mloginsavedidremove")
   @ResponseBody
   public void member_login_idcheckout(String id, HttpServletResponse response){
	   
	   Cookie cookie = new Cookie("saved_id", id);
	   
	   cookie.setMaxAge(0);
	   response.addCookie(cookie);
   }
   
   
   
   
   
   
   //휴대전화 1차 인증(아이디, 비밀번호 공통)
   @RequestMapping("phone_authentication")
   @ResponseBody
   public String m_idfinding(String phone) {
	   
	   //난수생성
	   
		int random =  (int) (Math.random() * 10000);
		String random2 =  String.format("%04d", random);
		
		
		System.out.println(random);
	   String text = "문자발송[sms_test]"+random2+"를 입력해주십시오.";
	   String value = m_pwd_phone(phone, text, random2);
	   System.out.println(value);
	   return value;
   }
   
   
   
   /*휴대폰 인증(아이디) 최종 인증 -> 인증번호는 이미 휴대폰인증 컨트롤러 파트에서 리턴해버림.*/
   
   @RequestMapping("m_id_entire_check")
   @ResponseBody
   public String phone_m_fianl_authen(String name, String phone) {
	   System.out.println(name);
	   System.out.println(phone);
	   System.out.println("----------");
	   
	   HashMap<String, String> get_name_id =  memberDAO.check_name(name, phone);
	   
	   String get_name = get_name_id.get("get_name");
	   System.out.println(get_name);
	   
	   String get_id = get_name_id.get("get_id");
	   System.out.println(get_id);
	   
//	   if(result==null) {
//		   result = "[{'result':'error'}]";
//	   }else if(result!=null) {
//		   result = "[{'result':'success'}]";
//	   }
		if(name.equals(get_name)) {
			return "[{'result':'equal'},{'get_id':'"+get_id+"'}]";
			
		} else {
			return "[{'result':'not_equal'}]";
		}
		
   }


   /*휴대폰 인증(비밀번호) 최종 인증 -> 인증번호는 이미 휴대폰인증 컨트롤러 파트에서 리턴해버림.*/
   
   @RequestMapping("m_pwd_entire_check")
   @ResponseBody
   public String phone_m_fianl_authen(String name, String phone, String id) {
	   System.out.println(name);
	   System.out.println(phone);
	   System.out.println(id);
	   System.out.println("----------");
	   
	   String get_name = (String) memberDAO.check_name(name, phone, id);
	   
//-----------------
	   
	   //보낼 휴대폰 번호
	   System.out.println("보낼 휴대폰 번호 : "+phone);
	   
	   //난수생성
	   
	   int random_origin =  (int) (Math.random() * 10000);
	   String random_int =  String.format("%04d", random_origin);
	   
	   
	   //랜덤범위지정
	   int first_num = 97;
	   int final_num = 122;
	   int bound = 4;
	   
	   //문자열랜덤만듦
	   Random random = new Random();
	   String random_str = random.ints(first_num, final_num+1).limit(bound).collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString();
	   
	   //숫자와 문자열랜덤 합침 + 텍스트 값 정의
	   String random_Int_Str = random_int + random_str;
	   String text = "문자발송[sms_test]"+"임시비밀번호는"+random_Int_Str+"를 입력해주십시오.";
	   
	   
	   System.out.println(text);
	   
	   
	   memberDAO.send_temp_pwd(phone,random_Int_Str);

	   
	   
//-----------------
	   
	   System.out.println(get_name);
	   
		m_pwd_phone(phone, text, random_Int_Str);
		if(name.equals(get_name)) {
			return "[{'result':'equal'}]";
		} else {
			return "[{'result':'not_equal'}]";
		}
		
   }
   
   //임시비밀번호 보내기
   //@RequestMapping("send_temp_pwd")
   //@ResponseBody
//   public String m_send_pwd_phone(String phone) {
//	   
//	   //보낼 휴대폰 번호
//	   System.out.println("보낼 휴대폰 번호 : "+phone);
//	   
//	   //난수생성
//	   
//	   int random_origin =  (int) (Math.random() * 10000);
//	   String random_int =  String.format("%04d", random_origin);
//	   
//	   
//	   //랜덤범위지정
//	   int first_num = 97;
//	   int final_num = 122;
//	   int bound = 6;
//	   
//	   //문자열랜덤만듦
//	   Random random = new Random();
//	   String random_str = random.ints(first_num, final_num+1).limit(bound).collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString();
//	   
//	   //숫자와 문자열랜덤 합침 + 텍스트 값 정의
//	   String random_Int_Str = random_int + random_str;
//	   String text = "문자발송[sms_test]"+"임시비밀번호는"+random_Int_Str+"를 입력해주십시오.";
//	   
//	   
//	   System.out.println(text);
//	   
//	   
//	   memberDAO.send_temp_pwd(phone,random_Int_Str);
//
//
//	   return m_pwd_phone(phone, text, random_Int_Str);
//   }
   
   
   
   //휴대전화 문자 보내기
   public String m_pwd_phone(String phone, String text, String value) {
	   System.out.println("가져온 휴대폰번호:" + phone);
	   
	   
	   
	   //api, secret_api
	   
	   String api_key = "NCSXL5II1VWPRMJL";
	   String secret_api_key = "TWHLZUJ3XF8GWOSDZEHYAKENRYSPZSWI";
	   

	   Message message = new Message();
	   
	   
	   DefaultMessageService messageSend = new DefaultMessageService(api_key, secret_api_key, "https://api.coolsms.co.kr");

	   
	   
	  
	   
	   //from, to, text
	   message.setFrom("01063432271");
	   message.setTo(phone);
//	   message.setText("문자발송[sms_test]"+""+"를 입력해주십시오.");
	   message.setText(text);
	   
	   try {
			messageSend.send(message);
		} catch (NurigoMessageNotReceivedException e) {
			// TODO Auto-generated catch block
			System.out.println(e.getFailedMessageList());
			System.out.println(e.getMessage());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			System.out.println(e.getMessage());
		}
	   
	   String return_value = "[{'value':'"+ value +"'}]";
	   System.out.println("return_value : "+return_value);
	   
	   return return_value;
   }

//   @RequestMapping("m_send_phone_02")
//   public String m_send_phone_02(){
//	   return Common.Member.VIEW_PATH + "phone_send02.jsp";
//   }
   
   //회원탈퇴화면
   @RequestMapping("member_withdraw_ready")
   public String member_withdraw_ready() {
	   return Common.Member.VIEW_PATH + "withdraw.jsp";
   }
   
   //회원탈퇴
   @RequestMapping("member_withdraw")
   public String member_withdraw() {
	   try {

		   int m_idx = (int) session.getAttribute("m_idx");
		   Integer check_m_idx = (Integer) m_idx;

		   
		   if(check_m_idx != null) {
			   System.out.println(m_idx);
			   session.removeAttribute("m_idx");
			   memberDAO.m_withdraw(m_idx);
		   }
		   
		} catch (NullPointerException e) {
			// TODO: handle exception
			System.out.println("nullpointerException 에러" + e.getMessage());
			System.out.println("m_idx가 존재하지 않습니다.");
		}
	   return "redirect:/";
   }
   
   
   
}