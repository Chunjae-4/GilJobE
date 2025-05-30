package com.giljobe.application.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.application.model.service.ApplicationService;
import com.giljobe.user.model.dto.User;
import com.google.gson.Gson;

@WebServlet("/ajax/app/check")
public class AppCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AppCheckServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// ✅ 1. 신청 여부 확인
		int timeNo = Integer.parseInt(request.getParameter("timeNo"));
        User loginUser = (User) request.getSession().getAttribute("user");
        boolean hasApplied = false;

        if (loginUser != null) {
            hasApplied = ApplicationService.applicationService().existsAppForTimeAndUser(timeNo, loginUser.getUserNo());
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().print(new Gson().toJson(hasApplied));
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
