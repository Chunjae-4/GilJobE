package com.giljobe.application.model.dto;

import com.giljobe.program.model.dto.ProTime;
import com.giljobe.user.model.dto.User;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Application {
	private int appNo;
	private int timeNoRef;
	private int userNoRef;
	private boolean applyState;
}
