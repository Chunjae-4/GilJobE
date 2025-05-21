package com.giljobe.program.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Document {
	private int proNoRef;
	private int roundNoRef;
	private int sessionNoRef;
	// 프로그램 PK 값에다가 + Ref
	
	private int docNo;
	private String docGoal;
	private String docNote;
	private String docSummary;
	private String docExplain;
	
}
