package com.giljobe.program.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.common.Constants;
import com.giljobe.program.model.dto.ProTime;
import com.giljobe.program.model.dto.Round;
import com.giljobe.program.model.service.ProTimeService;
import com.giljobe.program.model.service.RoundService;

@WebServlet("/round/edit-form")
public class RoundEditFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RoundEditFormServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int roundNo = Integer.parseInt(request.getParameter("roundNo"));

        // ✅ 회차 정보 조회
        Round round = RoundService.getInstance().selectRoundByNo(roundNo);

        // ✅ ProTime 리스트 조회
        List<ProTime> proTimes = ProTimeService.getInstance().selectProTimesByRoundNo(roundNo);

        // ✅ 오늘 날짜 (yyyy-MM-dd) 형식으로 전달
        String todayDate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());

        // ✅ JSP로 데이터 전달
        request.setAttribute("round", round);
        request.setAttribute("proTimes", proTimes);
        request.setAttribute("todayDate", todayDate);

        request.getRequestDispatcher(Constants.WEB_VIEWS + "/program/roundEditForm.jsp")
               .forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
