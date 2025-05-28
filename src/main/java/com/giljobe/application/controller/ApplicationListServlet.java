package com.giljobe.application.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.giljobe.application.model.dto.Application;
import com.giljobe.application.model.dto.ApplicationProgram;
import com.giljobe.application.model.service.ApplicationService;
import com.giljobe.common.Constants;
import com.giljobe.user.model.dto.User;


@WebServlet("/mypage/applist")
public class ApplicationListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public ApplicationListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		List<ApplicationProgram> applications = ApplicationService.applicationService().searchAppByUserNo(user.getUserNo());
//		user.setApplications(applications);
		request.setAttribute("applications", applications);
		request.getRequestDispatcher(Constants.WEB_VIEWS+"mypage/application.jsp").forward(request, response);
	
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
