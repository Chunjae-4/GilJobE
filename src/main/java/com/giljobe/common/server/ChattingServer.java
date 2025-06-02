package com.giljobe.common.server;

import com.giljobe.chatting.model.dto.Message;
import com.giljobe.common.LoggerUtil;
import com.giljobe.common.server.decoder.MessageDeSerializer;
import com.giljobe.common.server.encoder.MessageSerializer;
import com.google.gson.Gson;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
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
        sendMessage(clients, msg);
    }

    private void sendMessage(Set<Session> clients, Message data){
        for (Session client : clients) {
            try {
                LoggerUtil.debug("Chat Server sendMessage: " + data);
                client.getBasicRemote().sendText(data.toJson());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
