package com.giljobe.program.model.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Session {
	private int proNoRef;
	private int roundNoRef;
	// 프로그램 PK 값에다가 + Ref
	
	private int sessionNo;
	private Date sessionDate; // sql이 맞겠죠?
	private Date sessionStartTime; // 이거는, 16시30분 이런식으로 할 것인지,
	// 아니면 16*60 + 30 = 이렇게 해서 1을 1분으로 쳐서 계산한 값으로 할 것인지
	
	private int sessionMaxPeople;
	private int sessionPrice;
	
	private String detailLocation;
	// 건물이름은 이미 작성이 되었으니, 그 뒤에 혹시 몇층, 몇호,
	// 또는 헷갈리지 않게 CU 건너편 이런식으로 작성할 수 있게만.
	// 도시 동 도로명주소 입력할 필요 없도록!!
	
	private int sessionHour;
	
	
}
