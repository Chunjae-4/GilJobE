package com.giljobe.qna.model.dto;

import com.giljobe.program.model.dto.Program;
import com.giljobe.user.model.dto.User;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class QNA {

	private int qnaNo;
	private String qnaContent;
	
	private int userNoRef;
	private int proNoRef;
	private String answer;
	
}
