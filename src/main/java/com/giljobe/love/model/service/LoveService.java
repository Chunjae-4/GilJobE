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

}
