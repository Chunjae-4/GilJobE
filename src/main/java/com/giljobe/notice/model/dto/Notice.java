package com.giljobe.notice.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Notice {
	private int noticeNo;
	private String noticeContent;
	private Date noticeDate;
	private String noticeTitle;
}
