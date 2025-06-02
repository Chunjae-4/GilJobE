package com.giljobe.program.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.program.model.service.RoundService;

@WebServlet("/round/delete")
public class RoundDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RoundDeleteServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int roundNo = Integer.parseInt(request.getParameter("roundNo"));
        int proNo = Integer.parseInt(request.getParameter("proNo"));

        boolean result = RoundService.getInstance().deleteRoundWithProTimesAndApplications(roundNo);

        if (result) {
            response.sendRedirect(request.getContextPath() + "/program/detail?proNo=" + proNo);
        } else {
            request.setAttribute("msg", "회차 삭제 중 오류가 발생했습니다.");
            request.setAttribute("loc", "/program/detail?proNo=" + proNo);
            request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
        }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
