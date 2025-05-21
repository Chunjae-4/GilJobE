package com.giljobe.user.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		
		
		
		
		//완료되면 메인화면으로, 실패하면 분기처리
		response.sendRedirect(request.getContextPath()+"/");
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
