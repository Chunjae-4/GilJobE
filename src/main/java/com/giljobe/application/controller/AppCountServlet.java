package com.giljobe.application.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.application.model.service.ApplicationService;

@WebServlet("/ajax/app/count")
public class AppCountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AppCountServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// ✅ 4. 신청 인원 수 조회
		int timeNo = Integer.parseInt(request.getParameter("timeNo"));
        int count = ApplicationService.applicationService().countAppByTimeNo(timeNo);
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().print(count);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
