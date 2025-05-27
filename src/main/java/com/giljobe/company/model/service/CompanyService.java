package com.giljobe.company.model.service;

import java.sql.Connection;
import static com.giljobe.common.JDBCTemplate.*;

import com.giljobe.company.model.dao.CompanyDao;
import com.giljobe.company.model.dto.Company;


public class CompanyService {
	private static final CompanyService SERVICE = new CompanyService();
	private CompanyService() {}
	public static CompanyService companyService() {
		return SERVICE;
	}
	private CompanyDao comDao = CompanyDao.companyDao();
	private Connection conn;
	
	public Company searchCompanyById(String companyId) {
		conn=getConnection();
		Company c = comDao.searchUserById(conn,companyId);
		close(conn);
		return c;
	}
	public int enrollCompany(Company c) {
		conn=getConnection();
		int result = comDao.enrollCompany(conn,c);
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
	public Company loginCompany(String id, String pw) {
		conn=getConnection();
		Company c = comDao.loginCompany(conn,id,pw);
		close(conn);
		return c;
	}
	
	
	
}
