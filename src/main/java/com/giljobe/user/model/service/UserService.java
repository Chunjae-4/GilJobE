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
		int result = userDao.enrollUser(conn,user);//근데 로그인 성공 실패를 분기 처리 해야하나
		if(result>0) {
			//성공
			commit(conn);
		}else {
			//실패
			rollback(conn);
		}
		close(conn);
		return result;
		
	}
	public User login(String id, String pw) {
		
		conn=getConnection();
		User u = userDao.login(conn, id, pw);
		close(conn);
		return u;
	}
	
	public User searchUserById(String userId) {
		// TODO Auto-generated method stub
		conn=getConnection();
		User u = userDao.searchUserById(conn,userId);
		close(conn);
		return u;
	}
	public int updateUser(User u) {
		
		conn=getConnection();
		int result = UserDao.userDao().updateUser(conn, u);
		if(result>0) {
			//성공
			commit(conn);
		}else {
			//실패
			rollback(conn);
		}
		close(conn);
		return result;
	}
	public int updateUserPw(int userNo, String userPw, String newPw) {
		// TODO Auto-generated method stub
		conn = getConnection();
		
		User user = userDao.getUserPwByNo(conn, userNo);
		//유저비밀번호만 유저에 담아서 String 말고 걍 유저에 담음
		if(user==null || !user.getUserPw().equals(userPw)) {
			//원래 있던 비번이랑 자기 비번이랍시고 입력한 비번과 다르면 -1 반환
			return -1;
		}
		
		int result = userDao.updateUserPw(conn, userNo, newPw);
		//위의 조건문으로 안빠지면 업데이트
		
		if(result>0) {
			//성공
			commit(conn);
		}else {
			//실패
			rollback(conn);
		}
		close(conn);
		return result;
	}
	public User searchUserByIdAndEmail(String userId, String userEmail) {
		conn=getConnection();
		User user = userDao.searchUserByIdAndEmail(conn,userId,userEmail);
		close(conn);
		return user;
	}
	public int updateUserPwById(String userId, String resetPw) {

		conn = getConnection();
		
		int result = userDao.updateUserPwById(conn, userId, resetPw);
		
		if(result>0) {
			//성공
			commit(conn);
		}else {
			//실패
			rollback(conn);
		}
		close(conn);
		return result;
	}
	public User searchUserByNameAndEmail(String userName, String userEmail) {
		conn=getConnection();
		User user = userDao.searchUserByNameAndEmail(conn,userName,userEmail);
		close(conn);
		return user;
	}
	
}
