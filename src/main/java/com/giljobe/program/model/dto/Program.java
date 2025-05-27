package com.giljobe.program.model.dto;

import java.util.List;

import com.giljobe.application.model.dto.Application;
import com.giljobe.chat.model.dto.Chat;
import com.giljobe.love.model.dto.Love;
import com.giljobe.qna.model.dto.QNA;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Program {
	private int proNo;
	private String proName;
	private String proType;
	private String proLocation;
	// 서울시 금천구 가산디지털로 30길20 건물이름
	// 건물이름까지만 작성하는 걸로.
	
	private double proLatitude;
	private double proLongitude;
	private String proCategory;
	private String proImageUrl;

	private int comNoRef;
	// 기업번호 참조 - 기업 번호 변수명에다가 Ref 를 붙이는걸로.
	
	private List<Round> rounds;	// 회차 정보
	private List<QNA> qnas; // 문의 정보
	private List<Chat> chats;
	private List<Love> likes;
	private List<Application> applications;
	// 건물이름은 이미 작성이 되었으니, 그 뒤에 혹시 몇층, 몇호,
	// 또는 헷갈리지 않게 CU 건너편 이런식으로 작성할 수 있게만.
	// 도시 동 도로명주소 입력할 필요 없도록!!
	

}
