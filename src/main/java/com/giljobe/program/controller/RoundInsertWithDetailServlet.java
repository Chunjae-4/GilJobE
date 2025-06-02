package com.giljobe.program.controller;

import java.io.File;
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
import javax.servlet.http.HttpSession;

import com.giljobe.common.Constants;
import com.giljobe.program.model.dto.ProTime;
import com.giljobe.program.model.dto.Program;
import com.giljobe.program.model.dto.Round;
import com.giljobe.program.model.service.ProgramService;

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
//		Program, Round, ProTime insert
		
		request.setCharacterEncoding("UTF-8");

        // 0. 세션에 보관된 pendingProgram 꺼내기
        HttpSession session = request.getSession();
        Program program = (Program) session.getAttribute("pendingProgram");
        if (program == null) {
            request.setAttribute("msg", "프로그램 정보가 유실되었습니다. 처음부터 다시 시도해주세요.");
            request.setAttribute("loc", request.getContextPath() + "/program/new");
            request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
            return;
        }
	
        // 1. 기본값 수집
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
        
        
        // 2. Round 객체 생성 (여기는 proNo 이 없음)
        int roundCount = 1; // 새로운 프로그램의 첫 round가 되는 것.
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
                .build();

        // 3. ProTime 목록 생성 (여기는 roundNo이 없음)
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
                    .build();
            proTimeList.add(pt);
        }

        // 4. 서비스 호출 → Program + Round + ProTime 트랜잭션으로 insert
        boolean result = ProgramService.getInstance()
                .insertProgramWithRoundAndProTimes(program, round, proTimeList);
        
        // 이미지 경로 수정 작업 (temp_xxxx → proNo 기반으로 이동)
        String tempDirPath = (String) session.getAttribute("pendingImageTempPath");
        String tempRelativePath = (String) session.getAttribute("pendingImageRelativePath");
        int comNo = program.getComNoRef();
        int proNo = program.getProNo();
        String newRelativePath = comNo + "/" + proNo;
        String newImagePath = newRelativePath + "/1" + getFileExtension(program.getProImageUrl());
        String realDirPath = getServletContext().getRealPath(Constants.DEFAULT_UPLOAD_PATH + newRelativePath);
        File tempDir = new File(tempDirPath);
        File realDir = new File(realDirPath);
        // 디렉토리 이름 변경 (rename)
        if (tempDir.exists() && tempDir.isDirectory()) {
            boolean moved = tempDir.renameTo(realDir);
            if (moved) {
                program.setProImageUrl(newImagePath);
                ProgramService.getInstance().updateProgramImagePath(proNo, newImagePath); // DB 반영
            } else {
                System.err.println("❌ 이미지 디렉토리 이동 실패: " + tempDirPath + " → " + realDirPath);
            }
        }
        
        // 5. 세션에서 임시 객체 제거
        session.removeAttribute("pendingProgram");
        
        // 6. 완료 후 리다이렉트
        if (result) {
            response.sendRedirect(request.getContextPath() + "/program/detail?proNo=" + program.getProNo());
        } else {
            request.setAttribute("msg", "등록 중 오류가 발생했습니다.");
            request.setAttribute("loc", request.getContextPath() + "/program/new");
            request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
        }   
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	private String getFileExtension(String path) {
	    int dotIndex = path.lastIndexOf(".");
	    return dotIndex != -1 ? path.substring(dotIndex) : "";
	}

}
