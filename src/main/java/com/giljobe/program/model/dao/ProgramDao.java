package com.giljobe.program.model.dao;

import com.giljobe.common.LoggerUtil;
import com.giljobe.love.model.dto.Love;
import com.giljobe.love.model.service.LoveService;
import com.giljobe.program.model.dto.Program;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import static com.giljobe.common.JDBCTemplate.close;

public class ProgramDao {
    private static ProgramDao programDao = new ProgramDao();

    private Properties sql = new Properties();
    private PreparedStatement pstmt;
    private ResultSet rs;

    private ProgramDao() {
        String path = ProgramDao.class.getResource("/sql/program.properties").getPath();
        System.out.println(path);
        try (FileReader reader = new FileReader(path)) {
            sql.load(reader);
        } catch (IOException e) {
            LoggerUtil.error(e.getMessage(), e);
        }
    }
    public static ProgramDao getInstance() {
        return programDao;
    }

    public List<Program> searchAllProgram(Connection conn, int cPage, int numPerPage){
        List<Program> programList = new ArrayList<>();
        try {
            pstmt = conn.prepareStatement(sql.getProperty("searchAllProgram"));
            pstmt.setInt(1, (cPage - 1) * numPerPage + 1);
            pstmt.setInt(2, cPage * numPerPage);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Program p = getProgram(rs);
                programList.add(p);
            }
        } catch (SQLException e) {
            LoggerUtil.error(e.getMessage(), e);
        } finally {
            close(rs);
            close(pstmt);
        }
        return programList;
    }

    public List<Program> searchProgramListByCategory(Connection conn, String proCategory, int cPage, int numPerPage){
        List<Program> programList = new ArrayList<>();
        try {
            pstmt = conn.prepareStatement(sql.getProperty("searchProgramListByCategory"));
            pstmt.setString(1, proCategory);
            pstmt.setInt(2, (cPage - 1) * numPerPage + 1);
            pstmt.setInt(3, cPage * numPerPage);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Program p = getProgram(rs);
                programList.add(p);
            }
        } catch (SQLException e) {
            LoggerUtil.error(e.getMessage(), e);
        } finally {
            close(rs);
            close(pstmt);
        }
        return programList;
    }

    public List<Program> selectRandomRecommendedPrograms(Connection conn) {
        List<Program> programList = new ArrayList<>();
        try {
            pstmt = conn.prepareStatement(sql.getProperty("selectRandomRecommendedPrograms"));
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Program p = getSimpleProgram(rs);
                programList.add(p);
            }
        } catch (SQLException e) {
            LoggerUtil.error(e.getMessage(), e);
        } finally {
            close(rs);
            close(pstmt);
        }
        return programList;
    }


    public List<Program> searchProgramByTitleKeyword(Connection conn, String keyword, int cPage, int numPerPage) {
        List<Program> programList = new ArrayList<>();
        try {
            pstmt = conn.prepareStatement(sql.getProperty("searchProgramByTitleKeyword"));
            pstmt.setString(1, keyword);
            pstmt.setInt(2, (cPage - 1) * numPerPage + 1);
            pstmt.setInt(3, cPage * numPerPage);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Program p = getProgram(rs);
                programList.add(p);
            }
        } catch (SQLException e) {
            LoggerUtil.error(e.getMessage(), e);
        } finally {
            close(rs);
            close(pstmt);
        }
        return programList;
    }
    
    public Program selectProgramByNo(Connection conn, int proNo) {
        Program program = null;
        LoggerUtil.debug("ProgramDao.selectProgramByNo: " + proNo);
        try {
            pstmt = conn.prepareStatement(sql.getProperty("selectProgramByNo"));
            pstmt.setInt(1, proNo);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                program = getProgram(rs);
            }
        } catch (SQLException e) {
            LoggerUtil.error(e.getMessage(), e);
        } finally {
            close(rs);
            close(pstmt);
        }

        return program;
    }

    public int programCount(Connection conn)
    {
        int result = 0;
        try {
            pstmt = conn.prepareStatement(sql.getProperty("programCount"));
            rs = pstmt.executeQuery();
            if(rs.next()){
                result = rs.getInt(1);
            }
        } catch (SQLException e) {
            LoggerUtil.error(e.getMessage(), e);
        } finally {
            close(rs);
            close(pstmt);
        }
        return result;
    }



    public int countProgramListByCategory(Connection conn, String proCategory)
    {
        int result = 0;
        try {
            pstmt = conn.prepareStatement(sql.getProperty("countProgramListByCategory"));
            pstmt.setString(1, proCategory);
            rs = pstmt.executeQuery();
            if(rs.next()){
                result = rs.getInt(1);
            }
        } catch (SQLException e) {
            LoggerUtil.error(e.getMessage(), e);
        } finally {
            close(rs);
            close(pstmt);
        }
        return result;
    }

    public int countProgramByTitleKeyword(Connection conn, String keyword)
    {
        int result = 0;
        try {
            pstmt = conn.prepareStatement(sql.getProperty("countProgramByTitleKeyword"));
            pstmt.setString(1, keyword);
            rs = pstmt.executeQuery();
            if(rs.next()){
                result = rs.getInt(1);
            }
        } catch (SQLException e) {
            LoggerUtil.error(e.getMessage(), e);
        } finally {
            close(rs);
            close(pstmt);
        }
        return result;
    }
    
    public int getNextProNo(Connection conn)
    {
        int result = 0;
        try {
            pstmt = conn.prepareStatement(sql.getProperty("getNextProNo"));
            rs = pstmt.executeQuery();
            if(rs.next()){
                result = rs.getInt(1);
                // 시퀀스에서 cache_size가 0 이면, last_number는 nextval 했을때 나올 숫자를 정확히 예측 가능!
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
        }
        return result;
    }
    
    // insertProgram을 하면 등록된 프로그램의 proNo를 리턴해준다!
    public int insertProgram(Connection conn, Program program)
    {
        int result = 0;
        try {
            pstmt = conn.prepareStatement(sql.getProperty("insertProgram"));
            pstmt.setString(1, program.getProName());
            pstmt.setString(2, program.getProType());
            pstmt.setString(3, program.getProLocation());
            pstmt.setDouble(4, program.getProLatitude());
            pstmt.setDouble(5, program.getProLongitude());
            pstmt.setString(6, program.getProCategory());
            pstmt.setString(7, program.getProImageUrl());
            pstmt.setInt(8, program.getComNoRef());
            result = pstmt.executeUpdate();
            close(pstmt);

// 			INSERT 성공 시 시퀀스 CURRVAL로 PRO_NO 조회
            if (result > 0) {
                pstmt = conn.prepareStatement("SELECT SEQ_PRO_NO.CURRVAL FROM DUAL");
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    int proNo = rs.getInt(1);
                    program.setProNo(proNo); // 여기서 서블릿에서의 객체에 반영
                }
            }
            
        } catch (SQLException e) {
            LoggerUtil.error(e.getMessage(), e);
        } finally {
            close(rs);
            close(pstmt);
        }
        return result;
    }
    public Program getSimpleProgram(ResultSet rs) throws SQLException {
        int proNo = rs.getInt("pro_no");
        return Program.builder()
                .proNo(proNo)
                .proName(rs.getString("pro_name"))
                .proCategory(rs.getString("pro_category"))
                .proImageUrl(rs.getString("pro_image_url"))
                .build();
    }

    public Program getProgram(ResultSet rs) throws SQLException {
        int proNo = rs.getInt("pro_no");
        int likeCount = 0;
//        likeCount = LoveService.getInstance().countLoveByProgram(proNo);

        return Program.builder()
                .proNo(proNo)
                .proName(rs.getString("pro_name"))
                .proType(rs.getString("pro_type"))
                .proLocation(rs.getString("pro_location"))
                .proLatitude(rs.getDouble("pro_latitude"))
                .proLongitude(rs.getDouble("pro_longitude"))
                .proCategory(rs.getString("pro_category"))
                .proImageUrl(rs.getString("pro_image_url"))
                .likeCount(likeCount)
                .build();
    }
	public List<Program> lovedProgramByUserNo(Connection conn, int userNo) {
		// TODO Auto-generated method stub
		List<Program> programs = new ArrayList<Program>();
		try {
			pstmt = conn.prepareStatement(sql.getProperty("selectLovedProgramByUserNo"));
			pstmt.setInt(1, userNo);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				Program p = getProgram(rs);
				programs.add(p);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return programs;
	}
	
	public List<Program> selectProgramsByCompany(Connection conn, int comNo) {
		List<Program> programs = new ArrayList<Program>();
		try {
			pstmt = conn.prepareStatement(sql.getProperty("selectProgramsByCompany"));
			pstmt.setInt(1, comNo);
			rs=pstmt.executeQuery();
			while (rs.next()) {
                Program p = getProgram(rs);
                programs.add(p);
            }
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return programs;
	}
	
}
