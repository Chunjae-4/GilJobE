package com.giljobe.qna.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import static com.giljobe.common.JDBCTemplate.*;

import com.giljobe.program.model.dao.ProgramDao;
import com.giljobe.qna.model.dto.QNA;
import com.giljobe.user.model.dao.UserDao;

public class QNADao {
	
	private static final QNADao DAO = new QNADao();
	public static QNADao qnaDao() {
		return DAO;
	}
	private PreparedStatement pstmt;
	private ResultSet rs;
	private Properties sql = new Properties();
	
	private QNADao() {
		
		String path = QNADao.class.getResource("/sql/qna.properties").getPath();
		try {
			FileReader fr = new FileReader(path);
			sql.load(fr);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	public List<QNA> searchQNAByUserNo(Connection conn, int userNo) {
		// TODO Auto-generated method stub
		List<QNA> qnas= new ArrayList<QNA>();
		try {
			pstmt=conn.prepareStatement(sql.getProperty("searchQNAByUserNo"));
			pstmt.setInt(1, userNo);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				qnas.add(getQNA(rs));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
	
		return qnas;
	}

	private QNA getQNA(ResultSet rs) throws SQLException {
		
		
		return QNA.builder()
					.qnaNo(rs.getInt("qna_no"))
					.qnaContent(rs.getString("qna_content"))
					.userNoRef(rs.getInt("user_no"))
					.proNoRef(rs.getInt("pro_no"))
					.answer(rs.getString("answer"))
					.build();
	}
	
	
}
