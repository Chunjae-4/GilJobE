<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" 
		 import="com.giljobe.common.Constants"%>
<%@ page import="com.giljobe.program.model.dto.Program,
				com.giljobe.program.model.dto.Round,
				java.util.List" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<% 
Program program = (Program)request.getAttribute("program");
List<Round> rounds = program.getRounds();
Round selectedRound = (Round)request.getAttribute("selectedRound");
List<Round> availableRounds = (List<Round>)request.getAttribute("availableRounds");
List<Round> expiredRounds = (List<Round>)request.getAttribute("expiredRounds");
boolean noAvailableRounds = availableRounds.isEmpty();
%>
<section class="container py-5">
    
   <% if (program != null) { %>
    <!-- 프로그램 요약 카드 -->
    <div class="card mb-4 shadow-sm">
        <div class="row g-0">
            <!-- 프로그램 이미지 -->
            <div class="col-md-5">
                <img src="<%=request.getContextPath() + program.getProImageUrl()%>" 
                     class="img-fluid rounded-start" alt="프로그램 이미지">
            </div>
            <!-- 텍스트 정보 -->
            <div class="col-md-7">
                <div class="card-body">
                    <h3 class="card-title"><%= program.getProName() %> (<%= program.getRounds().size() %>회차)</h3>
                    <p class="card-text">
                        <strong>지역:</strong> <%= program.getProLocation() %><br>
                        <strong>체험일:</strong> 2025/00/00<br>
                        <strong>체험이수시간:</strong> 2시간<br>
                        <strong>체험가능시간:</strong> 13:00 ~ 15:00<br>
                        <strong>모집인원:</strong> 17명<br>
                        <strong>직업군:</strong> 디자인을 체험하고 싶은 사람<br>
                        <strong>직업 유형:</strong> 시각디자인<br>
                        <strong>직군 분류:</strong> 디자인<br>
                        <strong>참가비:</strong> 무료
                    </p>

                    <div class="d-flex justify-content-between align-items-center mt-4">
                    	<div class="dropdown">
							<button class="btn btn-outline-secondary dropdown-toggle" type="button" id="roundDropdownBtn"
							          data-bs-toggle="dropdown" aria-expanded="false">
							      회차 정보: 
							      <%= selectedRound != null ? selectedRound.getRoundNo() + "회차" : "회차 정보 없음" %>
							</button>
							<ul class="dropdown-menu" aria-labelledby="roundDropdownBtn">
								<% if (noAvailableRounds) { %>
							        <li class="dropdown-item text-muted" style="pointer-events: none;">
							            ※ 현재 신청 가능한 회차가 없습니다.
							        </li>
							        <li><hr class="dropdown-divider"></li>
							    <% } %>
							    <!-- ✅ 가능한 회차 -->
							    <% for (Round r : availableRounds) { %>
							        <li>
							            <a class="dropdown-item" href="?proNo=<%= program.getProNo() %>&roundNo=<%= r.getRoundNo() %>">
							                <%= r.getRoundNo() %>회차 - <%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(r.getRoundDate()) %>
							            </a>
							        </li>
							    <% } %>
							
							    <!-- ✅ 구분선 -->
							    <% if (!(expiredRounds).isEmpty()) { %>
							        <li><hr class="dropdown-divider"></li>
							    <% } %>
							
							    <!-- ❌ 만료된 회차 -->
							    <% for (Round r : expiredRounds) { %>
							        <li>
							            <span class="dropdown-item text-muted" style="pointer-events: none;">
							                <%= r.getRoundNo() %>회차 (만료) - <%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(r.getRoundDate()) %>
							            </span>
							        </li>
							    <% } %>
							</ul>
						</div>                 
                            <% if (selectedRound != null) { %>
							    <button class="btn btn-outline-primary btn-sm">참여하기</button>
							<% } else { %>
							    <button class="btn btn-outline-secondary btn-sm" disabled>참여 불가</button>
							<% } %>       
                        <small class="text-muted">🧡 51명</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <% } else { %>
        <p>프로그램 정보가 없습니다.</p>
    <% } %>
    
    
    
    
    
    
    
    <% if (program != null) { %>
        <h1><%= program.getProName() %></h1>
        <p><strong>유형:</strong> <%= program.getProType() %></p>
        <p><strong>장소:</strong> <%= program.getProLocation() %></p>
        <p><strong>카테고리:</strong> <%= program.getProCategory() %></p>
        <p><strong>이미지 경로:</strong> <%= program.getProImageUrl() %></p>
        <p><strong>위도 / 경도:</strong> <%= program.getProLatitude() %> / <%= program.getProLongitude() %></p>
    <% } else { %>
        <p>프로그램 정보가 없습니다.</p>
    <% } %>
    
    
    
    
	<!-- 지도 영역 -->
	<div class="program-map">
	    <h3>지도</h3>
	    <div id="map" style="width:100%; height:300px;"></div>
	</div>
	
	<!-- 채팅방 영역 -->
	<div class="program-chat">
	    <h3>단체 채팅방</h3>
	    <div class="chat-placeholder">※ 이 영역은 웹소켓 적용 예정 ※</div>
	</div>
	
	<!-- Q&A 영역 -->
	<div class="program-qna">
	    <h3>Q&A</h3>
	    <div class="qna-placeholder">※ Q&A 기능은 추후 구현 예정 ※</div>
	</div>
    
</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>