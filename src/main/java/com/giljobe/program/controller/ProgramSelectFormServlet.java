package com.giljobe.program.controller;

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

@WebServlet("/program/selectform")
public class ProgramSelectFormServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	HttpSession session = request.getSession();
    	// 세션에서 로그인한 기업 회원의 정보를 아래와 같이 받아온다고 가정한 것.
    	Company loginCompany = (Company) session.getAttribute("loginCompany");
//    	int comNo = loginCompany.getComNo();
    	int comNo = 1;

    	// DAO 통해 comNo 기준 등록 프로그램 목록 가져오기
    	List<Program> programList = ProgramService.getInstance().selectProgramsByComNo(comNo);
    	request.setAttribute("programList", programList);

    	request.getRequestDispatcher(Constants.WEB_VIEWS + "/program/selectForm.jsp")
    	       .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
