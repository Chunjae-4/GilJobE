package com.giljobe.application.model.dto;

import java.sql.Date;
import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ApplicationProgram {
	
	private String proName;
	private int roundCount;
	private Date roundDate;
	private Timestamp startTime;
	private Timestamp endTime;
	private int proNo;
	private int timeNo;
	
}
