package com.giljobe.program.controller;

import com.giljobe.common.Constants;
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
        String keyword = request.getParameter("keyword");
        if (keyword != null && !keyword.isEmpty()) {
//          TODO: 카테고리 SelectBox Value
//          TODO: Input 값
//            String[] subs = ProCategory.BUSINESS_OFFICE.getSubcategories();
            List<Program> programList = ProgramService.getInstance().searchProgramByTitleKeyword(keyword);
            System.out.println("ProgramSearchForm Servlet: " + programList);
            boolean isExist = !programList.isEmpty();

            //프로그램 이름에 키워드 포함되는지 확인하고 정보 가져와서 세팅
            System.out.println(isExist);
            if (isExist) {
                request.setAttribute("programList", programList);
                System.out.println("programSearchForm Exist keyword: " + keyword);
                request.getRequestDispatcher(Constants.WEB_VIEWS + "/program/programList.jsp").forward(request, response);
            } else {
                System.out.println("programSearchForm NONExist keyword: " + keyword);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

    }
}
