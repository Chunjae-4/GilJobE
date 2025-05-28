package com.giljobe.program.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/program/selectsubmit")
public class ProgramSelectSubmitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ProgramSelectSubmitServlet() {
        super();
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
//    	programType 값에 따라 새 프로그램 등록 vs 기존 프로그램 회차 추가 구분
//    	기존 프로그램 선택 시, selectedProNo 값 확보
//    	세부 변경 여부 changeDetail 값 파악
//    	조건에 맞는 화면으로 redirect 처리
    	
    	
    	String programType  = request.getParameter("programType"); // "new" or "existing"
		String changeDetail = request.getParameter("changeDetail"); // "yes" or "no" or null
        String selectedProNo = request.getParameter("selectedProNo"); // null if new

		
     // 2. 분기 처리
        if ("new".equals(programType)) {
            // 새 프로그램 등록 화면으로 이동
            response.sendRedirect(request.getContextPath() + "/program/new");
        } else if ("existing".equals(programType) && selectedProNo != null) {
            int proNo = Integer.parseInt(selectedProNo);

            if ("yes".equals(changeDetail)) {
                // 회차 추가 (세부정보 변경 있음)
                response.sendRedirect(request.getContextPath() + "/round/add-with-detail-existing?proNo=" + proNo);
            } else {
                // 회차 추가 (세부정보 변경 없음 - 복사)
                response.sendRedirect(request.getContextPath() + "/round/add-copy-latest?proNo=" + proNo);
            }

        } else {
            // 유효하지 않은 접근 처리
            request.setAttribute("msg", "잘못된 접근입니다.");
            request.setAttribute("loc", request.getContextPath() + "/program/selectform");
            request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
        }

	}

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
