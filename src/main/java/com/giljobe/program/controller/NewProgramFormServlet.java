package com.giljobe.program.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.common.Constants;

@WebServlet("/program/new")
public class NewProgramFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public NewProgramFormServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// NewProgramFormServlet
		request.getRequestDispatcher(Constants.WEB_VIEWS + "/program/newProgramForm.jsp")
		       .forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
