package com.giljobe.user.model.dao;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import static com.giljobe.common.JDBCTemplate.*;
import com.giljobe.user.model.dto.User;

public class UserDao {
	
	private PreparedStatement pstmt;
	private ResultSet rs;
	private Properties sql = new Properties();
	
	private static final UserDao DAO = new UserDao();
	public UserDao() {
		
		String path = UserDao.class.getResource("/sql/user_sql.properties").getPath();
		try {
			FileReader fr = new FileReader(path);
			sql.load(fr);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
	}
	public static UserDao userDao() {
		return DAO;
	}

	
	
	public int enrollUser(Connection conn, User user) {
		// TODO Auto-generated method stub
		int result = 0 ;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("enrollUser"));
			pstmt.setString(1, user.getUserId());
			pstmt.setString(2, user.getUserId());
			pstmt.setString(3, user.getUserId());
			pstmt.setString(4, user.getUserId());
			pstmt.setString(5, user.getUserId());
			pstmt.setString(6, user.getUserId());
			pstmt.setString(7, user.getUserId());
			result = pstmt.executeUpdate();
			conn.setAutoCommit(false);
			if(result>0) {
				commit(conn);
			}else {
				rollback(conn);
				close(conn);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	
	}
	
	public User getUser(ResultSet rs) throws SQLException {
		
		
		return User.builder()
					.userId(rs.getString("user_id"))
					.userPhone(rs.getInt("user_phone"))
					.userBirth(rs.getInt("user_birth"))
					.userEmail(rs.getString("user_email"))
					.userNickName(rs.getString("user_nickname"))
					.userName(rs.getString("user_name"))
					.build();
	}
	
}
