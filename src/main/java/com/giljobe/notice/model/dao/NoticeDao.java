package com.giljobe.notice.model.dao;


import com.giljobe.common.LoggerUtil;
import com.giljobe.notice.model.dto.Notice;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import static com.giljobe.common.JDBCTemplate.close;
import static com.giljobe.common.JDBCTemplate.getConnection;

public class NoticeDao {
    private static NoticeDao noticeDao = new NoticeDao();

    private Properties sql = new Properties();
    private PreparedStatement pstmt;
    private ResultSet rs;

    private NoticeDao() {
        String path = NoticeDao.class.getResource("/sql/notice.properties").getPath();
        try (FileReader reader = new FileReader(path)) {
            sql.load(reader);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public static NoticeDao getInstance() {
        return noticeDao;
    }
    public int insertNotice(Connection conn, Notice n) {
        int result = 0;
        try {
            pstmt = conn.prepareStatement(sql.getProperty("insertNotice"));
            pstmt.setString(1, n.getNoticeTitle());
            pstmt.setString(2, n.getNoticeContent());
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            LoggerUtil.error(e.getMessage(), e);
        } finally {
            close(pstmt);
        }
        LoggerUtil.debug("NoticeDao result: " + result);
        return result;
    }

    public List<Notice> searchAllNotice(Connection conn, int cPage, int numPerPage){
        List<Notice> noticeList = new ArrayList<>();
        try {
            pstmt = conn.prepareStatement(sql.getProperty("searchAllNotice"));
            pstmt.setInt(1, (cPage - 1) * numPerPage + 1);
            pstmt.setInt(2, cPage * numPerPage);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Notice p = getNotice(rs);
                noticeList.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
        }
        return noticeList;
    }

    public int noticeCount(Connection conn)
    {
        int result = 0;
        try {
            pstmt = conn.prepareStatement(sql.getProperty("noticeCount"));
            rs = pstmt.executeQuery();
            if(rs.next()){
                result = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
        }
        return result;
    }
    public Notice selectNoticeByNo(Connection conn, int noticeNo) {
        Notice notice = null;

        try {
            pstmt = conn.prepareStatement(sql.getProperty("selectNoticeByNo"));
            pstmt.setInt(1, noticeNo);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                notice = getNotice(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
        }

        return notice;
    }

    public Notice getNotice(ResultSet rs) throws SQLException {
        return Notice.builder()
                .noticeNo(rs.getInt("notice_No"))
                .noticeContent(rs.getString("notice_Content"))
                .noticeDate(rs.getDate("notice_Date"))
                .noticeTitle(rs.getString("notice_Title"))
                .build();
    }
}
