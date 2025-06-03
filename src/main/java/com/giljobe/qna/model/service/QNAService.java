package com.giljobe.qna.model.service;

import java.sql.Connection;
import java.util.List;

import static com.giljobe.common.JDBCTemplate.*;
import com.giljobe.qna.model.dao.QNADao;
import com.giljobe.qna.model.dto.QNA;

public class QNAService {
	
	private static final QNAService SERVICE = new QNAService();
	private QNAService() {}
	public static QNAService qnaService() {
		return SERVICE;
	}
	private QNADao qnadao = QNADao.qnaDao();
	private Connection conn;
	
	public List<QNA> searchQNAByUserNo(int userNo) {
		// TODO Auto-generated method stub
		conn=getConnection();
		List<QNA> qnas = qnadao.searchQNAByUserNo(conn,userNo);
		close(conn);
		return qnas;
	}	
	
	public List<QNA> searchQNAByProNo(int proNo) {
        Connection conn = getConnection();
        List<QNA> result = qnadao.searchQNAByProNo(conn, proNo);
        close(conn);
        return result;
    }
    public List<QNA> searchQnaByComNo(int comNo) {
        Connection conn = getConnection();
        List<QNA> result = qnadao.searchQnaByComNo(conn, comNo);
        close(conn);
        return result;
    }

    public int insertQna(QNA qna) {
        Connection conn = getConnection();
        int result = qnadao.insertQna(conn, qna);
        if (result > 0) commit(conn); else rollback(conn);
        close(conn);
        return result;
    }

    public int deleteQnaByNo(int qnaNo) {
        Connection conn = getConnection();
        int result = qnadao.deleteQnaByNo(conn, qnaNo);
        if (result > 0) commit(conn); else rollback(conn);
        close(conn);
        return result;
    }

    public int updateAnswer(int qnaNo, String answer) {
        Connection conn = getConnection();
        int result = qnadao.updateAnswer(conn, qnaNo, answer);
        if (result > 0) commit(conn); else rollback(conn);
        close(conn);
        return result;
    }

    public int deleteAnswer(int qnaNo) {
        Connection conn = getConnection();
        int result = qnadao.updateAnswer(conn, qnaNo, null); // null 처리로 삭제
        if (result > 0) commit(conn); else rollback(conn);
        close(conn);
        return result;
    }
	
}
