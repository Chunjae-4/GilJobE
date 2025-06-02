package com.giljobe.program.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.program.model.service.ProgramService;

@WebServlet("/program/delete")
public class ProgramDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ProgramDeleteServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int proNo = Integer.parseInt(request.getParameter("proNo"));

        boolean success = ProgramService.getInstance().deleteProgramWithAllData(proNo);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/program/programlist"); // 목록으로 이동
        } else {
            request.setAttribute("msg", "프로그램 삭제에 실패했습니다.");
            request.setAttribute("loc", request.getContextPath() + "/program/detail?proNo=" + proNo);
            request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
        }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
