package com.giljobe.user.model.service;

import java.sql.Connection;

import com.giljobe.user.model.dao.UserDao;
import com.giljobe.user.model.dto.User;

public class UserService {
	
	private static final UserService SERVICE = new UserService();
	private UserService() {}
	public static UserService userService() {
		return SERVICE;
	}
	private UserDao userDao = UserDao.userDao();
	private Connection conn;
	
	public void enrollUser(User user) {
		// TODO Auto-generated method stub
		UserDao.userDao().enrollUser(conn);
		
	}
	
	
}
