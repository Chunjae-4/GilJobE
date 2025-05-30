package com.giljobe.application.model.service;

import static com.giljobe.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.List;

import com.giljobe.application.model.dao.ApplicationDao;
import com.giljobe.application.model.dao.ApplicationProgramDao;
import com.giljobe.application.model.dto.Application;
import com.giljobe.application.model.dto.ApplicationProgram;

public class ApplicationService {
	private static final ApplicationService SERVICE = new ApplicationService();
	private ApplicationService() {}
	public static ApplicationService applicationService() {
		return SERVICE;
	}
	private ApplicationDao appdao = ApplicationDao.applicationDao();
	private ApplicationProgramDao appprodao = ApplicationProgramDao.applicationProgramDao();
	private Connection conn;
	
	public List<ApplicationProgram> searchAppByUserNo(int userNo) {
		// TODO Auto-generated method stub
		conn=getConnection();
		List<ApplicationProgram> apps = appprodao.searchAppByUserNo(conn,userNo);
		close(conn);
		return apps;
	}
//	public int removeApplication(int timeNo, int userNo) {
//
//		conn=getConnection();
//		int result = appprodao.removeApplication(conn, timeNo, userNo);
//		if (result > 0) commit(conn);
//	    else rollback(conn);
//	    close(conn);
//		return result;
//	}
	

	public boolean existsAppForTimeAndUser(int timeNo, int userNo) {
	    conn = getConnection();
	    boolean result = appdao.existsAppForTimeAndUser(conn, timeNo, userNo);
	    close(conn);
	    return result;
	}

	public boolean insertApp(int timeNo, int userNo) {
	    conn = getConnection();
	    int result = appdao.insertApp(conn, timeNo, userNo);
	    if (result > 0) commit(conn);
	    else rollback(conn);
	    close(conn);
	    return result > 0;
	}

	public boolean deleteApp(int timeNo, int userNo) {
	    conn = getConnection();
	    int result = appdao.deleteApp(conn, timeNo, userNo);
	    if (result > 0) commit(conn);
	    else rollback(conn);
	    close(conn);
	    return result > 0;
	}

	public int countAppByTimeNo(int timeNo) {
	    conn = getConnection();
	    int count = appdao.countAppByTimeNo(conn, timeNo);
	    close(conn);
	    return count;
	}
	
	public List<Application> searchAppsOfUser(int userNo) {
	    conn = getConnection();
	    List<Application> list = appdao.searchAppsOfUser(conn, userNo);
	    close(conn);
	    return list;
	}

}
