package com.giljobe.user.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;

import com.giljobe.user.model.dto.User;

public class UserDao {

	private static final UserDao DAO = new UserDao();
	public UserDao() {
		
		//properties 
		
		
	}
	public static UserDao userDao() {
		return DAO;
	}
	private PreparedStatement pstmt;
	private ResultSet rs;
	private Properties sql = new Properties();
	
	
	public int enrollUser(Connection conn, User user) {
		// TODO Auto-generated method stub
		
//		pstmt=conn.prepareStatement("INSERT INTO USER VALUES(");
		
		
		return 0;
	
	}
		
}
