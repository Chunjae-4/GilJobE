package com.giljobe.application.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.application.model.service.ApplicationService;
import com.giljobe.common.Constants;
import com.google.gson.Gson;

@WebServlet("/application/cancelapplication")
public class CancelApplication extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public CancelApplication() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int timeNo = Integer.parseInt(request.getParameter("timeNo"));
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		
		int result = ApplicationService.applicationService().removeApplication(timeNo,userNo);
		
		response.setContentType(Constants.CONTENT_TYPE_JSON);
		new Gson().toJson(Map.of("result", result), response.getWriter());
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
