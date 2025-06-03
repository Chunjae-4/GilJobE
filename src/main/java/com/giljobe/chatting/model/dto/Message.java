package com.giljobe.chatting.model.dto;

import com.google.gson.Gson;
import lombok.*;

import java.sql.Timestamp;
import java.util.Date;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Message {
    //Type: User, Admin, Company
    private String senderType;
    //없으면 -1
    private int userNo;
    private int comNo;
    //Type에 따라서 sender 닉네임 저장해야할듯 (Company, User)
    private String sender;
    //receiver는 딱히 머가 없당
    private String receiver;
    //이건 메세지
    private String data;

    //이건 프로그램 넘버
    private int proNo;
    private Timestamp dateTime;
    public String toJson() {
        return new Gson().toJson(this);
    }
}
