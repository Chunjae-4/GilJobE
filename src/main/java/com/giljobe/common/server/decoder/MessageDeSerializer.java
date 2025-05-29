package com.giljobe.common.server.decoder;

import com.giljobe.chatting.model.dto.Message;
import com.google.gson.Gson;

import javax.websocket.DecodeException;
import javax.websocket.Decoder;
import javax.websocket.EndpointConfig;

public class MessageDeSerializer implements Decoder.Text<Message> {
    @Override
    public Message decode(String s) throws DecodeException {
        return new Gson().fromJson(s, Message.class);
    }

    @Override
    public boolean willDecode(String s) {
        return false;
    }

    @Override
    public void init(EndpointConfig endpointConfig) {

    }

    @Override
    public void destroy() {

    }
}
