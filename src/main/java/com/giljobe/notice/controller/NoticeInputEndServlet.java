package com.giljobe.notice.controller;

import com.giljobe.common.Constants;
import com.giljobe.notice.model.dto.Notice;
import com.giljobe.notice.model.service.NoticeService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/notice/insertend")
public class NoticeInputEndServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       String title = request.getParameter("title");
       String content = request.getParameter("content");
        Notice n = Notice.builder()
                .noticeContent(content)
                .noticeTitle(title)
                .build();
        int result = NoticeService.getInstance().insertNotice(n);
        String msg, loc;
        System.out.println("InputEndServlet result: "  +  result);
        //등록 성공
        if (result > 0) {
            msg = "공지사항 등록이 완료되었습니다.";
            loc = "/notice/noticelist";

        //등록 실패
        } else {
            msg = "공지사항 등록이 실패하였습니다.";
            loc = "/notice/insertform";
        }
        request.setAttribute("msg", msg);
        request.setAttribute("loc", loc);
       request.getRequestDispatcher(Constants.MSG).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
