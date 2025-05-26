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


@WebServlet("/mypage/mypageview")
public class MyPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public MyPageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	//로그인을 눌러야 아이디 저장이 on/null값이 바뀐ㅁ
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		request.getRequestDispatcher(Constants.WEB_VIEWS+"mypage/myPage.jsp").forward(request, response);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
