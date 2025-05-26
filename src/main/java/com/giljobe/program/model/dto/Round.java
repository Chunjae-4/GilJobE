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
	private Date roundDate;
	private int roundMaxPeople;
	private int roundPrice;
	private String detailLocation;
	private String goal;
	private String note;
	private String summary;
	private String detail;
	private int proNoRef;
	// 프로그램 PK 값에다가 + Ref
}
