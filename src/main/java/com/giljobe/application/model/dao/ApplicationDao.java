package com.giljobe.application.model.dao;


import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.giljobe.application.model.dto.Application;

public class ApplicationDao {
	private static final ApplicationDao DAO = new ApplicationDao();
	public static  ApplicationDao applicationDao() {
		return DAO;
	}
	private PreparedStatement pstmt;
	private ResultSet rs;
	private Properties sql = new Properties();
	
	private ApplicationDao() {
		
		String path = ApplicationDao.class.getResource("/sql/app.properties").getPath();
		try {
			FileReader fr = new FileReader(path);
			sql.load(fr);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	public Application getApp(ResultSet rs) throws SQLException {
		// TODO Auto-generated method stub
		return Application.builder()
							.appNo(rs.getInt("app_no"))
							.timeNoRef(rs.getInt("time_no"))
							.userNoRef(rs.getInt("user_no"))
							.applyState(rs.getBoolean("app_state"))
							.build();
	}
//	private Map<String,Object> getAppMap(ResultSet rs)throws SQLException {
//		Map<String,Object> app=new HashMap();
//		app.put("",rs.getString(0));
//		
//		return app;
//	}

	// ApplicationDao.java 내부에 추가

	public boolean existsAppForTimeAndUser(Connection conn, int timeNo, int userNo) {
	    boolean exists = false;
	    try (PreparedStatement pstmt = conn.prepareStatement(sql.getProperty("existsAppForTimeAndUser"))) {
	        pstmt.setInt(1, timeNo);
	        pstmt.setInt(2, userNo);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) exists = rs.getInt(1) > 0;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return exists;
	}

	public int insertApp(Connection conn, int timeNo, int userNo) {
	    int result = 0;
	    try (PreparedStatement pstmt = conn.prepareStatement(sql.getProperty("insertApp"))) {
	        pstmt.setInt(1, timeNo);
	        pstmt.setInt(2, userNo);
	        pstmt.setBoolean(3, true); // app_state
	        result = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return result;
	}

	public int deleteApp(Connection conn, int timeNo, int userNo) {
	    int result = 0;
	    try (PreparedStatement pstmt = conn.prepareStatement(sql.getProperty("deleteApp"))) {
	        pstmt.setInt(1, timeNo);
	        pstmt.setInt(2, userNo);
	        result = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return result;
	}
	
	public int deleteByOnlyTimeNo(Connection conn, int timeNo) {
	    int result = 0;
	    try (PreparedStatement pstmt = conn.prepareStatement(sql.getProperty("deleteByOnlyTimeNo"))) {
	        pstmt.setInt(1, timeNo);
	        result = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return result;
	}

	public int countAppByTimeNo(Connection conn, int timeNo) {
	    int count = 0;
	    try (PreparedStatement pstmt = conn.prepareStatement(sql.getProperty("countAppByTimeNo"))) {
	        pstmt.setInt(1, timeNo);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            if (rs.next()) count = rs.getInt(1);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return count;
	}

	public List<Application> searchAppsOfUser(Connection conn, int userNo) {
	    List<Application> list = new ArrayList<>();
	    try (PreparedStatement pstmt = conn.prepareStatement(sql.getProperty("searchAppsOfUser"))) {
	        pstmt.setInt(1, userNo);
	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                list.add(getApp(rs));
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return list;
	}

}
