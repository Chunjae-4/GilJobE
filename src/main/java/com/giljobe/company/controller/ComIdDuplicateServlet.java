package com.giljobe.company.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.common.Constants;
import com.giljobe.company.model.dto.Company;
import com.giljobe.company.model.service.CompanyService;
import com.google.gson.Gson;


@WebServlet("/company/idduplicate")
public class ComIdDuplicateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public ComIdDuplicateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String companyId=request.getParameter("id");
		Company u = CompanyService.companyService().searchCompanyById(companyId);
		response.setContentType(Constants.CONTENT_TYPE_JSON);
		new Gson().toJson(Map.of("result",u==null),response.getWriter());
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
