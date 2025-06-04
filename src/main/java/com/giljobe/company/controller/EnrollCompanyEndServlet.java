package com.giljobe.company.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.company.model.dao.CompanyDao;
import com.giljobe.company.model.dto.Company;
import com.giljobe.company.model.service.CompanyService;


@WebServlet(urlPatterns = "/company/enrollendcompany",name="EnrollCompanyEndServlet")
public class EnrollCompanyEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public EnrollCompanyEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String comName = request.getParameter("companyName");
		String comBinNo = request.getParameter("companyBinNo");
		String comEmail = request.getParameter("companyEmail");
		String comId = request.getParameter("companyId");
		String password = request.getParameter("companyPw");
		String phone = request.getParameter("companyPhone");
		Company c = Company.builder()
				.comBinNo(comBinNo)
				.comEmail(comEmail)
				.comId(comId).comName(comName)
				.comPhone(phone)
				.comPw(password)
				.build();
		int result = CompanyService.companyService().enrollCompany(c);
		String url = "";
		if(result>0) {
			//성공하면 메인화면으로
			url="/";
		}else {
			//실패하면 회원가입화면으로 다시
			url="/user/enrollCompany.jsp";
		}
		
		//완료되면 메인화면으로, 실패하면 분기처리
		//이 정보들이 다시 호출되지않게 redirect로 전송
		response.sendRedirect(request.getContextPath()+url);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
