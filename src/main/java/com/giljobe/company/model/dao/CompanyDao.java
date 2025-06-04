package com.giljobe.company.model.dao;

import static com.giljobe.common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
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
						.comName(rs.getString("com_name"))
						.comId(rs.getString("com_id"))
						.comPw(rs.getString("com_pw"))
						.comPhone(rs.getString("com_phone"))
						.comEmail(rs.getString("com_email"))
						.comBinNo(rs.getString("com_bin_no"))
						.build();
	}
	public Company searchUserById(Connection conn, String companyId) {
		// TODO Auto-generated method stub
		Company c = null;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("selectCompanyById"));
			pstmt.setString(1, companyId);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				c=getCompany(rs);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return c;
	}
	public int enrollCompany(Connection conn, Company c) {
		// TODO Auto-generated method stub
		int result = 0;
		
		try {
			pstmt=conn.prepareStatement(sql.getProperty("insertCompany"));
			pstmt.setString(1, c.getComName());
			pstmt.setString(2, c.getComId());
			pstmt.setString(3, c.getComPw());
			pstmt.setString(4, c.getComPhone());
			pstmt.setString(5, c.getComEmail());
			pstmt.setString(6, c.getComBinNo());
			result=pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}
	public Company loginCompany(Connection conn, String id, String pw) {
		Company c = null;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("loginCompany"));
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				c=getCompany(rs);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return c;
	}
	public int updateCompany(Connection conn, Company c) {
		int result = 0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("updateCompanyInfo"));
			pstmt.setString(1, c.getComName());
			pstmt.setString(2, c.getComPhone());
			pstmt.setString(3, c.getComBinNo());
			pstmt.setString(4, c.getComEmail());
			pstmt.setString(5, c.getComId());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}
	
	public Company searchCompanyByNo(Connection conn, int comNo) {
        Company result = null;
        try {
            pstmt = conn.prepareStatement(sql.getProperty("searchCompanyByNo"));
            pstmt.setInt(1, comNo);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                result = getCompany(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
        }
        return result;
    }
	public Company updateCompanyPw(Connection conn, int comNo) {
		// TODO Auto-generated method stub
		Company company = null;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchCompanyPwByComNo"));
			pstmt.setInt(1, comNo);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				company = Company.builder().comPw(rs.getString("com_pw")).build();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return company;
	}
	public int updateCompanyPw(Connection conn, int comNo, String newPw) {
		
		int result = 0;
		try {
		pstmt=conn.prepareStatement(sql.getProperty("updateCompanyPassword"));
		pstmt.setString(1, newPw);
		pstmt.setInt(2, comNo);
		result = pstmt.executeUpdate();
		}catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}
	public Company searchCompanyByBinNoAndEmail(Connection conn, String comBinNO, String comEmail) {
		
		Company company = null;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchCompanyByBinNoAndEmail"));
			pstmt.setString(1, comBinNO);
			pstmt.setString(2, comEmail);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				company=getCompany(rs);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return company;
	}
	public int updateComPwById(Connection conn, String authenticComId, String resetPw) {
		int result = 0;
		try {
			pstmt=conn.prepareStatement(sql.getProperty("updateComPwById"));
			pstmt.setString(1, resetPw);
			pstmt.setString(2, authenticComId);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}
	public Company searchCompanyByIdAndEmail(Connection conn, String comId, String comEmail) {
		
		Company company = null;
		
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchCompanyByIdAndEmail"));
			pstmt.setString(1, comId);
			pstmt.setString(2, comEmail);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				company=getCompany(rs);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return company;
	}

	
	}
