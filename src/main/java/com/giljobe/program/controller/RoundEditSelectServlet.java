package com.giljobe.program.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.common.Constants;
import com.giljobe.program.model.dto.Round;
import com.giljobe.program.model.service.RoundService;

@WebServlet("/round/edit-select")
public class RoundEditSelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
    public RoundEditSelectServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
        int proNo = Integer.parseInt(request.getParameter("proNo"));

        // ✅ 회차 목록 불러오기
        List<Round> rounds = RoundService.getInstance().selectRoundsByProgramNo(proNo);

        // ✅ JSP에 전달
        request.setAttribute("rounds", rounds);
        request.setAttribute("proNo", proNo); // JSP에서도 사용하므로 명시적으로 전달

        request.getRequestDispatcher(Constants.WEB_VIEWS + "/program/roundEditSelect.jsp")
               .forward(request, response);
    
	}
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
