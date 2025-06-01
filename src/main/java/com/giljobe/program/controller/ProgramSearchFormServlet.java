package com.giljobe.program.controller;

import com.giljobe.common.Constants;
import com.giljobe.common.LoggerUtil;
import com.giljobe.common.ProCategory;
import com.giljobe.program.model.dto.Program;
import com.giljobe.program.model.service.ProgramService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet("/program/programsearchform")
public class ProgramSearchFormServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LoggerUtil.start("ProgramSearchForm doGet");
        String keyword = request.getParameter("keyword");

        //TODO: programcount 말고 검색 결과기준 programcount..
        int totalCount = ProgramService.getInstance().countProgramByTitleKeyword(keyword);
        int cPage;
        try {
            cPage = Integer.parseInt(request.getParameter("cPage"));
        } catch (NumberFormatException e) {
            cPage = 1;
        }

        int numPerPage = 6;
        int totalPage = (int)Math.ceil((double)totalCount / numPerPage);
        int pageBarSize = 5;
        int pageStart = ((cPage - 1) / pageBarSize) * pageBarSize + 1;
        int pageEnd = pageStart + pageBarSize -1;

        request.setAttribute("pageStart", pageStart);
        request.setAttribute("pageEnd", pageEnd);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("cPage", cPage);
        request.setAttribute("pageUri", request.getRequestURI());

        if (keyword != null && !keyword.isEmpty()) {
            List<Program> programList = ProgramService.getInstance().searchProgramByTitleKeyword(keyword, cPage, numPerPage);
            boolean isExist = !programList.isEmpty();

            //프로그램 이름에 키워드 포함되는지 확인하고 정보 가져와서 세팅
            if (isExist) {
                request.setAttribute("programList", programList);
                LoggerUtil.debug("Search Program Exist keyword " + keyword);
                request.getRequestDispatcher(Constants.WEB_VIEWS + "/program/programList.jsp").forward(request, response);
            } else {
                LoggerUtil.debug("Search Program NON Exist keyword " + keyword);
                request.getRequestDispatcher(Constants.WEB_VIEWS + "/program/programList.jsp").forward(request, response);
            }
        }
        LoggerUtil.end("ProgramSearchForm doGet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

    }
}
