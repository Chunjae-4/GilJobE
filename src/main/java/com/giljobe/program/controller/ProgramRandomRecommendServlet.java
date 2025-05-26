package com.giljobe.program.controller;

import com.giljobe.common.Constants;
import com.giljobe.program.model.dto.Program;
import com.giljobe.program.model.service.ProgramService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/program/randomrecommend")
public class ProgramRandomRecommendServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Program> randomRecommendProgramList = new ArrayList<>();

        int count = ProgramService.getInstance().programCount();
        if (count > 0) {
            for(int i = 1; i <= 3; i++) {
                System.out.println("i: "+ i);
                Program p = ProgramService.getInstance().selectProgramByNo(i);
                if (p != null) {
                    randomRecommendProgramList.add(p);
                }
            }
        }


        request.setAttribute("randomRecommend", randomRecommendProgramList);
        System.out.println("ProgramRandomRecommendServlet doGet request: " + randomRecommendProgramList );
        request.getRequestDispatcher("/").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
