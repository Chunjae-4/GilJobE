package com.giljobe.program.model.dao;

import com.giljobe.common.JDBCTemplate;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

}
