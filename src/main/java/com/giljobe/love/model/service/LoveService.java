package com.giljobe.love.model.service;
import com.giljobe.love.model.dao.LoveDao;
import static com.giljobe.common.JDBCTemplate.*;

import java.sql.Connection;

public class LoveService {
    private static final LoveService service = new LoveService();
    private LoveService() {}
    public static LoveService getInstance() {
        return service;
    }

    private LoveDao dao = LoveDao.getInstance();

    public int countLoveByProgram(int proNo){
        Connection conn = getConnection();
        int programLikeCount = dao.countLoveByProgram(conn, proNo);
        close(conn);
        return programLikeCount;
    }
	public int removeLove(int proNo, int userNo) {
		
		Connection conn= getConnection();
		int result = dao.removelove(conn, proNo, userNo);
		close(conn);
		if(result>0) {
			//성공
			commit(conn);
		}else {
			//실패
			rollback(conn);
			close(conn);
		}
		return result;
	}

}
