package com.giljobe.chatting.model.service;

import com.giljobe.chatting.model.dao.ChatLogDao;
import com.giljobe.chatting.model.dto.ChatLog;
import com.giljobe.chatting.model.dto.Message;
import com.giljobe.common.LoggerUtil;

import java.sql.Connection;
import java.util.List;

import static com.giljobe.common.JDBCTemplate.*;
import static com.giljobe.common.JDBCTemplate.close;

public class ChatLogService {
    private static final ChatLogService service = new ChatLogService();
    private ChatLogService() {}
    public static ChatLogService getInstance() {
        return service;
    }

    private ChatLogDao dao = ChatLogDao.getInstance();

    public int insertChatLog(ChatLog c) {
        Connection conn = getConnection();
        int result = dao.insertChatLog(conn, c);
        LoggerUtil.debug("ChatLogService insertChatLog result: " + result);
        if(result>0) commit(conn);
        else rollback(conn);
        close(conn);
        return result;
    }

    public List<Message> selectChatsByProgramNo(int proNo) {
        Connection conn = getConnection();
        List<Message> messageList = dao.selectChatsByProgramNo(conn, proNo);
        LoggerUtil.debug("ChatLogService selectChatsByProgramNo messageList result: " + messageList);
        close(conn);
        return messageList;
    }

}
