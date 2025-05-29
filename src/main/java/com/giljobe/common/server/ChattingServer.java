package com.giljobe.common.server;

import com.giljobe.common.LoggerUtil;
import com.giljobe.common.server.decoder.MessageDeSerializer;
import com.giljobe.common.server.encoder.MessageSerializer;

import javax.websocket.OnClose;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value = "/chatting", encoders = {MessageSerializer.class}, decoders =  {MessageDeSerializer.class})
public class ChattingServer {
    @OnOpen
    public void onOpen(Session session) {
        LoggerUtil.start("Chat Server onOpen");

    }
    @OnClose
    public void onClose(Session session) {
        LoggerUtil.end("Chat Server onClose");
    }
}
