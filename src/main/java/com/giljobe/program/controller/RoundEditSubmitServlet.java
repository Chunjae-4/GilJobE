package com.giljobe.program.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
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
import com.giljobe.program.model.service.ProTimeService;
import com.giljobe.program.model.service.RoundService;

@WebServlet("/round/edit-submit")
public class RoundEditSubmitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RoundEditSubmitServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

        // 1. 기본 회차 정보 수집
        int roundNo = Integer.parseInt(request.getParameter("roundNo"));
        int proNo = Integer.parseInt(request.getParameter("proNo"));
        Date roundDate = Date.valueOf(request.getParameter("roundDate"));
        String detailLocation = request.getParameter("detailLocation");
        String goal = request.getParameter("goal");
        String summary = request.getParameter("summary");
        String detail = request.getParameter("detail");
        String note = request.getParameter("note");
        int maxPeople = Integer.parseInt(request.getParameter("roundMaxPeople"));
        int price = Integer.parseInt(request.getParameter("roundPrice"));
        int duration = Integer.parseInt(request.getParameter("duration"));

        // 2. 회차 업데이트
        Round round = Round.builder()
                .roundNo(roundNo)
                .roundDate(roundDate)
                .detailLocation(detailLocation)
                .goal(goal)
                .summary(summary)
                .detail(detail)
                .note(note)
                .roundMaxPeople(maxPeople)
                .roundPrice(price)
                .build();

        RoundService.getInstance().updateRound(round);

        // 3. 기존 ProTime 삭제
        ProTimeService.getInstance().deleteByRoundNo(roundNo);

        // 4. 새로운 ProTime 리스트 삽입
        String[] hours = request.getParameterValues("startHour");
		String[] minutes = request.getParameterValues("startMinute");
		if (hours == null || minutes == null || hours.length != minutes.length) {
			throw new IllegalArgumentException("시작 시간 정보가 잘못되었거나 비어 있습니다.");
		}
		
        List<ProTime> newProTimes = new ArrayList<>();
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
					.roundNoRef(roundNo)
					.build();

			newProTimes.add(pt);
		}

        ProTimeService.getInstance().insertProTimes(newProTimes);


        // 5. 완료 후 리다이렉트
        response.sendRedirect(request.getContextPath() + "/program/detail?proNo=" + proNo);

	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
