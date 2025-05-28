package com.giljobe.program.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.common.Constants;
import com.giljobe.program.model.dto.Program;
import com.giljobe.program.model.service.ProgramService;

@WebServlet("/round/add-with-detail-existing")
public class RoundAddWithDetailExistingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RoundAddWithDetailExistingServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int proNo = Integer.parseInt(request.getParameter("proNo"));

        // 프로그램 정보 조회
        Program program = ProgramService.getInstance().selectProgramByNo(proNo);

        if (program == null) {
            request.setAttribute("msg", "프로그램 정보를 찾을 수 없습니다.");
            request.setAttribute("loc", request.getContextPath() + "/program/selectform");
            request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
            return;
        }

        request.setAttribute("program", program); // roundAddWithDetail.jsp에서 사용
        request.getRequestDispatcher(Constants.WEB_VIEWS + "/program/roundAddWithDetail.jsp").forward(request, response);
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
