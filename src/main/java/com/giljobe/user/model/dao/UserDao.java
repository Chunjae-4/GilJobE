package com.giljobe.user.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;

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
	public void enrollUser(Connection conn) {
		// TODO Auto-generated method stub
		
	}
		
}
