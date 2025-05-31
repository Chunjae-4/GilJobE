package com.giljobe.program.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.common.Constants;

@WebServlet("/program/edit-form")
public class ProgramEditFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ProgramEditFormServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO: 프로그램 번호(proNo)를 받아서 해당 프로그램 정보 조회
		request.getRequestDispatcher(Constants.WEB_VIEWS + "/program/programEditForm.jsp")
        .forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
