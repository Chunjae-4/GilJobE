package com.giljobe.program.controller;

import com.giljobe.common.LoggerUtil;
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
        LoggerUtil.start("AppInitListener Start");
        List<Program> randomRecommendProgramList = new ArrayList<>();

        int count = ProgramService.getInstance().programCount();
        if (count > 0) {
            for(int i = 1; i <= 3; i++) {
                Program p = ProgramService.getInstance().selectProgramByNo(i);
                if (p != null) {
                    randomRecommendProgramList.add(p);
                }
            }
        }

        ServletContext context = sce.getServletContext();

        context.setAttribute("randomRecommend", randomRecommendProgramList);
        LoggerUtil.end("AppInitListener Ready:" + !randomRecommendProgramList.isEmpty());
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        LoggerUtil.status("AppInitListener contextDestroyed:");
    }
}