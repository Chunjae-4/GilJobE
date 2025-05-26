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
	
	
	
}
