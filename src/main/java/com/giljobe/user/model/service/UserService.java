package com.giljobe.user.model.service;

import java.sql.Connection;

import com.giljobe.user.model.dao.UserDao;
import com.giljobe.user.model.dto.User;
import static com.giljobe.common.JDBCTemplate.*;

public class UserService {
	
	private static final UserService SERVICE = new UserService();
	private UserService() {}
	public static UserService userService() {
		return SERVICE;
	}
	private UserDao userDao = UserDao.userDao();
	private Connection conn;
	
	public int enrollUser(User user) {
		// TODO Auto-generated method stub
		conn=getConnection();
		int result = UserDao.userDao().enrollUser(conn,user);//근데 로그인 성공 실패를 분기 처리 해야하나
		close(conn);
		if(result>0) {
			//성공
			commit(conn);
		}else {
			//실패
			rollback(conn);
			close(conn);
		}
		
		return result;
		
	}
	
	
}
