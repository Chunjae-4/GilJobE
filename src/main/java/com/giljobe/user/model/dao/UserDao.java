package com.giljobe.user.model.dao;

public class UserDao {

	private static final UserDao DAO = new UserDao();
	private UserDao() {
		
		
		
	}
	public UserDao userDao() {
		return DAO;
	}
		
}
