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
		
		String path = UserDao.class.getResource("/sql/user.properties").getPath();
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
		//DB접근해서 유저 저장하고 성공인지 실패인지 결과만 확인
		int result = 0 ;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("enrollUser"));
			pstmt.setString(1, user.getUserId());//아이디
			pstmt.setString(2, user.getUserName());//이름
			pstmt.setString(3, user.getUserPw());//비밀번호?
			pstmt.setString(4, user.getUserPhone());//폰번호
			pstmt.setDate(5, user.getUserBirth());//생일
			pstmt.setString(6, user.getUserEmail());//이메일
			pstmt.setString(7, user.getUserNickName());//채팅닉네임
			result = pstmt.executeUpdate();
			conn.setAutoCommit(false);
	
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	
	}
	
	public User login(Connection conn, String id, String pw) {
		
		User u = null;
		
		try {
			pstmt=conn.prepareStatement(sql.getProperty("loginUser"));
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				u=getUser(rs);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		
		return u;
	}
	
	public User getUser(ResultSet rs) throws SQLException {
			
		return User.builder()
					.userNo(rs.getInt("user_no"))
					.userId(rs.getString("user_id"))
					.userPhone(rs.getString("user_phone"))
					.userBirth(rs.getDate("user_birth"))
					.userEmail(rs.getString("user_email"))
					.userNickName(rs.getString("user_nickname"))
					.userName(rs.getString("user_name"))
					.userRoleNo(rs.getInt("user_role_no"))
					.build();
	}
	public User searchUserById(Connection conn, String userId) {
		// TODO Auto-generated method stub
		User u = null;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchUserById"));
			pstmt.setString(1, userId);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				u=getUser(rs);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rs);
		}
		
		return u;
	}
	public int updateUser(Connection conn, User u) {

		int result = 0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("updateUserInfo"));
			pstmt.setString(1, u.getUserName());
			pstmt.setString(2, u.getUserPhone());
			pstmt.setString(3, u.getUserNickName());
			pstmt.setString(4, u.getUserEmail());
			pstmt.setDate(5, u.getUserBirth());
			pstmt.setString(6, u.getUserId());
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}
	public int updateUserPw(Connection conn, int userNo, String newPw) {

		int result = 0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("updateUserPassword"));
			pstmt.setString(1, newPw);
			pstmt.setInt(2, userNo);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}
	public User getUserPwByNo(Connection conn, int userNo) {
		// TODO Auto-generated method stub
		User user = null;
		
		try {
			pstmt = conn.prepareStatement(sql.getProperty("searchUserPwByUserNo"));
			pstmt.setInt(1, userNo);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				user = User.builder()
	                    .userPw(rs.getString("user_pw"))
	                    .build();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return user;
	}
	public User searchUserByIdAndEmail(Connection conn, String userId, String userEmail) {
		
		User user = null;
		
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchUserByIdAndEmail"));
			pstmt.setString(1, userId);
			pstmt.setString(2, userEmail);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				user=getUser(rs);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		
		return user;
	}
	public int updateUserPwById(Connection conn, String userId, String resetPw) {
		
		int result = 0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("updateUserPasswordById"));
			pstmt.setString(1, resetPw);
			pstmt.setString(2, userId);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
		
	}
	public User searchUserByNameAndEmail(Connection conn, String userName, String userEmail) {

		User user = null;
		
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchUserByNameAndEmail"));
			pstmt.setString(1, userName);
			pstmt.setString(2, userEmail);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				user=getUser(rs);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		
		return user;
	}
}
