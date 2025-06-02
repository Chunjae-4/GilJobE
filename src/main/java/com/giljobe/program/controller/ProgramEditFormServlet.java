package com.giljobe.program.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.common.Constants;
import com.giljobe.program.model.dto.Program;
import com.giljobe.program.model.service.ProgramService;

@WebServlet("/program/edit-form")
public class ProgramEditFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ProgramEditFormServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 프로그램 번호 받기
	    int proNo = Integer.parseInt(request.getParameter("proNo"));
	    
	    // 2. 해당 프로그램 정보 조회
	    Program program = ProgramService.getInstance().selectProgramByNo(proNo);
	    
	    // 3. request에 담아서 JSP로 전달
	    request.setAttribute("program", program);

	    // 4. forward
	    request.getRequestDispatcher(Constants.WEB_VIEWS + "/program/programEditForm.jsp")
	           .forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
