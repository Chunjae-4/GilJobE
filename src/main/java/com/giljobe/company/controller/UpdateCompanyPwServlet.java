package com.giljobe.company.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.giljobe.common.Constants;
import com.giljobe.company.model.dto.Company;
import com.giljobe.company.model.service.CompanyService;


@WebServlet(urlPatterns = "/company/updatePw" , name="UpdateCompanyPwServlet")
public class UpdateCompanyPwServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public UpdateCompanyPwServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		HttpSession session = request.getSession();
		Company c = (Company)session.getAttribute("company");
		String companyPw = request.getParameter("companyPw");
	    String newPw = request.getParameter("newPw");
	    int comNo = c.getComNo();
	    
	    String msg;
	    String loc;
int result = CompanyService.companyService().updateCompanyPw(comNo,companyPw, newPw);
	    
	    if(result==-1) {
			//비밀번호 다름
			msg=" 현재 비밀번호를 정확하게 입력하세요";
		}else if(result>0) {
			//성공
			msg="비밀번호 수정완료";
		}else {
			//실패
			msg="비밀번호 수정실패";
			
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
