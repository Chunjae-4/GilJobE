package com.giljobe.chatting.model.dto;

import com.google.gson.Gson;
import lombok.*;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Message {
    //Type: User, Admin, Company
    private String type;
    //Type에 따라서 sender 닉네임 저장해야할듯 (Company, User)
    private String sender;
    //receiver는 딱히 머가 없당
    private String receiver;
    //이건 메세지
    private String data;

    //이건 프로그램 넘버
    private int roomNo;

    public String toJson() {
        return new Gson().toJson(this);
    }
}
