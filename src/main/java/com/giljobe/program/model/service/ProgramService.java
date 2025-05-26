package com.giljobe.program.model.service;

import com.giljobe.program.model.dao.ProgramDao;
import com.giljobe.program.model.dto.Program;

import java.sql.Connection;
import java.util.List;

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

    public List<Program> searchAllPrograms(int cPage, int numPerPage) {
        Connection conn = getConnection();
        List<Program> programList = dao.searchAllProgram(conn, cPage, numPerPage);
        close(conn);
        return programList;
    }
    
    public Program selectProgramByNo(int proNo) {
        Connection conn = getConnection();
        Program program = ProgramDao.getInstance().selectProgramByNo(conn, proNo);
        close(conn);
        return program;
    }
    
    
}
