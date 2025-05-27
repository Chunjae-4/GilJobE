package com.giljobe.program.model.dao;

import static com.giljobe.common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.giljobe.program.model.dto.ProTime;

public class ProTimeDao {

private static ProTimeDao proTimeDao = new ProTimeDao();
	
	private Properties sql = new Properties();
    private PreparedStatement pstmt;
    private ResultSet rs;
    
    private ProTimeDao() {
    	String path = ProTimeDao.class.getResource("/sql/protime.properties").getPath();
    	try (FileReader reader = new FileReader(path)) {
            sql.load(reader);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
    public static ProTimeDao getInstance() {
    	return proTimeDao;
    }
	
	public List<ProTime> selectProTimesByRoundNo(Connection conn, int roundNo) {
        List<ProTime> proTimes = new ArrayList<>();
        
        try {
            pstmt = conn.prepareStatement(sql.getProperty("selectProTimesByRoundNo"));
            pstmt.setInt(1, roundNo);
            rs = pstmt.executeQuery();
            while (rs.next()) {
            	ProTime pt = getProTime(rs);
            	// 근데 여기에서, r 에다가 ProTime의 List 를 넣어줘야되지 않나..? ProTime은 나중에.
            	proTimes.add(pt);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            close(rs);
            close(pstmt);
        }
        
        return proTimes;
    }
	
	public ProTime getProTime(ResultSet rs) throws SQLException {
        return ProTime.builder()
                .timeNo(rs.getInt("time_no"))
                .startTime(rs.getDate("start_time"))
                .endTime(rs.getDate("end_time"))
                .roundNoRef(rs.getInt("round_no"))
                .build();
    }
}
