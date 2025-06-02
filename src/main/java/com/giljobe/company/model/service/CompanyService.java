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
		if (result > 0) commit(conn);
	    else rollback(conn);
	    close(conn);
		return result;
	}
	public Company loginCompany(String id, String pw) {
		conn=getConnection();
		Company c = comDao.loginCompany(conn,id,pw);
		close(conn);
		return c;
	}
	public int updateCompany(Company c) {
		
		conn=getConnection();
		int result = CompanyDao.companyDao().updateCompany(conn,c);
		if (result > 0) commit(conn);
	    else rollback(conn);
	    close(conn);
		return result;
	}
	
	public Company searchCompanyByNo(int comNo) {
        Connection conn = getConnection();
        Company c = comDao.searchCompanyByNo(conn, comNo);
        close(conn);
        return c;
    }
	public int updateCompanyPw(int comNo, String companyPw, String newPw) {
		// TODO Auto-generated method stub
		conn = getConnection();
		Company company = comDao.updateCompanyPw(conn, comNo);
		if(company == null || !company.getComPw().equals(companyPw)) {
			return -1;
		}
		int result = comDao.updateCompanyPw(conn, comNo, newPw);
		
		
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
	public Company searchCompanyByBinNoAndEmail(String comBinNO, String comEmail) {

	conn=getConnection();
	Company company = comDao.searchCompanyByBinNoAndEmail(conn,comBinNO,comEmail);
	close(conn);
	return company;
	}
	public int updateComPwById(String authenticComId, String resetPw) {

		conn = getConnection();
		int result = comDao.updateComPwById(conn, authenticComId, resetPw);
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
	public Company searchCompanyByIdAndEmail(String comId, String comEmail) {
		conn=getConnection();
		Company company = comDao.searchCompanyByIdAndEmail(conn,comId,comEmail);
		close(conn);
		return company;
	}
	
}
