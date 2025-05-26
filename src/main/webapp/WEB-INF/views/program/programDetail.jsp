<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" 
		 import="com.giljobe.common.Constants"%>
<%@ page import="com.giljobe.program.model.dto.*,
				java.util.List" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<% 
Program program = (Program)request.getAttribute("program");
List<Round> rounds = program.getRounds();
Round selectedRound = (Round)request.getAttribute("selectedRound");
List<Round> availableRounds = (List<Round>)request.getAttribute("availableRounds");
List<Round> expiredRounds = (List<Round>)request.getAttribute("expiredRounds");
boolean noAvailableRounds = availableRounds.isEmpty();
List<ProTime> proTimes = (List<ProTime>) request.getAttribute("proTimes");
java.text.SimpleDateFormat timeFormat = new java.text.SimpleDateFormat("HH:mm");
String imageUrl = "/resources/images/logo.png"; // ✅ 기본 이미지 경로
if (program != null) {
    String dbImage = program.getProImageUrl();
    if (dbImage != null && !dbImage.trim().isEmpty() && !"null".equalsIgnoreCase(dbImage.trim())) {
        imageUrl = dbImage;
    }
}
%>
<section class="container py-5">
    
   <% if (program != null) { %>
    <!-- 프로그램 요약 카드 -->
    <div class="card mb-4 shadow-sm">
        <div class="row g-0">
            <!-- 프로그램 이미지 -->
            <div class="col-md-5">
                <img src="<%=request.getContextPath() + imageUrl%>" 
                     class="img-fluid rounded-start" alt="프로그램 이미지">
            </div>
            <!-- 텍스트 정보 -->
            <div class="col-md-7">
                <div class="card-body">
                	<h3 class="card-title">
					    <%= program.getProName() %> (
					    <span id="selected-round-label">
					        <%= selectedRound != null ? selectedRound.getRoundCount() + "회차" : "회차 정보 없음" %>
					    </span>
					    )
					</h3>
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
								  <span id="round-dropdown-label">
								      <%= selectedRound != null ? selectedRound.getRoundCount() + "회차" : "회차 정보 없음" %>
							      </span>
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
										<a class="dropdown-item round-option" href="#" data-roundcount="<%= r.getRoundCount() %>">
							                <%= r.getRoundCount() %>회차 - <%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(r.getRoundDate()) %>
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
							                <%= r.getRoundCount() %>회차 (만료) - <%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(r.getRoundDate()) %>
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
                        
                        <div id="protime-section">
	                        <% if (proTimes != null && !proTimes.isEmpty()) { %>
							    <div class="card mb-4">
							        <div class="card-header fw-bold">체험 가능 시간</div>
							        <div class="card-body">
							            <div class="d-flex flex-wrap gap-2">
							                <% for (ProTime pt : proTimes) { %>
							                    <button type="button" class="btn btn-outline-secondary">
							                        <%= timeFormat.format(pt.getStartTime()) %> ~ <%= timeFormat.format(pt.getEndTime()) %>
							                    </button>
							                <% } %>
							            </div>
							        </div>
							    </div>
							<% } else { %>
							    <p class="text-muted">시간 정보가 없습니다.</p>
							<% } %>
						</div>
                        
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
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

<script>
$(function() {
    $(".round-option").click(function(e) {
        e.preventDefault();

        const roundCount = $(this).data("roundcount");
        const proNo = "<%= program.getProNo() %>";

        $.ajax({
            url: "<%=request.getContextPath()%>/program/roundinfo",
            method: "GET",
            data: { proNo: proNo, roundCount: roundCount },
            success: function(data) {
            	
            	console.log("응답 데이터:", data);
            	
                // 회차 제목 변경
                $("#selected-round-label").text(data.roundCount + "회차");
                $("#round-dropdown-label").text(data.roundCount + "회차");

                // 시간 리스트 갱신
                let html = "";
                if (data.proTimes.length > 0) {
                    html += `<div class="card mb-4">
                                <div class="card-header fw-bold">체험 가능 시간</div>
                                <div class="card-body">
                                    <div class="d-flex flex-wrap gap-2">`;
                    data.proTimes.forEach(function(pt) {
                        html += `<button class="btn btn-outline-secondary">${pt.start} ~ ${pt.end}</button>`;
                    });
                    html += `</div></div></div>`;
                } else {
                    html = `<p class="text-muted">시간 정보가 없습니다.</p>`;
                }

                $("#protime-section").html(html);
            }
        });
    });
});
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>