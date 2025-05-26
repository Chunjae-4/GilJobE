package com.giljobe.program.model.dao;

import com.giljobe.common.JDBCTemplate;
import com.giljobe.program.model.dto.Program;

import java.io.FileNotFoundException;
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
            throw new RuntimeException(e);
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
            throw new RuntimeException(e);
        } finally {
            close(rs);
            close(pstmt);
        }
        return programList;
    }
    
    public Program selectProgramByNo(Connection conn, int proNo) {
        Program program = null;
        
        try {
            pstmt = conn.prepareStatement(sql.getProperty("selectProgramByNo"));
            pstmt.setInt(1, proNo);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                program = getProgram(rs);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
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
                System.out.println(result);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            close(rs);
            close(pstmt);
        }
        return result;
    }

    private Program getProgram(ResultSet rs) throws SQLException {
        return Program.builder()
                .proNo(rs.getInt("pro_no"))
                .proName(rs.getString("pro_name"))
                .proType(rs.getString("pro_type"))
                .proLocation(rs.getString("pro_location"))
                .proLatitude(rs.getDouble("pro_latitude"))
                .proLongitude(rs.getDouble("pro_longitude"))
                .proCategory(rs.getString("pro_category"))
                .proImageUrl(rs.getString("pro_image_url"))
                .build();
    }
}
