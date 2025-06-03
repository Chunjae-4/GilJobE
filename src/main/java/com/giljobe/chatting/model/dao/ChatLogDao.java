package com.giljobe.chatting.model.dao;

import com.giljobe.chatting.model.dto.ChatLog;
import com.giljobe.chatting.model.dto.Message;
import com.giljobe.common.LoggerUtil;
import com.giljobe.company.model.service.CompanyService;
import com.giljobe.user.model.service.UserService;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import static com.giljobe.common.JDBCTemplate.close;

public class ChatLogDao {
    private static ChatLogDao chatLogDao = new ChatLogDao();

    private Properties sql = new Properties();
    private PreparedStatement pstmt;
    private ResultSet rs;

    private ChatLogDao() {
        String path = ChatLogDao.class.getResource("/sql/chat.properties").getPath();
        try (FileReader reader = new FileReader(path)) {
            sql.load(reader);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public static ChatLogDao getInstance() {
        return chatLogDao;
    }

    //한번에 저장
    public int insertChatLog(Connection conn, ChatLog c) {
        int result = 0;
        try {
            pstmt = conn.prepareStatement(sql.getProperty("insertChat"));
            pstmt.setInt(1, c.getUserNo());
            pstmt.setInt(2, c.getProNo());
            pstmt.setInt(3, c.getComNo());
            pstmt.setString(4, c.getChatContent());

            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            LoggerUtil.error(e.getMessage(), e);
        } finally {
            close(pstmt);
        }
        LoggerUtil.debug("ChatLogDao result: " + result);
        return result;
    }

    //TODO: 룸넘버의 경우 proNo로 처리. proNo에 따라서 시간 순으로 정렬된 Chatting 리스트를 불러오도록 처리
    public List<Message> selectChatsByProgramNo(Connection conn, int proNo){
        List<Message> messageList = new ArrayList<>();
        try {
            pstmt = conn.prepareStatement(sql.getProperty("selectChatsByProgramNo"));
            pstmt.setInt(1, proNo);

            rs = pstmt.executeQuery();
            while (rs.next()) {
                ChatLog c = getChatLog(rs);
                Message m = chatLogToMessage(c);
                messageList.add(m);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
        }
        return messageList;
    }

    public Message chatLogToMessage(ChatLog c){
        String senderType;
        String nickName;

        if (c.getUserNo() == 1) {
            senderType = "Admin";
            nickName = c.getUserNickName();
        } else if (c.getUserNo() > 0) {
            senderType = "User";
            nickName = c.getUserNickName();
        } else if (c.getComNo() > 0) {
            senderType = "Company";
            nickName = c.getComName();
        } else {
            senderType = "Unknown";
            nickName = "알 수 없음";
        }
        return Message.builder()
                .senderType(senderType)
                .sender(nickName)
                .userNo(c.getUserNo())
                .comNo(c.getComNo())
                .data(c.getChatContent())
                .proNo(c.getProNo())
                .dateTime(c.getChatDateTime())
                .build();
    }

    public ChatLog getChatLog(ResultSet rs) throws SQLException {

        return ChatLog.builder()
                .userNo(rs.getInt("user_no"))
                .proNo(rs.getInt("pro_no"))
                .comNo(rs.getInt("com_no"))
                .chatContent(rs.getString("chat_content"))
                .userNickName(rs.getString("sender_nick"))
                .comName(rs.getString("sender_com"))
                .chatDateTime(rs.getTimestamp("chat_datetime"))
                .build();
    }


}
