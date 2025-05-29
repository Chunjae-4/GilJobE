package com.giljobe.chatting.model.dto;

import com.google.gson.Gson;
import lombok.*;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Message {
    private String type;
    private String sender;
    private String receiver;
    private String data;
    private String room;

    public String toJson() {
        return new Gson().toJson(this);
    }
}
