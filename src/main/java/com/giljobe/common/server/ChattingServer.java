package com.giljobe.common.server;

import com.giljobe.chatting.model.dto.ChatLog;
import com.giljobe.chatting.model.dto.Message;
import com.giljobe.chatting.model.service.ChatLogService;
import com.giljobe.common.LoggerUtil;
import com.giljobe.common.server.decoder.MessageDeSerializer;
import com.giljobe.common.server.encoder.MessageSerializer;
import com.giljobe.notice.model.dto.Notice;
import com.giljobe.notice.model.service.NoticeService;
import com.google.gson.Gson;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.List;
import java.util.Set;
import java.util.logging.Logger;

@ServerEndpoint(value = "/program/detail", encoders = {MessageSerializer.class}, decoders =  {MessageDeSerializer.class})
public class ChattingServer {
    @OnOpen
    public void onOpen(Session session) {
        LoggerUtil.start("Chat Server onOpen");
        LoggerUtil.debug("Chat Server session: " + session);

    }
    @OnClose
    public void onClose(Session session) {
        LoggerUtil.end("Chat Server onClose");
    }

    @OnMessage
    public void onMessage(Session session, String data) {
        Set<Session> clients = session.getOpenSessions();
        Message msg = new Gson().fromJson(data, Message.class);
        LoggerUtil.debug("Chat Server onMessage: " + msg);
        ChatLog chatLog = null;
        //getSenderType == Init -> (proNo를 받아서 쏴줌? )Data load, send
        if (msg.getSenderType().equals("Init")){
            session.getUserProperties().put("proNo", msg.getProNo());
            List<Message> messageList = loadMessages(msg.getProNo());
            sendMessages(session.getOpenSessions(), messageList, msg.getProNo());
        //else getSenderType == Admin Member Company 등등등 Data insert
        }else if (msg.getSenderType().equals("Admin")
                || msg.getSenderType().equals("User")
                || msg.getSenderType().equals("Company")){
            chatLog = ChatLog.builder()
                    .userNo(msg.getUserNo())
                    .proNo(msg.getProNo())
                    .comNo(msg.getComNo())
                    .chatContent(msg.getData())
                    .build();

            int result = ChatLogService.getInstance().insertChatLog(chatLog);
            //success
            if (result > 0) {
                sendMessage(clients, msg);
                //fail
            } else {
                //흠.
            }
        }


    }

    private List<Message> loadMessages(int proNo) {
        return ChatLogService.getInstance().selectChatsByProgramNo(proNo);
    }

    private void sendMessage(Set<Session> clients, Message data) {
        for (Session client : clients) {
            Object roomAttr = client.getUserProperties().get("proNo");

            if (roomAttr != null && roomAttr.equals(data.getProNo())) {
                try {
                    client.getBasicRemote().sendText(data.toJson());
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private void sendMessages(Set<Session> clients, List<Message> messageList, int targetProNo) {
        for (Session client : clients) {
            Object roomAttr = client.getUserProperties().get("proNo");

            // 유효한 proNo 세션 속성이 있고, 일치하는 경우에만 메시지 전송
            if (roomAttr instanceof Integer && (int) roomAttr == targetProNo) {
                for (Message message : messageList) {
                    try {
                        client.getBasicRemote().sendText(message.toJson());
                    } catch (IOException e) {
                        e.printStackTrace(); // 또는 로깅
                    }
                }
            }
        }
    }
}
