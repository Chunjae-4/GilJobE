package com.giljobe.program.controller;

import java.io.IOException;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.common.Constants;

@WebServlet("/round/add-with-detail")
public class RoundAddWithDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public RoundAddWithDetailServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		현재 URL: /round/add-with-detail?proNo=XXX
//		해당 프로그램 번호(proNo)를 기반으로 회차 정보를 수기로 입력
//		날짜는 1일만 선택 가능
//		시간대(ProTime)는 사용자가 시작 시간 여러 개를 선택 + 활동 시간 입력 → endTime 자동 계산
		
		LocalDate today = LocalDate.now();
		request.setAttribute("todayDate", today.toString()); // yyyy-MM-dd 형식
		request.getRequestDispatcher(Constants.WEB_VIEWS + "/program/roundAddWithDetail.jsp")
		       .forward(request, response);

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
