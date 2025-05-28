package com.giljobe.program.listener;

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
       try{
           List<Program> randomRecommendProgramList = ProgramService.getInstance().searchProgramsInfo();

           ServletContext context = sce.getServletContext();
           context.setAttribute("randomRecommend", randomRecommendProgramList);
           LoggerUtil.debug("AppInitListener Ready:" + !randomRecommendProgramList.isEmpty());
       } catch (Exception e){
           LoggerUtil.error("AppInitListener Exception: "+e.getMessage(), e);
       }
        LoggerUtil.end("AppInitListener Init");

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        LoggerUtil.status("AppInitListener contextDestroyed:");
    }
}