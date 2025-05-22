package com.giljobe.user.model.dto;

import java.util.List;

import com.giljobe.application.model.dto.Application;
import com.giljobe.chat.model.dto.Chat;
import com.giljobe.like.model.dto.Love;
import com.giljobe.qna.model.dto.QNA;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class User {

	private int userNo;
	private int userPhone;
	private String userId;
	private String userPw;
	private int userBirth; // 8자리
	private String userEmail;
	private String userNickName;
	private String userName;
	private int userRoleNo;
	
	private List<QNA> qnas;
	private List<Love> likes;
	private List<Chat> chats;
	private List<Application> applications;

}
