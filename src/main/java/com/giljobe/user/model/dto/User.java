package com.giljobe.user.model.dto;

import java.util.List;

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
	private String userphone;
	private String userId;
	private String userPw;
	private String userLike; // Y/N?
	private int userBirth;
	private String userEmail;
	private String userNickName;
	private String userName;
	private int userRollNo;
	
	private List<QNA> qnas;
//	private List<Like> likes;
//	private List<Chat> chats;
//	private List<Application> application;

}
