package com.giljobe.application.model.dto;

import java.sql.Date;

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
	private Date startTime;
	private Date endTime;
	private int proNo;
	private int timeNo;
	
}
