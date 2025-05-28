package com.giljobe.program.model.service;

import static com.giljobe.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.List;

import com.giljobe.program.model.dao.RoundDao;
import com.giljobe.program.model.dto.Round;

public class RoundService {
	private static final RoundService service = new RoundService();
    private RoundService() {}
    public static RoundService getInstance() {
        return service;
    }

    private RoundDao dao = RoundDao.getInstance();
    
    public List<Round> selectRoundsByProgramNo(int proNo) {
        Connection conn = getConnection();
        List<Round> rounds = dao.selectRoundsByProgramNo(conn, proNo);
        close(conn);
        return rounds;
    }
    
    public int insertRound(Round round) {
        Connection conn = getConnection();
        int result = dao.insertRound(conn, round);
        if (result > 0) commit(conn);
        else rollback(conn);
        close(conn);
        return result;
    }
    
    public Round getLastRoundByProNo(int proNo) {
        Connection conn = getConnection();
        Round round = dao.getLastRoundByProNo(conn, proNo);
        close(conn);
        return round;
    }

    
    public int getNextRoundCount(int proNo) {
        Connection conn = getConnection();
        int result = dao.getNextRoundCount(conn, proNo);
        close(conn);
        return result;
    }
    
    
    
    
    
}
