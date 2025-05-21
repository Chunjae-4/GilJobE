package com.giljobe.user.model.service;

public class UserService {
	
	private static final UserService SERVICE = new UserService();
	private UserService() {}
	public UserService userService() {
		return SERVICE;
	}
	
}
