package com.giljobe.notice.model.service;


import com.giljobe.notice.model.dao.NoticeDao;
import com.giljobe.notice.model.dto.Notice;

import java.sql.Connection;
import java.util.List;

import static com.giljobe.common.JDBCTemplate.*;

public class NoticeService {
    private static final NoticeService service = new NoticeService();
    private NoticeService() {}
    public static NoticeService getInstance() {
        return service;
    }

    private NoticeDao dao = NoticeDao.getInstance();

    public int noticeCount() {
        Connection conn = getConnection();
        int totalCount = dao.noticeCount(conn);
        close(conn);
        return totalCount;
    }

    public int insertNotice(Notice n) {
        Connection conn = getConnection();
        int result = dao.insertNotice(conn, n);
        if(result>0) commit(conn);
        else rollback(conn);
        close(conn);
        return result;
    }

    public List<Notice> searchAllNotice(int cPage, int numPerPage) {
        Connection conn = getConnection();
        List<Notice> noticeList = dao.searchAllNotice(conn, cPage, numPerPage);
        close(conn);
        return noticeList;
    }

    public Notice selectNoticeByNo(int noticeNo) {
        Connection conn = getConnection();
        Notice notice = NoticeDao.getInstance().selectNoticeByNo(conn, noticeNo);
        close(conn);
        return notice;
    }
}
