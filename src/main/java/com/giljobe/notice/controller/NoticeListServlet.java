package com.giljobe.notice.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.common.Constants;
import com.giljobe.notice.model.dto.Notice;
import com.giljobe.notice.model.service.NoticeService;


@WebServlet("/notice/noticelist")
public class NoticeListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public NoticeListServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int cPage;
		try {
			cPage = Integer.parseInt(request.getParameter("cPage"));
		} catch (NumberFormatException e) {
			cPage = 1;
		}
		int numPerPage = 5;

		//1. 전체 데이터 수 가져오기
		int totalCount = NoticeService.getInstance().noticeCount();
		System.out.println(totalCount);

		int totalPage = (int)Math.ceil((double)totalCount / numPerPage);
		int pageBarSize = 5;
		int pageNo = ((cPage - 1) / pageBarSize) * pageBarSize + 1;
		int pageEnd = pageNo + pageBarSize -1;

		//2. DB All NoticeList
		List<Notice> noticeList = NoticeService.getInstance().searchAllNotice(cPage, numPerPage);
		System.out.println(noticeList.toString());
		request.setAttribute("noticeList", noticeList);
		//3. set page
		request.getRequestDispatcher(Constants.WEB_VIEWS+"notice/noticeList.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
