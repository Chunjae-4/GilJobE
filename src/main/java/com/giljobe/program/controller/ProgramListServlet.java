package com.giljobe.program.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.giljobe.program.model.service.ProgramService;
import com.giljobe.common.*;


@WebServlet("/program/programlist")
public class ProgramListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ProgramListServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 전체 데이터 수 가져오기
		int totalCount = ProgramService.getInstance().programCount();
		System.out.println(totalCount);

		//2.
		request.getRequestDispatcher(Constants.WEB_VIEWS+"program/programList.jsp").forward(request, response)
		;
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
