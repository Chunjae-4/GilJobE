package com.giljobe.love.model.dao;


import com.giljobe.common.LoggerUtil;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import static com.giljobe.common.JDBCTemplate.*;

public class LoveDao {
    private static LoveDao loveDao = new LoveDao();

    private Properties sql = new Properties();
    private PreparedStatement pstmt;
    private ResultSet rs;

    private LoveDao() {
        String path = LoveDao.class.getResource("/sql/love.properties").getPath();
        try (FileReader reader = new FileReader(path)) {
            sql.load(reader);
        } catch (IOException e) {
            LoggerUtil.error(e.getMessage(), e);

        }
    }
    public static LoveDao getInstance() {
        return loveDao;
    }

    public int countLoveByProgram(Connection conn, int proNo) {
        int result = 0;
        try{
            pstmt = conn.prepareStatement(sql.getProperty("countLoveByProgram"));
            pstmt.setInt(1, proNo);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                result = rs.getInt(1);
            }
        } catch (SQLException e) {
            LoggerUtil.error("LoveDao countLoveByProgram exception: " + e.getMessage(), e);
        } finally {
            close(rs);
            close(pstmt);
        }
        return result;
    }
	public int removelove(Connection conn, int proNo, int userNo) {
		int result = 0;
        try{
            pstmt = conn.prepareStatement(sql.getProperty("deleteLove"));
            pstmt.setInt(1, userNo);
            pstmt.setInt(2, proNo);
            result = pstmt.executeUpdate();
            
        } catch (SQLException e) {
        		e.getStackTrace();
        } finally {
            close(rs);
            close(pstmt);
        }
        return result;
	}

}
