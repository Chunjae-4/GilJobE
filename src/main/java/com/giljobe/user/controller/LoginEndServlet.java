package com.giljobe.user.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.giljobe.common.Constants;
import com.giljobe.user.model.dto.User;
import com.giljobe.user.model.service.UserService;


@WebServlet("/user/loginend")
public class LoginEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public LoginEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String id = request.getParameter("userId");
		String pw = request.getParameter("userPw");
		//아이디와 비밀번호를 받아서 
		User user = UserService.userService().login(id, pw);
		if(user!=null) {
			//DB에 일치하는 유저 정보가 있어서 user에 넣었다면
			HttpSession session = request.getSession();//세션 생성
			session.setAttribute("user", user);//세션에 유저 담기
			response.sendRedirect(request.getContextPath()+"/");//세션에 넣은채로 메인화면 jsp로 보내
				
		}else {
			//로그인이 실패했다면 다시 로그인 화면으로 
			request.getRequestDispatcher(Constants.WEB_VIEWS+"user/login.jsp").forward(request, response);
		}
		
		//완료되면 메인화면으로, 실패하면 분기처리
		response.sendRedirect(request.getContextPath()+"/");
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
