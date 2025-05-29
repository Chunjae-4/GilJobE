package com.giljobe.program.controller;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.common.Constants;

@WebServlet("/round/add-copy-latest")
public class RoundAddCopyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RoundAddCopyServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		LocalDate today = LocalDate.now();
		request.setAttribute("todayDate", today.toString()); // yyyy-MM-dd 형식
		request.getRequestDispatcher(Constants.WEB_VIEWS + "/program/roundAddCopy.jsp")
	       .forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
