package com.giljobe.program.model.service;

import static com.giljobe.common.JDBCTemplate.close;
import static com.giljobe.common.JDBCTemplate.commit;
import static com.giljobe.common.JDBCTemplate.getConnection;
import static com.giljobe.common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.giljobe.program.model.dao.ProTimeDao;
import com.giljobe.program.model.dao.RoundDao;
import com.giljobe.program.model.dto.ProTime;
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
    
    public boolean insertRoundWithProTimes(Round round, List<ProTime> proTimes) {
        Connection conn = getConnection();
        boolean result = false;

        try {
            // 1. Round 삽입
            int resultR = dao.insertRound(conn, round);
            if (resultR == 0) throw new SQLException("Round 삽입 실패");

            // 2. ProTime에 roundNo 주입
            int roundNo = round.getRoundNo();
            for (ProTime pt : proTimes) {
                pt.setRoundNoRef(roundNo);
            }

            // 3. ProTime 삽입
            int resultPT = ProTimeDao.getInstance().insertProTimes(conn, proTimes);
            if (resultPT == 0) throw new SQLException("ProTime 삽입 실패");

            commit(conn);
            result = true;
        } catch (Exception e) {
            rollback(conn);
            throw new RuntimeException("회차 등록 트랜잭션 실패", e);
        } finally {
            close(conn);
        }

        return result;
    }
    
    
    
}
