package com.giljobe.qna.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.giljobe.common.Constants;
import com.giljobe.qna.model.dto.QNA;
import com.giljobe.qna.model.service.QNAService;
import com.giljobe.user.model.dto.User;


@WebServlet("/mypage/qnalist")
public class QnaServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public QnaServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		List<QNA> qnas = QNAService.qnaService().searchQNAByUserNo(user.getUserNo());
		user.setQnas(qnas);

		request.setAttribute("user", user);
		request.getRequestDispatcher(Constants.WEB_VIEWS+"/mypage/qna.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
