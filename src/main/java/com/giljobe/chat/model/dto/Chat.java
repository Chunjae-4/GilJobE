package com.giljobe.chat.model.dto;

import java.sql.Date;

import com.giljobe.company.model.dto.Company;
import com.giljobe.program.model.dto.Program;
import com.giljobe.user.model.dto.User;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Chat {
	private int chatNo;
	private User userNoRef;
	private Program proNoRef;
	private Company comNoRef;
	private String chatContent;
	private Date chatDateTime;
	
}
