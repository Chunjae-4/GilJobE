package com.giljobe.program.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.giljobe.application.model.service.ApplicationService;
import com.giljobe.program.model.dto.ProTime;
import com.giljobe.program.model.dto.Round;
import com.giljobe.program.model.service.ProTimeService;
import com.giljobe.program.model.service.RoundService;
import com.giljobe.user.model.dto.User;
import com.google.gson.Gson;

@WebServlet("/program/roundinfo")
public class ProgramRoundAjaxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ProgramRoundAjaxServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json; charset=UTF-8");
		int proNo = Integer.parseInt(request.getParameter("proNo"));
        int roundCount = Integer.parseInt(request.getParameter("roundCount"));

        List<Round> rounds = RoundService.getInstance().selectRoundsByProgramNo(proNo);
        Round selectedRound = null;
        for (Round r : rounds) {
            if (r.getRoundCount() == roundCount) {
                selectedRound = r;
                break;
            }
        }

        if (selectedRound == null) {
            response.setStatus(404);
            return;
        }

        List<ProTime> proTimes = ProTimeService.getInstance().selectProTimesByRoundNo(selectedRound.getRoundNo());

        // Date - HH:mm 문자열로 변환
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");

        HttpSession session = request.getSession(false);
        User loginUser = (session != null) ? (User) session.getAttribute("user") : null;
        int userNo = (loginUser != null) ? loginUser.getUserNo() : -1;

        List<Map<String, Object>> timeList = new ArrayList<>();
        for (ProTime pt : proTimes) {
            Map<String, Object> timeMap = new HashMap<>();
            timeMap.put("timeNo", pt.getTimeNo());
            timeMap.put("start", sdf.format(pt.getStartTime()));
            timeMap.put("end", sdf.format(pt.getEndTime()));

            boolean userApplied = false;
            if (userNo != -1) {
                userApplied = ApplicationService.applicationService().existsAppForTimeAndUser(pt.getTimeNo(), userNo);
            }
            timeMap.put("userApplied", userApplied);

            timeList.add(timeMap);
        }


		Map<String, Object> responseMap = new HashMap<>();
		responseMap.put("roundCount", selectedRound.getRoundCount());
		responseMap.put("roundDate", selectedRound.getRoundDate().toString()); // 필요시 포맷 변경
		responseMap.put("detailLocation", selectedRound.getDetailLocation());
		responseMap.put("roundMaxPeople", selectedRound.getRoundMaxPeople());
		responseMap.put("roundPrice", selectedRound.getRoundPrice());
		responseMap.put("goal", selectedRound.getGoal());
		responseMap.put("summary", selectedRound.getSummary());
		responseMap.put("note", selectedRound.getNote());
		responseMap.put("detail", selectedRound.getDetail());
		responseMap.put("proTimes", timeList);

		PrintWriter out = response.getWriter();
		out.print(new Gson().toJson(responseMap));
    }
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
