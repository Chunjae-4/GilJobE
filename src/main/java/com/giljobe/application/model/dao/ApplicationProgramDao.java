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

import com.giljobe.application.model.dto.ApplicationProgram;

public class ApplicationProgramDao {
	private static final ApplicationProgramDao DAO = new ApplicationProgramDao();
	public static  ApplicationProgramDao applicationProgramDao() {
		return DAO;
	}
	private PreparedStatement pstmt;
	private ResultSet rs;
	private Properties sql = new Properties();
	
	private ApplicationProgramDao() {
		
		String path = ApplicationProgramDao.class.getResource("/sql/app.properties").getPath();
		try {
			FileReader fr = new FileReader(path);
			sql.load(fr);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	public List<ApplicationProgram> searchAppByUserNo(Connection conn, int userNo) {

		List<ApplicationProgram> apppro = new ArrayList<ApplicationProgram>();
		
		try {
			pstmt = conn.prepareStatement(sql.getProperty("searchAppByUserNo"));
			pstmt.setInt(1, userNo);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				apppro.add(getApplicationProgramDao(rs));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return apppro;
	}
	
	public ApplicationProgram getApplicationProgramDao(ResultSet rs) throws SQLException {
		
		return ApplicationProgram.builder()
								.proName(rs.getString("pro_name"))	
								.roundCount(rs.getInt("round_count"))
								.startTime(rs.getDate("start_time"))
								.endTime(rs.getDate("end_time"))
								.proNo(rs.getInt("pro_no"))
								.build();
	}

}
