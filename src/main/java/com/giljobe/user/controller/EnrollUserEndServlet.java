package com.giljobe.user.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.common.Constants;
import com.giljobe.user.model.dto.User;
import com.giljobe.user.model.service.UserService;


@WebServlet("/user/enrolluserend.do")
public class EnrollUserEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public EnrollUserEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		User user = User.builder()
						//userNo는 시퀀스로 필요없고
						.userNickName(request.getParameter("userNickName"))
						.userId(request.getParameter("userId"))
						.userName(request.getParameter("userName"))
						.userPw(request.getParameter("userPw"))
						.userPhone(Integer.parseInt(request.getParameter("userPhone")))
						.userEmail(request.getParameter("userEmail"))
						.userBirth(Integer.parseInt(request.getParameter("userBirth")))
						.build();
		
		
		UserService.userService().enrollUser(user);
		
		
		//완료되면 메인화면으로, 실패하면 분기처리
		response.sendRedirect(Constants.WEB_VIEWS+"/");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
