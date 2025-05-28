package com.giljobe.program.model.service;

import static com.giljobe.common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.List;

import com.giljobe.program.model.dao.ProgramDao;
import com.giljobe.program.model.dto.Program;

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
    
    public int getNextProNo() {
        Connection conn = getConnection();
        int nextProNo = dao.getNextProNo(conn);
        close(conn);
        return nextProNo;
    }
    
    public int insertProgram(Program program) {
        Connection conn = getConnection();
        int result = dao.insertProgram(conn, program);
        if (result > 0) {
            commit(conn);
        } else {
            rollback(conn);
        }
        close(conn);
        return result;
    }

    public List<Program> searchAllPrograms(int cPage, int numPerPage) {
        Connection conn = getConnection();
        List<Program> programList = dao.searchAllProgram(conn, cPage, numPerPage);
        close(conn);
        return programList;
    }

    public List<Program> searchProgramsInfo() {
        Connection conn = getConnection();
        List<Program> programList = dao.selectRandomRecommendedPrograms(conn);
        close(conn);
        return programList;
    }

    public Program selectProgramByNo(int proNo) {
        Connection conn = getConnection();
        Program program = ProgramDao.getInstance().selectProgramByNo(conn, proNo);
        close(conn);
        return program;
    }
    
	public List<Program> lovedProgramByUserNo(int userNo) {
		// TODO Auto-generated method stub
		Connection conn=getConnection();
		List<Program> programs = ProgramDao.getInstance().lovedProgramByUserNo(conn,userNo);
		close(conn);
		return programs;
	}
    public List<Program> searchProgramByTitleKeyword(String keyword){
        Connection conn=getConnection();
        List<Program> programs = ProgramDao.getInstance().searchProgramByTitleKeyword(conn,keyword);
        close(conn);
        return programs;
    }
    public List<Program> selectProgramsByComNo(int comNo){
    	Connection conn=getConnection();
        List<Program> programs = ProgramDao.getInstance().selectProgramsByCompany(conn,comNo);
        close(conn);
        return programs;
    }
}
