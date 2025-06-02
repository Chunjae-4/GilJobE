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

@WebServlet("/company/searchIdEnd")
public class SearchCompanyIdEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SearchCompanyIdEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String comBinNO = request.getParameter("comBinNo");
		String comEmail = request.getParameter("comEmail");
		Company company = CompanyService.companyService().searchCompanyByBinNoAndEmail(comBinNO,comEmail);
		
		if(company==null) {
			new Gson().toJson(Map.of("result", "fail"), response.getWriter());
			return;
			
		}else {

			response.setContentType(Constants.CONTENT_TYPE_JSON);
			new Gson().toJson(Map.of("returnId", company.getComId()), response.getWriter());
			
		}
		return;
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
