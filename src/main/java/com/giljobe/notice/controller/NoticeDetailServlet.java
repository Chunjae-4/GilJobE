package com.giljobe.notice.controller;
import com.giljobe.common.Constants;
import com.giljobe.notice.model.dto.Notice;
import com.giljobe.notice.model.service.NoticeService;
import com.giljobe.program.model.dto.Program;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/notice/detail")
public class NoticeDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String no = (String)request.getParameter("no");
        Notice notice = NoticeService.getInstance().selectNoticeByNo(Integer.parseInt(no));
        if (notice != null) {
            request.setAttribute("notice", notice);
        }
        System.out.println(notice);
        request.getRequestDispatcher(Constants.WEB_VIEWS + "notice/noticeDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
