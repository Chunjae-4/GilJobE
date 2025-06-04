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
import com.giljobe.program.model.dto.Round;

public class RoundDao {
	
	private static RoundDao roundDao = new RoundDao();
	
	private Properties sql = new Properties();
    private PreparedStatement pstmt;
    private ResultSet rs;
    
    private RoundDao() {
    	String path = RoundDao.class.getResource("/sql/round.properties").getPath();
    	try (FileReader reader = new FileReader(path)) {
            sql.load(reader);
        } catch (IOException e) {
            LoggerUtil.error("RoundDao exception: " + e.getMessage(), e);
        }
    }
    public static RoundDao getInstance() {
    	return roundDao;
    }
    
    public Round selectRoundByNo(Connection conn, int roundNo) {
        Round round = null;
        try {
            pstmt = conn.prepareStatement(sql.getProperty("selectRoundByNo"));
            pstmt.setInt(1, roundNo);

            rs = pstmt.executeQuery();
            if (rs.next()) {
                round = new Round();
                round.setRoundNo(rs.getInt("round_no"));
                round.setRoundCount(rs.getInt("round_count"));
                round.setRoundDate(rs.getDate("round_date"));
                round.setRoundMaxPeople(rs.getInt("round_max_people"));
                round.setRoundPrice(rs.getInt("round_price"));
                round.setDetailLocation(rs.getString("detail_location"));
                round.setGoal(rs.getString("goal"));
                round.setNote(rs.getString("note"));
                round.setSummary(rs.getString("summary"));
                round.setDetail(rs.getString("detail"));
                round.setProNoRef(rs.getInt("pro_no"));

                // 필요하다면 더 필드 추가
            }
        } catch (SQLException e) {
            LoggerUtil.error(e.getMessage(), e);
        } finally {
            close(rs);
            close(pstmt);
        }

        return round;
    }

