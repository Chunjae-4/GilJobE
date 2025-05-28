package com.giljobe.company.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.giljobe.common.Constants;
import com.giljobe.company.model.dto.Company;
import com.giljobe.program.model.dto.Program;
import com.giljobe.program.model.service.ProgramService;


@WebServlet("/mypage/companyprogram")
public class CompanyProgramServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public CompanyProgramServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Company company = (Company)session.getAttribute("company");
		List<Program> programs = ProgramService.getInstance().selectProgramsByComNo(company.getComNo());
		request.setAttribute("programs", programs);
		request.getRequestDispatcher(Constants.WEB_VIEWS+"mypage/companyProgram.jsp").forward(request, response);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
