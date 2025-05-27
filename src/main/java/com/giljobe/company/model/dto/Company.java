package com.giljobe.company.model.dto;

import java.util.List;

import com.giljobe.chat.model.dto.Chat;
import com.giljobe.program.model.dto.Program;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Company {
	private int comNo;
	private String comName;
	private String comId;
	private String comPw;
	private String comPhone;
	private String comEmail;
	private int comBinNo;
	
	private List<Chat> chats;
	private List<Program> programs;
}
