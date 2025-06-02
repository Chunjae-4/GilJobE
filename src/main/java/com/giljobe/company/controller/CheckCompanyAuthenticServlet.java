package com.giljobe.company.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/company/checkAuthNum")
public class CheckCompanyAuthenticServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public CheckCompanyAuthenticServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String authenticNum = (String) session.getAttribute("authenticComNum");//세션에 저장된 정보들 가져와
		String verifyCode = request.getParameter("verifyCompanyCode");		
		if(authenticNum==null||verifyCode==null||!authenticNum.equals(verifyCode)) {
			//인증번호 불일치시 혹은 값이 없을때
			out.print("fail");
		}else {
				session.removeAttribute("authenticComNum");
			    out.print("success");
		}
	    out.close();
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
