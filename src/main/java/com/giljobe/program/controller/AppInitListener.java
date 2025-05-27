package com.giljobe.program.controller;

import com.giljobe.program.model.dto.Program;
import com.giljobe.program.model.service.ProgramService;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.ArrayList;
import java.util.List;

@WebListener
public class AppInitListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("✅ 웹 애플리케이션 시작됨: contextInitialized");
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

        ServletContext context = sce.getServletContext();

        context.setAttribute("randomRecommend", randomRecommendProgramList);
        System.out.println("AppInitListener request: " + randomRecommendProgramList);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("❌ 웹 애플리케이션 종료됨: contextDestroyed");
    }
}