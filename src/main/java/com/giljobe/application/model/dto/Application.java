package com.giljobe.application.model.dto;

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
	private int proNoRef;
	private int userNoRef;
	private boolean applyState;
}
