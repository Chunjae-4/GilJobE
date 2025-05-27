package com.giljobe.application.model.dao;

import static com.giljobe.common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
	public List<Application> searchAppByUserNo(Connection conn, int userNo) {
		// TODO Auto-generated method stub
		List<Application> qnas= new ArrayList<Application>();
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchAppByUserNo"));
			pstmt.setInt(1, userNo);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				qnas.add(getApp(rs));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rs);
		}
	
		return qnas;
	}
	private Application getApp(ResultSet rs) throws SQLException {
		// TODO Auto-generated method stub
		return Application.builder()
							.appNo(rs.getInt("app_no"))
							.timeNoRef(rs.getInt("time_no"))
							.userNoRef(rs.getInt("uesr_no"))
							.applyState(rs.getBoolean("app_state"))
							.build();
	}
	private Map<String,Object> getAppMap(ResultSet rs)throws SQLException {
		Map<String,Object> app=new HashMap();
		app.put("",rs.getString(0));
		
		return app;
	}

}
