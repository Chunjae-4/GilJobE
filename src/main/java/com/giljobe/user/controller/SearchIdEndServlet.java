package com.giljobe.user.controller;

import java.io.IOException;
import java.io.PrintWriter;
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


@WebServlet("/user/searchIdEnd")
public class SearchIdEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public SearchIdEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		String userName = request.getParameter("userName");
		String userEmail = request.getParameter("userEmail");
		
		User user = UserService.userService().searchUserByNameAndEmail(userName, userEmail);
		if(user==null) {
			new Gson().toJson(Map.of("result", "fail"), response.getWriter());
			return;
			
		}else {

			response.setContentType(Constants.CONTENT_TYPE_JSON);
			new Gson().toJson(Map.of("returnId", user.getUserId()), response.getWriter());
			
		}
		return;
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
