package com.giljobe.company.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.giljobe.company.model.dto.Company;


public class CompanyDao {
	private PreparedStatement pstmt;
	private ResultSet rs;
	private Properties sql = new Properties();
	
	private static final CompanyDao DAO = new CompanyDao();
	public CompanyDao() {
		
		String path = CompanyDao.class.getResource("/sql/company.properties").getPath();
		try {
			FileReader fr = new FileReader(path);
			sql.load(fr);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
	}
	public static CompanyDao companyDao() {
		return DAO;
	}
	public Company getCompany(ResultSet rs) throws SQLException {
		
		return Company.builder()
						.comNo(rs.getInt("com_no"))
						.comName(rs.getString("con_name"))
						.comId(rs.getString("con_id"))
						.comPw(rs.getString("con_pw"))
						.comPhone(rs.getString("com_pw"))
						.comEmail(rs.getString("com_email"))
						.comBinNo(rs.getInt("com_bin_no"))
						.build();
	}
	
}
