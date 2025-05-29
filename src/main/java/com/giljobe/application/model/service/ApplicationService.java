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
	public int removeApplication(int timeNo, int userNo) {

		conn=getConnection();
		int result = appprodao.removeApplication(conn, timeNo, userNo);
		close(conn);
		return result;
	}
}
