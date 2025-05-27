package com.giljobe.application.model.service;

import static com.giljobe.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.List;

import com.giljobe.application.model.dao.ApplicationDao;
import com.giljobe.application.model.dto.Application;

public class ApplicationService {
	private static final ApplicationService SERVICE = new ApplicationService();
	private ApplicationService() {}
	public static ApplicationService applicationService() {
		return SERVICE;
	}
	private ApplicationDao appdao = ApplicationDao.applicationDao();
	private Connection conn;
	
	public List<Application> searchQNAByUserNo(int userNo) {
		// TODO Auto-generated method stub
		conn=getConnection();
		List<Application> qnas = appdao.searchQNAByUserNo(conn,userNo);
		close(conn);
		return qnas;
	}
}
