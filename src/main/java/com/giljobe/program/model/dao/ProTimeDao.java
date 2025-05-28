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

import com.giljobe.common.LoggerUtil;
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
            LoggerUtil.error(e.getMessage(), e);
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
            LoggerUtil.error(e.getMessage(), e);
        } finally {
            close(rs);
            close(pstmt);
        }
        
        return proTimes;
    }
	
	//insertProTimes, s 가 붙어있음
	public int insertProTimes(Connection conn, List<ProTime> list) {
	    int result = 0;
	    try {
	    	// query에는 s 없이 그냥. Batch로 할거니까.
	        pstmt = conn.prepareStatement(sql.getProperty("insertProTime"));
	        for (ProTime pt : list) {
	            pstmt.setDate(1, new java.sql.Date(pt.getStartTime().getTime()));
	            pstmt.setDate(2, new java.sql.Date(pt.getEndTime().getTime()));
	            pstmt.setInt(3, pt.getRoundNoRef());
	            pstmt.addBatch();
	        }
	        int[] batchResult = pstmt.executeBatch();
	        for (int r : batchResult) result += r;

	    } catch (SQLException e) {
	        throw new RuntimeException(e);
	    } finally {
	        close(pstmt);
	    }
	    return result;
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
