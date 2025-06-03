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
import com.giljobe.qna.model.dto.QNA;
import com.giljobe.qna.model.service.QNAService;
import com.giljobe.user.model.dto.User;


@WebServlet("/mypage/answerlist")
public class CompanyAnswerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public CompanyAnswerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Company company = (Company)session.getAttribute("company");
		List<QNA> companyQnaList = QNAService.qnaService().searchQnaByComNo(company.getComNo());

		request.setAttribute("companyQnaList", companyQnaList);
		request.getRequestDispatcher(Constants.WEB_VIEWS+"/mypage/answer.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
