package com.giljobe.chatting.model.dto;

import lombok.*;

import java.sql.Date;
import java.sql.Timestamp;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ChatLog {
    private int chatNo;
    private int userNo;
    private int proNo;
    private int comNo;
    private String chatContent;
    private Timestamp chatDateTime;
    private String userNickName;
    private String comName;
}
