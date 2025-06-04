package com.giljobe.company.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.giljobe.common.Constants;
import com.giljobe.company.model.dto.Company;
import com.giljobe.company.model.service.CompanyService;


@WebServlet("/company/updateCompany")
public class UpdateCompanyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public UpdateCompanyServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		HttpSession session = request.getSession();
		
		Company company = (Company)session.getAttribute("company");
		
		int ComNo = company.getComNo();
		String comId=request.getParameter("companyId");
		String newname=request.getParameter("companyName");
		String newphone=request.getParameter("companyPhone");
		String newBinNo =request.getParameter("companyBinNo");
		String newemail=request.getParameter("companyEmail");
		
		Company c = Company.builder()
							.comNo(ComNo)
							.comName(newname)
							.comPhone(newphone)
							.comBinNo(newBinNo)
							.comEmail(newemail)
							.comId(comId)
							.build();
		
		int result= CompanyService.companyService().updateCompany(c);
		
		String msg;
		String loc;
		
		if(result>0) {
			//성공
			msg="회원정보 수정완료";
			session.setAttribute("company", c );
		}else {
			//실패
			msg="회원정보 수정 실패";
		}
		loc="/mypage/companymypageview";
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher(Constants.MSG).forward(request, response);
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
