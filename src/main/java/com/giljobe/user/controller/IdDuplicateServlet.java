package com.giljobe.user.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.common.Constants;
import com.giljobe.user.model.dto.User;
import com.giljobe.user.model.service.UserService;
import com.google.gson.Gson;


@WebServlet("/user/idduplicate")
public class IdDuplicateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public IdDuplicateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		String userId=request.getParameter("id");
		User u = UserService.userService().checkId(userId);
		response.setContentType(Constants.CONTENT_TYPE_JSON);
		new Gson().toJson(Map.of("result",u==null),response.getWriter());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
