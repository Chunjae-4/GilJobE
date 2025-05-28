package com.giljobe.program.controller;

import java.io.IOException;
import java.sql.Date;
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

@WebServlet("/round/insert-copy-latest")
public class RoundInsertCopyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public RoundInsertCopyServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
//		proNo를 기준으로 마지막 회차 정보를 조회
//		선택한 날짜마다 새로운 Round 객체 생성 → roundCount 증가
//		각 Round마다 기존 회차와 동일한 ProTime들 복사하여 등록
		
		request.setCharacterEncoding("UTF-8");

        try {
            int proNo = Integer.parseInt(request.getParameter("proNoRef")); // 숨겨서 같이 넘겨줘야 함
            String[] selectedDates = request.getParameterValues("selectedDates");

            // 1. 마지막 회차 가져오기
            Round latestRound = RoundService.getInstance().getLastRoundByProNo(proNo);
            int baseRoundCount = latestRound.getRoundCount();
            List<ProTime> baseTimes = ProTimeService.getInstance().selectProTimesByRoundNo(latestRound.getRoundNo());

            // 2. 날짜마다 복사 생성
            for (int i = 0; i < selectedDates.length; i++) {
                Date roundDate = Date.valueOf(selectedDates[i]);

                Round round = Round.builder()
                        .roundCount(baseRoundCount + i + 1)
                        .roundDate(roundDate)
                        .roundMaxPeople(latestRound.getRoundMaxPeople())
                        .roundPrice(latestRound.getRoundPrice())
                        .detailLocation(latestRound.getDetailLocation())
                        .goal(latestRound.getGoal())
                        .note(latestRound.getNote())
                        .summary(latestRound.getSummary())
                        .detail(latestRound.getDetail())
                        .proNoRef(proNo)
                        .build();

                RoundService.getInstance().insertRound(round);
                int newRoundNo = round.getRoundNo();

                // 새로운 ProTime 리스트 구성
                List<ProTime> newTimes = new ArrayList<>();
                for (ProTime pt : baseTimes) {
                    newTimes.add(ProTime.builder()
                            .startTime(pt.getStartTime())
                            .endTime(pt.getEndTime())
                            .roundNoRef(newRoundNo)
                            .build());
                }

                ProTimeService.getInstance().insertProTimes(newTimes);
            }

            // 완료 후 상세 페이지 이동
            response.sendRedirect(request.getContextPath() + "/program/detail?proNo=" + proNo);
//          만약 forward를 사용하면, 등록을 브라우저 새로고침(F5) 시 form 데이터가 다시 제출됨 → 중복 insert 문제 발생

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "회차 복사 중 오류가 발생했습니다.");
            request.setAttribute("loc", request.getContextPath() + "/program/selectform");
            request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
        }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
