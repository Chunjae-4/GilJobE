package com.giljobe.program.model.service;

import static com.giljobe.common.JDBCTemplate.close;
import static com.giljobe.common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.List;

import com.giljobe.program.model.dao.ProTimeDao;
import com.giljobe.program.model.dto.ProTime;



public class ProTimeService {

	private static final ProTimeService service = new ProTimeService();
    private ProTimeService() {}
    public static ProTimeService getInstance() {
        return service;
    }

    private ProTimeDao dao = ProTimeDao.getInstance();
    
    public List<ProTime> selectProTimesByRoundNo(int roundNo) {
        Connection conn = getConnection();
        List<ProTime> rounds = dao.selectProTimesByRoundNo(conn, roundNo);
        close(conn);
        return rounds;
    }
}
