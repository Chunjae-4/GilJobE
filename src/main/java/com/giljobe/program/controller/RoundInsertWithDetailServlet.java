package com.giljobe.program.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
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

@WebServlet("/round/insert-with-detail")
public class RoundInsertWithDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RoundInsertWithDetailServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		roundAddWithDetail.jsp에서 입력된 데이터를 받아서:
//			Round 한 개 생성
//			연결된 ProTime 여러 개 생성 (startTime + duration → endTime 계산)
//			모두 DB에 저장
		request.setCharacterEncoding("UTF-8");

        // 1. 기본값 수집
        int proNo = Integer.parseInt(request.getParameter("proNoRef"));
        Date roundDate = Date.valueOf(request.getParameter("roundDate"));
        String durationStr = request.getParameter("duration");
        if (durationStr == null || durationStr.trim().isEmpty()) {
            throw new IllegalArgumentException("duration 값이 없습니다.");
        }
        int duration = Integer.parseInt(durationStr);

        String[] hours = request.getParameterValues("startHour");
        String[] minutes = request.getParameterValues("startMinute");
        
        if (hours == null || minutes == null || hours.length != minutes.length) {
            throw new IllegalArgumentException("시작 시간 정보가 잘못되었거나 비어 있습니다.");
        }
        
        int roundMaxPeople = Integer.parseInt(request.getParameter("roundMaxPeople"));
        int roundPrice = Integer.parseInt(request.getParameter("roundPrice"));
        String detailLocation = request.getParameter("detailLocation");
        String goal = request.getParameter("goal");
        String note = request.getParameter("note");
        String summary = request.getParameter("summary");
        String detail = request.getParameter("detail");

        // 2. roundCount 계산 (프로그램의 현재 최대 회차 + 1)
        int roundCount = RoundService.getInstance().getNextRoundCount(proNo); // 예: max+1
        System.out.println(roundCount); // 숫자 확인용
        
        // 3. Round 객체 생성 (roundNo는 sequence.nextval)
        Round round = Round.builder()
                .roundDate(roundDate)
                .roundCount(roundCount)
                .roundMaxPeople(roundMaxPeople)
                .roundPrice(roundPrice)
                .detailLocation(detailLocation)
                .goal(goal)
                .note(note)
                .summary(summary)
                .detail(detail)
                .proNoRef(proNo)
                .build();

        // 4. insert round + get generated roundNo
        RoundService.getInstance().insertRound(round); // insert + DTO에 roundNo 세팅
        int roundNo = round.getRoundNo(); // DTO에서 꺼냄

        // 5. 각 startHour + startMinute → startTime / endTime
        List<ProTime> proTimeList = new ArrayList<>();
        for (int i = 0; i < hours.length; i++) {
            int h = Integer.parseInt(hours[i]);
            int m = Integer.parseInt(minutes[i]);
            LocalTime start = LocalTime.of(h, m);
            LocalTime end = start.plusMinutes(duration);

            // LocalTime -> LocalDateTime -> java.util.Date
            LocalDateTime ldtStart = LocalDate.now().atTime(start);
            LocalDateTime ldtEnd = LocalDate.now().atTime(end);

            // Timestamp로 시간값 포함한 millisecond를 얻고 → Date로 저장
            Date startDate = new java.sql.Date(java.sql.Timestamp.valueOf(ldtStart).getTime());
            Date endDate = new java.sql.Date(java.sql.Timestamp.valueOf(ldtEnd).getTime());

            ProTime pt = ProTime.builder()
                    .startTime(startDate)
                    .endTime(endDate)
                    .roundNoRef(roundNo)
                    .build();
            proTimeList.add(pt);
        }

        // 6. insert ProTimes
        ProTimeService.getInstance().insertProTimes(proTimeList);

        // 7. 완료 후 리다이렉트
        response.sendRedirect(request.getContextPath() + "/program/detail?proNo=" + proNo);
   
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
