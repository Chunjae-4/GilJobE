package com.giljobe.love.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.giljobe.common.Constants;
import com.giljobe.program.model.dto.Program;
import com.giljobe.program.model.service.ProgramService;
import com.giljobe.user.model.dto.User;


@WebServlet("/mypage/love")
public class LoveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public LoveServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		List<Program> programs =  ProgramService.getInstance().lovedProgramByUserNo(user.getUserNo());
		//프로그램을 조회하려면 유저정보가 필요
		//세션에서 유저정보를 받아와야하나?
		request.setAttribute("programs", programs);
		request.getRequestDispatcher(Constants.WEB_VIEWS+"mypage/like.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
