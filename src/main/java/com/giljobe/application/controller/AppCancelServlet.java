package com.giljobe.application.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.application.model.service.ApplicationService;
import com.giljobe.user.model.dto.User;

@WebServlet("/ajax/app/cancel")
public class AppCancelServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AppCancelServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// ✅ 3. 신청 취소
		int timeNo = Integer.parseInt(request.getParameter("timeNo"));
        User loginUser = (User) request.getSession().getAttribute("user");
        boolean result = false;

        if (loginUser != null) {
            result = ApplicationService.applicationService().deleteApp(timeNo, loginUser.getUserNo());
        }
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().print(result);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
