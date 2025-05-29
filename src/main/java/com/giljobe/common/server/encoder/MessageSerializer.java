package com.giljobe.common.server.encoder;

import com.giljobe.chatting.model.dto.Message;
import com.google.gson.Gson;

import javax.websocket.EncodeException;
import javax.websocket.Encoder;
import javax.websocket.EndpointConfig;

public class MessageSerializer implements Encoder.Text<Message> {
    @Override
    public String encode(Message message) throws EncodeException {
        return new Gson().toJson(message);
    }

    @Override
    public void init(EndpointConfig endpointConfig) {

    }

    @Override
    public void destroy() {

    }
}