    public List<Round> selectRoundsByProgramNoOrderedByDate(Connection conn, int proNo) {
        List<Round> rounds = new ArrayList<>();
        try {
            pstmt = conn.prepareStatement(sql.getProperty("selectRoundsByProgramNoOrderedByDate"));
            pstmt.setInt(1, proNo);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                rounds.add(getRound(rs));
            }
        } catch (SQLException e) {
            LoggerUtil.error("selectRoundsByProgramNoOrderedByDate 오류: " + e.getMessage(), e);
        } finally {
            close(rs);
            close(pstmt);
        }
        return rounds;
    }

    public int updateRoundCount(Connection conn, int roundNo, int newCount) {
        int result = 0;
        try {
            pstmt = conn.prepareStatement(sql.getProperty("updateRoundCount"));
            pstmt.setInt(1, newCount);
            pstmt.setInt(2, roundNo);
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            LoggerUtil.error("updateRoundCount 오류: " + e.getMessage(), e);
        } finally {
            close(pstmt);
        }
        return result;
    }

	
	public List<Round> selectRoundsByProgramNo(Connection conn, int proNo) {
        List<Round> rounds = new ArrayList<>();
        
        try {
            pstmt = conn.prepareStatement(sql.getProperty("selectRoundsByProgramNo"));
            pstmt.setInt(1, proNo);
            rs = pstmt.executeQuery();
            while (rs.next()) {
            	Round r = getRound(rs);
            	// 근데 여기에서, r 에다가 ProTime의 List 를 넣어줘야되지 않나..? ProTime은 나중에.
            	rounds.add(r);
            }
        } catch (SQLException e) {
            LoggerUtil.error(e.getMessage(), e);
        } finally {
            close(rs);
            close(pstmt);
        }
        
        return rounds;
    }
	
	public int getNextRoundCount(Connection conn, int proNo) {
        int result=0;
        try {
            pstmt = conn.prepareStatement(sql.getProperty("getNextRoundCount"));
            pstmt.setInt(1, proNo);
            rs = pstmt.executeQuery();
            if (rs.next()) {
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
	
	public Round getLastRoundByProNo(Connection conn, int proNo) {
		try {
	    	pstmt = conn.prepareStatement(sql.getProperty("getLastRoundByProNo"));
	        pstmt.setInt(1, proNo);
	        rs = pstmt.executeQuery();
            if (rs.next()) {
            	return Round.builder()
	                    .roundNo(rs.getInt("round_no"))
	                    .roundDate(rs.getDate("round_date"))
	                    .roundMaxPeople(rs.getInt("round_max_people"))
	                    .roundPrice(rs.getInt("round_price"))
	                    .detailLocation(rs.getString("detail_location"))
	                    .goal(rs.getString("goal"))
	                    .summary(rs.getString("summary"))
	                    .detail(rs.getString("detail"))
	                    .note(rs.getString("note"))
	                    .proNoRef(rs.getInt("pro_no"))
	                    .roundCount(rs.getInt("round_count"))
	                    .build();
            }
        } catch (SQLException e) {
	        e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
        }
        
	    return null;
	}
	
	public int deleteRound(Connection conn, int roundNo) {
		int result = 0;
	    try {
	        pstmt = conn.prepareStatement(sql.getProperty("deleteRound"));
	        pstmt.setInt(1, roundNo);
	        result = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        LoggerUtil.error("RoundDao.updateRound 오류: " + e.getMessage(), e);
	    } finally {
            close(rs);
	        close(pstmt);
	    }
	    return result;
	}

	
	public int updateRound(Connection conn, Round round) {
	    int result = 0;
	    try {
	        pstmt = conn.prepareStatement(sql.getProperty("updateRound"));
	        pstmt.setDate(1, round.getRoundDate());
	        pstmt.setInt(2, round.getRoundMaxPeople());
	        pstmt.setInt(3, round.getRoundPrice());
	        pstmt.setString(4, round.getDetailLocation());
	        pstmt.setString(5, round.getGoal());
	        pstmt.setString(6, round.getNote());
	        pstmt.setString(7, round.getSummary());
	        pstmt.setString(8, round.getDetail());
	        pstmt.setInt(9, round.getRoundNo());

	        result = pstmt.executeUpdate();
	    } catch (SQLException e) {
	        LoggerUtil.error("RoundDao.updateRound 오류: " + e.getMessage(), e);
	    } finally {
            close(rs);
	        close(pstmt);
	    }
	    return result;
	}

	
	
	public int insertRound(Connection conn, Round round) {
	    int result = 0;
	    try {
	        pstmt = conn.prepareStatement(sql.getProperty("insertRound"));
	        pstmt.setInt(1, round.getRoundCount());
	        pstmt.setDate(2, round.getRoundDate());
	        pstmt.setInt(3, round.getRoundMaxPeople());
	        pstmt.setInt(4, round.getRoundPrice());
	        pstmt.setString(5, round.getDetailLocation());
	        pstmt.setString(6, round.getGoal());
	        pstmt.setString(7, round.getNote());
	        pstmt.setString(8, round.getSummary());
	        pstmt.setString(9, round.getDetail());
	        pstmt.setInt(10, round.getProNoRef());

	        result = pstmt.executeUpdate();
	        close(pstmt);

	        if (result > 0) {
	            pstmt = conn.prepareStatement(sql.getProperty("getCurrRoundNo"));
	            rs = pstmt.executeQuery();
	            if (rs.next()) {
	                round.setRoundNo(rs.getInt(1)); // DTO에 반영
	            }
	        }

	    } catch (SQLException e) {
	        throw new RuntimeException(e);
	    } finally {
	        close(rs);
	        close(pstmt);
	    }
	    return result;
	}

	
	
	public Round getRound(ResultSet rs) throws SQLException {
        return Round.builder()
                .roundNo(rs.getInt("round_no"))
                .roundCount(rs.getInt("round_count"))
                .roundDate(rs.getDate("round_date"))
                .roundMaxPeople(rs.getInt("round_max_people"))
                .roundPrice(rs.getInt("round_price"))
                .detailLocation(rs.getString("detail_location"))
                .goal(rs.getString("goal"))
                .note(rs.getString("note"))
                .summary(rs.getString("summary"))
                .detail(rs.getString("detail"))
                .proNoRef(rs.getInt("pro_no"))
                .build();
    }
}
