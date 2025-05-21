package com.giljobe.notice.dto;

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
	private int notiNo;
	private String notiDetail;
	private Date notiDate;
	private String notiTitle;
}
