package com.giljobe.qna.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.qna.model.service.QNAService;

@WebServlet("/qna/delete")
public class QnaDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public QnaDeleteServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
        int proNo = Integer.parseInt(request.getParameter("proNo"));
        QNAService.qnaService().deleteQnaByNo(qnaNo);
        request.getSession().setAttribute("qnaMessage", "문의가 삭제되었습니다.");
        response.sendRedirect(request.getContextPath() + "/program/detail?proNo=" + proNo);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
