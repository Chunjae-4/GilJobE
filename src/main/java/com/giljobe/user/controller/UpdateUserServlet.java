package com.giljobe.user.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.user.model.dto.User;
import com.giljobe.user.model.service.UserService;


@WebServlet("/user/updateUser")
public class UpdateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public UpdateUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String userId=request.getParameter("userId");
		String phone=request.getParameter("userPhone");
		String nickName =request.getParameter("userNickName");
		String email=request.getParameter("userEmail");
		Date birth =Date.valueOf(request.getParameter("userBirth"));
		
		User u = User.builder()
					.userId(userId)
					.userPhone(phone)
					.userNickName(nickName)
					.userEmail(email)
					.userBirth(birth)
					.build();
		int result = UserService.userService().updateUser(u);
		if(result>0) {
			//성공
		}else {
			//실패
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
