    package com.korea.gift;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.MemberDAO;
import dto.MemberDTO;
import lombok.RequiredArgsConstructor;
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
      return Common.Member.VIEW_PATH + "login.jsp";
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
      //Invalid left-hand side in assignment
      
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
   
   
   
   
   //이미 존재하는 아이디 찾기
   
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
   public void member_login_idcheck(String id){
	   System.out.println("ㅎㅇ");
	   System.out.println("체크한 아이디는 "+ id);
   }
   
   
   
   
}
    
