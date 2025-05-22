package com.giljobe.program.model.dto;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Round {
	
	private int roundNo;
	private Date roundStartDate;
	private Date roundEndDate;
	// java.sql.Date - sql 이 맞았던 거 같은데, 맞겠죠?
	
	private int roundSesCount;
	
	private int proNoRef;
	// 프로그램 PK 값에다가 + Ref
	private List<ProSession> sessions;
}
