package com.giljobe.program.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.program.model.dto.ProTime;
import com.giljobe.program.model.service.ProTimeService;
import com.giljobe.program.model.service.RoundService;

@WebServlet("/protime/edit-submit")
public class ProTimeEditSubmitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ProTimeEditSubmitServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
		request.setCharacterEncoding("UTF-8");

		int proNo = Integer.parseInt(request.getParameter("proNo"));
		int roundNo = Integer.parseInt(request.getParameter("roundNo"));
		int duration = Integer.parseInt(request.getParameter("duration"));

		String[] hours = request.getParameterValues("startHour");
		String[] minutes = request.getParameterValues("startMinute");

		if (hours == null || minutes == null || hours.length != minutes.length) {
			throw new IllegalArgumentException("시작 시간 정보가 잘못되었거나 비어 있습니다.");
		}

		// 1. 기존 ProTime 삭제
		ProTimeService.getInstance().deleteByRoundNo(roundNo);

		// 2. 새 ProTime 생성
		List<ProTime> newProTimes = new ArrayList<>();
		for (int i = 0; i < hours.length; i++) {
			int h = Integer.parseInt(hours[i]);
			int m = Integer.parseInt(minutes[i]);
			LocalTime start = LocalTime.of(h, m);
			LocalTime end = start.plusMinutes(duration);

			LocalDate today = LocalDate.now(); // 날짜는 중요하지 않음 (시간만 사용)
			LocalDateTime ldtStart = today.atTime(start);
			LocalDateTime ldtEnd = today.atTime(end);

			java.sql.Date startDate = new java.sql.Date(java.sql.Timestamp.valueOf(ldtStart).getTime());
			java.sql.Date endDate = new java.sql.Date(java.sql.Timestamp.valueOf(ldtEnd).getTime());

			ProTime pt = ProTime.builder()
				.startTime(startDate)
				.endTime(endDate)
				.roundNoRef(roundNo)
				.build();

			newProTimes.add(pt);
		}

		// 3. insert
		ProTimeService.getInstance().insertProTimes(newProTimes);

		// 4. 리다이렉트
		response.sendRedirect(request.getContextPath() + "/program/detail?proNo=" + proNo);
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
