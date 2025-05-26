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

@WebServlet("/program/programsearchform")
public class ProgramSearchFormServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        System.out.println("programSearchForm keyword: " + keyword);
        if (keyword != null && !keyword.isEmpty()) {
//          TODO: 카테고리 SelectBox Value
//          TODO: Input 값
            String[] subs = ProCategory.BUSINESS_OFFICE.getSubcategories();
            boolean result = Arrays.stream(subs).anyMatch(s -> s.equalsIgnoreCase(keyword));
            System.out.println(result);
            for (String s : subs) {
                System.out.println(s);
            }
        }


    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{

    }
}
