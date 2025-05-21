package com.giljobe.qna.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class QNA {

	private int inqNo;
	private String inqDetail;
	
	private int userRef;
	private int proRef;
	
}
