package com.giljobe.program.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.common.Constants;
import com.giljobe.program.model.dto.Program;
import com.giljobe.program.model.service.ProgramService;


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
//		Program program = new ProgramService(). .selectProgramByNo(proNo);
		Program program = new ProgramService().getInstance().se

		if (program == null) {
			request.setAttribute("msg", "해당 프로그램 정보를 찾을 수 없습니다.");
			request.setAttribute("loc", "/program/programlist");
			request.getRequestDispatcher(Constants.WEB_VIEWS+"program/programList.jsp").forward(request, response);
			return;
		}

		// 4. JSP에 전달할 데이터 저장
		request.setAttribute("program", program);
		
		request.getRequestDispatcher(Constants.WEB_VIEWS+"program/programDetail.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
