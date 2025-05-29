package com.giljobe.chatting;

import com.giljobe.common.LoggerUtil;

import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value = "/chatting", encoders = {}, decoders =  {})
public class ChattingServer {
    @OnOpen
    public void onOpen(Session session) {
        LoggerUtil.start("Chat Server onOpen");

    }
}
