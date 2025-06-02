package com.giljobe.program.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.common.Constants;
import com.giljobe.program.model.dto.ProTime;
import com.giljobe.program.model.dto.Program;
import com.giljobe.program.model.dto.Round;
import com.giljobe.program.model.service.ProTimeService;
import com.giljobe.program.model.service.ProgramService;
import com.giljobe.program.model.service.RoundService;

@WebServlet("/protime/edit-form")
public class ProTimeEditFormServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ProTimeEditFormServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 int roundNo = Integer.parseInt(request.getParameter("roundNo"));

	        Round round = RoundService.getInstance().selectRoundByNo(roundNo); // 회차 정보
	        List<ProTime> proTimes = ProTimeService.getInstance().selectProTimesByRoundNo(roundNo); // 타임 정보
	        Program program = ProgramService.getInstance().selectProgramByNo(round.getProNoRef()); // 프로그램 정보
	        // ✅ 오늘 날짜 (yyyy-MM-dd) 형식으로 전달
	        String todayDate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
	        
	        request.setAttribute("round", round);
	        request.setAttribute("proTimes", proTimes);
	        request.setAttribute("program", program);
	        request.setAttribute("todayDate", todayDate);

	        request.getRequestDispatcher(Constants.WEB_VIEWS + "/program/proTimeEditForm.jsp").forward(request, response);
	    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
