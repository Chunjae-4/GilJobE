package com.giljobe.application.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.application.model.service.ApplicationService;
import com.giljobe.user.model.dto.User;

@WebServlet("/ajax/app/apply")
public class AppApplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AppApplyServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// ✅ 2. 신청하기
		int timeNo = Integer.parseInt(request.getParameter("timeNo"));
        User loginUser = (User) request.getSession().getAttribute("user");
        boolean result = false;

        if (loginUser != null) {
            result = ApplicationService.applicationService().insertApp(timeNo, loginUser.getUserNo());
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().print(result);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
