package com.giljobe.qna.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.qna.model.dto.QNA;
import com.giljobe.qna.model.service.QNAService;
import com.giljobe.user.model.dto.User;

@WebServlet("/qna/insert")
public class QnaInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public QnaInsertServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
        int proNo = Integer.parseInt(request.getParameter("proNo"));
        String content = request.getParameter("qnaContent");
        User loginUser = (User) request.getSession().getAttribute("user");

        QNA qna = QNA.builder()
                     .proNoRef(proNo)
                     .userNoRef(loginUser.getUserNo())
                     .qnaContent(content)
                     .build();

        QNAService.qnaService().insertQna(qna);
        request.getSession().setAttribute("qnaMessage", "문의가 등록되었습니다.");
        response.sendRedirect(request.getContextPath() + "/program/detail?proNo=" + proNo);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
