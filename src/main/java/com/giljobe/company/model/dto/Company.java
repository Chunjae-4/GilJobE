package com.giljobe.company.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Company {
	private String comNo;
	private String comName;
	private String comId;
	private String comPw;
	private String comPhone;
	private String comEmail;
	private String comBinNo;
}
