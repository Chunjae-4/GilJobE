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
		if(result>0) {
			//성공
			commit(conn);
		}else {
			//실패
			rollback(conn);
		}
		close(conn);
		return result;
	}
	
	public boolean hasLoved(int userNo, int proNo) {
	    Connection conn = getConnection();
	    boolean result = dao.hasLoved(conn, userNo, proNo);
	    close(conn);
	    return result;
	}

	public int addLove(int proNo, int userNo) {
	    Connection conn = getConnection();
	    int result = dao.addLove(conn, proNo, userNo);
	    if (result > 0) commit(conn);
	    else rollback(conn);
	    close(conn);
	    return result;
	}


}
