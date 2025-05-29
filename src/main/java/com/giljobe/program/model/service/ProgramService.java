package com.giljobe.program.model.service;

import static com.giljobe.common.JDBCTemplate.close;
import static com.giljobe.common.JDBCTemplate.commit;
import static com.giljobe.common.JDBCTemplate.getConnection;
import static com.giljobe.common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.giljobe.program.model.dao.ProTimeDao;
import com.giljobe.program.model.dao.ProgramDao;
import com.giljobe.program.model.dao.RoundDao;
import com.giljobe.program.model.dto.ProTime;
import com.giljobe.program.model.dto.Program;
import com.giljobe.program.model.dto.Round;

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

    public int countProgramByTitleKeyword(String keyword) {
        Connection conn = getConnection();
        int totalCount = dao.countProgramByTitleKeyword(conn, keyword);
        close(conn);
        return totalCount;
    }

    public int countProgramListByCategory(String proCategory) {
        Connection conn = getConnection();
        int totalCount = dao.countProgramListByCategory(conn, proCategory);
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
    
    public boolean insertProgramWithRoundAndProTimes(Program p, Round r, List<ProTime> pts) {
        Connection conn = getConnection();
        boolean result = false;
        try {
            // 1. Program insert
            int resultP = dao.insertProgram(conn, p);
            if (resultP == 0) throw new SQLException("Program insert 실패");
            
            // 2. Round insert (proNo 넣기)
            r.setProNoRef(p.getProNo());
            int resultR = RoundDao.getInstance().insertRound(conn, r);
            if (resultR == 0) throw new SQLException("Round insert 실패");
            
            
            // 3. ProTime insert (roundNo 넣기)
            for (ProTime pt : pts) {
                pt.setRoundNoRef(r.getRoundNo());
            }
            int resultPT = ProTimeDao.getInstance().insertProTimes(conn, pts);
            if (resultPT == 0) throw new SQLException("ProTime insert 실패");
            
            commit(conn);
            result=true;
        } catch (Exception e) {
            rollback(conn);
            throw new RuntimeException("트랜잭션 전체 실패", e);
        } finally {
            close(conn);
        }
        return result;
    }

    public List<Program> searchAllPrograms(int cPage, int numPerPage) {
        Connection conn = getConnection();
        List<Program> programList = dao.searchAllProgram(conn, cPage, numPerPage);
        close(conn);
        return programList;
    }
    public List<Program> searchProgramListByCategory(String proCategory, int cPage, int numPerPage) {
        Connection conn = getConnection();
        List<Program> programList = dao.searchProgramListByCategory(conn, proCategory, cPage, numPerPage);
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
    public List<Program> searchProgramByTitleKeyword(String keyword, int cPage, int numPerPage){
        Connection conn=getConnection();
        List<Program> programs = ProgramDao.getInstance().searchProgramByTitleKeyword(conn,keyword, cPage, numPerPage);
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
