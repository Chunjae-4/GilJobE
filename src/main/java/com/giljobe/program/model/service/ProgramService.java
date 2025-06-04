package com.giljobe.program.model.service;

import static com.giljobe.common.JDBCTemplate.close;
import static com.giljobe.common.JDBCTemplate.commit;
import static com.giljobe.common.JDBCTemplate.getConnection;
import static com.giljobe.common.JDBCTemplate.rollback;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletContext;

import com.giljobe.application.model.dao.ApplicationDao;
import com.giljobe.chatting.model.dao.ChatLogDao;
import com.giljobe.common.Constants;
import com.giljobe.love.model.dao.LoveDao;
import com.giljobe.program.model.dao.ProTimeDao;
import com.giljobe.program.model.dao.ProgramDao;
import com.giljobe.program.model.dao.RoundDao;
import com.giljobe.program.model.dto.ProTime;
import com.giljobe.program.model.dto.Program;
import com.giljobe.program.model.dto.Round;
import com.giljobe.qna.model.dao.QNADao;

public class ProgramService {
    //싱글톤
    private static final ProgramService service = new ProgramService();
    private ProgramService() {}
    public static ProgramService getInstance() {
        return service;
    }

    private ProgramDao dao = ProgramDao.getInstance();

    public List<Program> findAllForMap() {
    	Connection conn = getConnection();
        List<Program> programList = dao.findAllForMap(conn);
        close(conn);
    	return programList;
    }
    
    public int updateProgram(Program program) {
        Connection conn = getConnection();
        int result = dao.updateProgram(conn, program);
        if (result > 0) {
            commit(conn);
        } else {
            rollback(conn);
        }
        close(conn);
        return result;
    }

    
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
    
    public boolean deleteProgramWithAllData(int proNo, ServletContext context) {
        Connection conn = getConnection();
        boolean result = false;

        try {
            // 1. 해당 프로그램의 모든 회차 조회
            List<Round> rounds = RoundDao.getInstance().selectRoundsByProgramNo(conn, proNo);

            for (Round r : rounds) {
                int roundNo = r.getRoundNo();

                // 2. 각 회차의 ProTime 조회
                List<ProTime> proTimes = ProTimeDao.getInstance().selectProTimesByRoundNo(conn, roundNo);
                for (ProTime pt : proTimes) {
                    // 3. 각 ProTime의 신청 삭제
                    ApplicationDao.applicationDao().deleteByOnlyTimeNo(conn, pt.getTimeNo());
                }

                // 4. ProTime 삭제
                ProTimeDao.getInstance().deleteByRoundNo(conn, roundNo);
                // 5. Round 삭제
                RoundDao.getInstance().deleteRound(conn, roundNo);
            }
            
            // 6. 좋아요 삭제
            LoveDao.getInstance().deleteByProgramNo(conn, proNo);

            // 7. QNA 삭제
            QNADao.qnaDao().deleteByProgramNo(conn, proNo);

            // 8. Chat 삭제
            ChatLogDao.getInstance().deleteByProgramNo(conn, proNo);

            // 9. 이미지 및 폴더 삭제
            deleteProgramImageAndFolder(proNo, context); // 아래에 정의한 메소드 사용
            
            // 10. Program 삭제
            int deleted = ProgramDao.getInstance().deleteProgram(conn, proNo);

            if (deleted > 0) {
                commit(conn);
                result = true;
            } else {
                rollback(conn);
            }
        } catch (Exception e) {
            e.printStackTrace();
            rollback(conn);
        } finally {
            close(conn);
        }

        return result;
    }
    
    public void updateProgramImagePath(int proNo, String newPath) {
        Connection conn = getConnection();
        try {
            int result = dao.updateProgramImagePath(conn, proNo, newPath);
            if (result > 0) commit(conn);
            else rollback(conn);
        } catch (Exception e) {
            e.printStackTrace();
            rollback(conn);
        } finally {
            close(conn);
        }
    }

    private void deleteProgramImageAndFolder(int proNo, ServletContext context) {
        // 회사 번호는 프로그램 번호만으로 알 수 없으므로 Program 객체에서 가져와야 함
    	Program program = selectProgramByNo(proNo);
        int companyNo = program.getComNoRef();
    	// basePath는 실제 프로젝트에서 사용하는 이미지 저장 경로
        // Constants 사용 + 실제 절대 경로 획득
        String basePath = context.getRealPath(Constants.DEFAULT_UPLOAD_PATH);
        File programFolder = new File(basePath + companyNo  + "/" + proNo);

        deleteDirectory(programFolder); // 하위 파일 및 폴더 모두 삭제
    }

    private void deleteDirectory(File folder) {
        if (folder.exists()) {
            File[] files = folder.listFiles(); // 폴더 안의 모든 파일/폴더 가져오기
            if (files != null) {
                for (File f : files) {
                    if (f.isDirectory()) {
                        deleteDirectory(f); // 폴더면 재귀 호출로 내부 먼저 삭제
                    } else {
                        f.delete(); // 파일이면 바로 삭제 (이미지 포함)
                    }
                }
            }
            folder.delete(); // 하위 다 삭제한 후 최종 폴더 삭제
        }
    }

}
