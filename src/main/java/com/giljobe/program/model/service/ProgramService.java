package com.giljobe.program.model.service;

import com.giljobe.program.model.dao.ProgramDao;

import java.sql.Connection;

import static com.giljobe.common.JDBCTemplate.close;
import static com.giljobe.common.JDBCTemplate.getConnection;

public class ProgramService {
    //싱글톤
    private static final ProgramService service = new ProgramService();
    private ProgramService() {}
    public static ProgramService getInstance() {
        return service;
    }

    private ProgramDao dao = ProgramDao.getInstance();

    public int programCount() {
        Connection conn = getConnection();
        int totalCount = dao.programCount(conn);
        close(conn);
        return totalCount;
    }

}
