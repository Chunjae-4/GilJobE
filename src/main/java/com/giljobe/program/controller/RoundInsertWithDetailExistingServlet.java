package com.giljobe.program.controller;

import java.io.IOException;
import java.sql.Date;
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
import com.giljobe.program.model.dto.Round;
import com.giljobe.program.model.service.RoundService;

@WebServlet("/round/insert-with-detail-existing")
public class RoundInsertWithDetailExistingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RoundInsertWithDetailExistingServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		// 1. 기본 파라미터 수집
		int proNo = Integer.parseInt(request.getParameter("proNo"));
		Date roundDate = Date.valueOf(request.getParameter("roundDate"));
		int duration = Integer.parseInt(request.getParameter("duration"));
		int roundMaxPeople = Integer.parseInt(request.getParameter("roundMaxPeople"));
		int roundPrice = Integer.parseInt(request.getParameter("roundPrice"));
		String detailLocation = request.getParameter("detailLocation");
		String goal = request.getParameter("goal");
		String note = request.getParameter("note");
		String summary = request.getParameter("summary");
		String detail = request.getParameter("detail");

		String[] hours = request.getParameterValues("startHour");
		String[] minutes = request.getParameterValues("startMinute");
		if (hours == null || minutes == null || hours.length != minutes.length) {
			throw new IllegalArgumentException("시작 시간 정보가 잘못되었거나 비어 있습니다.");
		}

		// 2. Round 객체 생성
		int nextRoundCount = RoundService.getInstance().getNextRoundCount(proNo);
		Round round = Round.builder()
				.roundCount(nextRoundCount)
				.proNoRef(proNo)
				.roundDate(roundDate)
				.roundMaxPeople(roundMaxPeople)
				.roundPrice(roundPrice)
				.detailLocation(detailLocation)
				.goal(goal)
				.note(note)
				.summary(summary)
				.detail(detail)
				.build();

		// 3. ProTime 리스트 생성
		List<ProTime> proTimeList = new ArrayList<>();
		for (int i = 0; i < hours.length; i++) {
			int h = Integer.parseInt(hours[i]);
			int m = Integer.parseInt(minutes[i]);
			LocalTime start = LocalTime.of(h, m);
			LocalTime end = start.plusMinutes(duration);

			LocalDateTime ldtStart = LocalDate.now().atTime(start);
			LocalDateTime ldtEnd = LocalDate.now().atTime(end);

			Date startDate = new java.sql.Date(java.sql.Timestamp.valueOf(ldtStart).getTime());
			Date endDate = new java.sql.Date(java.sql.Timestamp.valueOf(ldtEnd).getTime());

			ProTime pt = ProTime.builder()
					.startTime(startDate)
					.endTime(endDate)
					.build();

			proTimeList.add(pt);
		}

		// 4. Round + ProTime 트랜잭션 처리
		boolean result = RoundService.getInstance()
				.insertRoundWithProTimes(round, proTimeList);

		// 5. 응답 처리
		if (result) {
			response.sendRedirect(request.getContextPath() + "/program/detail?proNo=" + proNo);
		} else {
			request.setAttribute("msg", "회차 등록 중 오류가 발생했습니다.");
			request.setAttribute("loc", request.getContextPath() + "/program/detail?proNo=" + proNo);
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
