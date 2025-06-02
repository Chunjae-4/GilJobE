package com.giljobe.program.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.giljobe.application.model.dto.Application;
import com.giljobe.application.model.service.ApplicationService;
import com.giljobe.common.Constants;
import com.giljobe.program.model.dto.ProTime;
import com.giljobe.program.model.dto.Program;
import com.giljobe.program.model.dto.Round;
import com.giljobe.program.model.service.ProTimeService;
import com.giljobe.program.model.service.ProgramService;
import com.giljobe.program.model.service.RoundService;
import com.giljobe.user.model.dto.User;


@WebServlet("/program/detail")
public class ProgramDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ProgramDetailServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 요청 파라미터 받기
		String proNoStr = request.getParameter("proNo");

		// 2. 파라미터 유효성 검사
		if (proNoStr == null || proNoStr.trim().isEmpty()) {
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("loc", "/program/programlist"); // 예: 리스트 페이지로 리디렉션
			request.getRequestDispatcher(Constants.WEB_VIEWS+"program/programList.jsp").forward(request, response);
			return;
		}

		int proNo = Integer.parseInt(proNoStr);

		// 3. DB에서 해당 프로그램 조회
		Program program = ProgramService.getInstance().selectProgramByNo(proNo);

		if (program == null) {
			request.setAttribute("msg", "해당 프로그램 정보를 찾을 수 없습니다.");
			request.setAttribute("loc", "/program/programlist");
			request.getRequestDispatcher(Constants.WEB_VIEWS+"program/programList.jsp").forward(request, response);
			return;
		}
		List<Round> rounds = RoundService.getInstance().selectRoundsByProgramNo(proNo);
		request.setAttribute("rounds", rounds);
		
		LocalDate today = LocalDate.now();
		Round selectedRound = null;
		List<Round> expiredRounds = new ArrayList<>();
		List<Round> availableRounds = new ArrayList<>();
		for (Round r : rounds) {
		    LocalDate roundDate = r.getRoundDate().toLocalDate();
		    // Date 는 시간 값도 있어서, 날짜부분만 추출해야 함.
		    
		    if (roundDate.isBefore(today)) {
		        expiredRounds.add(r);
		    } else {
		        availableRounds.add(r);
		    }
		}
		
		// 회차들을 날짜 기준으로 정렬 - 토글에서 보여줄 때 필요
		rounds.sort(Comparator.comparing((Round r) -> r.getRoundDate().toLocalDate()).reversed());
		availableRounds.sort(Comparator.comparing((Round r) -> r.getRoundDate().toLocalDate()).reversed());
		expiredRounds.sort(Comparator.comparing((Round r) -> r.getRoundDate().toLocalDate()).reversed());

		
		// 가장 미래 회차 선택 (availableRounds 중 마지막)
		if (!availableRounds.isEmpty()) {
		    selectedRound = availableRounds.get(0);
		} else if (!rounds.isEmpty()) {
		    selectedRound = rounds.get(0); // fallback
		}
		
		// 각 availableRounds에 proTimes 채워넣기
		availableRounds = RoundService.getInstance().attachProTimes(availableRounds);
		// expiredRounds도 동일하게 처리 (JSP에서 검사할 경우를 대비)
		expiredRounds = RoundService.getInstance().attachProTimes(expiredRounds);



		// selectedRound의 protimes 를 불러옴
		List<ProTime> proTimes = new ArrayList<>();
		if (selectedRound != null) {
		    proTimes = ProTimeService.getInstance().selectProTimesByRoundNo(selectedRound.getRoundNo());
		}
		
		// naverMapKey 세팅
		String propPath = getServletContext().getRealPath("/WEB-INF/classes/api/naver.properties");
		Properties prop = new Properties();
		
		// 4. JSP에 전달할 데이터 저장
		request.setAttribute("program", program);
		request.setAttribute("selectedRound", selectedRound);
		request.setAttribute("proTimes", proTimes);
		request.setAttribute("availableRounds", availableRounds);
		request.setAttribute("expiredRounds", expiredRounds);
		
		try (FileInputStream fis = new FileInputStream(propPath)) {
		    prop.load(fis);
		    String apiKey = prop.getProperty("naver.map.key");
		    request.setAttribute("naverMapKey", apiKey); // naverMapKey 전달
		} catch (IOException e) {
		    e.printStackTrace();
		}
		
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("user");

		if (loginUser != null) {
		    List<Application> apps = ApplicationService.applicationService()
		                                               .searchAppsOfUser(loginUser.getUserNo());
		    loginUser.setApplications(apps); // ✅ 사용자 객체에 직접 담아줌
		}

		// JSP로 forward
		request.getRequestDispatcher(Constants.WEB_VIEWS + "program/programDetail.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
