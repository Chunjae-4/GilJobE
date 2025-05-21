package com.giljobe.chat.model.dto;

import java.sql.Date;

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
	private int userNoRef;
	private int proNoRef;
	private int comNoRef;
	private String chatContent;
	private Date chatDateTime;
	
}
