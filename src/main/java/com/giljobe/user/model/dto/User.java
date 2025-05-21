package com.giljobe.user.model.dto;

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
	private String userBirth;
//	private 프로그램 
	private String userEmail;
	private String userNickName;
	private String userName;
		
	
}
