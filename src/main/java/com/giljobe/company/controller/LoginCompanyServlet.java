package com.giljobe.company.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.giljobe.common.Constants;
import com.giljobe.company.model.dto.Company;
import com.giljobe.company.model.service.CompanyService;
import com.giljobe.user.model.dto.User;
import com.giljobe.user.model.service.UserService;


@WebServlet(urlPatterns ="/company/loginend",name="LoginCompanyServlet")
public class LoginCompanyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public LoginCompanyServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String companySave = request.getParameter("companySave");//value값을 지정하지 않으면 체크됏을때  on값을 넘겨줌
		String id = request.getParameter("companyId");
		String pw = request.getParameter("companyPw");
//		if(companySave!=null) {
//			//체크되면 value가 담기지만 없으면 null이 담김
//			
//			Cookie cookie = new Cookie("companySave",request.getParameter("companyId"));
//			cookie.setMaxAge(60*60*24);//생명주기
//			cookie.setPath("/");//이거 꼭 전체로 해야하나?
//			response.addCookie(cookie);//response에 쿠키담기
//		
//		}else {
//			Cookie cookie = new Cookie("companySave",request.getParameter("companyId"));
//			cookie.setMaxAge(0);//생명주기
//			cookie.setPath("/");//경로설정
//			response.addCookie(cookie);//response에 쿠키담기
//		}
		
		//아이디와 비밀번호를 받아서 
		Company company=CompanyService.companyService().loginCompany(id,pw);
		if(company!=null) {
			//DB에 일치하는 유저 정보가 있어서 user에 넣었다면
			HttpSession session = request.getSession();//세션 생성
			session.setAttribute("company", company);//세션에 유저 담기
			session.setAttribute("userType", "company");
			response.sendRedirect(request.getContextPath());//세션에 넣은채로 메인화면 jsp로 보내
				
		}else {
			//로그인이 실패했다면 다시 로그인 화면으로 setAttribute에 메세지 담아갈수도있음
			request.setAttribute("wrongData", "일치하는 로그인 정보가 없습니다.");
			request.setAttribute("mapping", "/user/login");
			request.getRequestDispatcher(Constants.WEB_VIEWS+"common/wrongdata.jsp").forward(request, response);
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
