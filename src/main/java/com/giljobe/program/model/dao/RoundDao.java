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
            throw new RuntimeException(e);
        }
    }
    public static RoundDao getInstance() {
    	return roundDao;
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
            throw new RuntimeException(e);
        } finally {
            close(rs);
            close(pstmt);
        }
        
        return rounds;
    }
	
	private Round getRound(ResultSet rs) throws SQLException {
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
