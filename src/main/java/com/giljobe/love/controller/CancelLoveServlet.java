package com.giljobe.love.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.common.Constants;
import com.giljobe.love.model.service.LoveService;
import com.google.gson.Gson;


@WebServlet("/love/cancellove")
public class CancelLoveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CancelLoveServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int proNo = Integer.parseInt(request.getParameter("proNo"));
		int userNo = Integer.parseInt(request.getParameter("userNo"));
		
		int result = LoveService.getInstance().removeLove(proNo,userNo);
		
		response.setContentType(Constants.CONTENT_TYPE_JSON);
		new Gson().toJson(Map.of("result", result), response.getWriter());
		
		//결과값을 gson으로 반환
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
