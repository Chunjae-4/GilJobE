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
// resources/upload/ComNo/ProNo/imageNo 가 프로그램 이미지 저장 경로
// 이거는 나중에, 진짜 나중에 wrapper로 이미지 업로드할 때 이름 바꿔서 저장되도록 해놓을 것. 이건 나중에.
if (program != null) {
    String dbImage = program.getProImageUrl();
    if (dbImage != null && !dbImage.trim().isEmpty() && !"null".equalsIgnoreCase(dbImage.trim())) {
        imageUrl = dbImage;
    }
}
%>
<section class="container py-5">
    
   <% if (program != null) {
   if (selectedRound != null) { %>
    <!-- 전체 화면 시작 -->
    <!-- 프로그램 요약 카드 -->
    <div class="card mb-4 shadow-sm">
        <div class="row g-0">
            <!-- 프로그램 이미지 -->
            <div class="col-md-5">
				<!-- 이미지 -->
				<img src="<%=request.getContextPath()%><%=Constants.DEFAULT_UPLOAD_PATH%><%=program.getProImageUrl()%>.jpg"
					 class="w-100 h-100 object-fit-cover" alt="프로그램 이미지">
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
                        <strong>주소:</strong> <%=program.getProLocation()%>
                        <span id="program-descript1">
	                        <%=selectedRound.getDetailLocation() %><br>
	                        <strong>체험일:</strong> <%=selectedRound.getRoundDate() %><br>
	                        <strong>최대모집인원:</strong> <%=selectedRound.getRoundMaxPeople() %><br>
                        </span>
                        <strong>직업 유형:</strong> <%=program.getProType() %><br>
                        <strong>분류:</strong> <%=program.getProCategory() %><br>
                        <span id="program-descript2">
	                        <strong>참가비:</strong> 
	                        <%=selectedRound.getRoundPrice()!=0 ? selectedRound.getRoundPrice() +"원":"무료"  %>
                   		</span>
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
    	<p class="text-muted">※ 유효한 회차 정보가 없습니다.</p>
  	<% } 
   	} else { %>
        <p>프로그램 정보가 없습니다.</p>
    <% } %>
    
    <% if (selectedRound != null) { %>
	<div class="card mb-4">
	    <div class="card-header fw-bold">프로그램 요약</div>
	    <div class="card-body" id="program-descript3">
	        <p><strong>목표:</strong> <%= selectedRound.getGoal() %></p>
	        <p><strong>프로그램 핵심 요약:</strong> <%= selectedRound.getSummary() %></p>
	        <p><strong>유의사항:</strong> <%= selectedRound.getNote()!=null?selectedRound.getNote():"없음" %></p>
	        <p><strong>상세 내용:</strong></p>
	        <div class="border p-3 bg-light"><%= selectedRound.getDetail() %></div>
	    </div>
	</div>
	<% } %>
	
	<!-- 지도 영역 -->
	<div class="program-map">
	    <h3>지도</h3>
	
	    <!-- 지도에 필요한 정보들 JSP에서 request에 전달 -->
	    <!-- 지도 표시용 모듈(mapComponent.jsp)을 include 하기 전 필요한 정보들을 request에 담아야 함 -->
	    <%
		    request.setAttribute("programName", program.getProName());            // 프로그램 이름
		    request.setAttribute("programLocation", program.getProLocation());    // 주소
		    request.setAttribute("programLat", program.getProLatitude());         // 위도 (double)
		    request.setAttribute("programLng", program.getProLongitude());        // 경도 (double)
	    %>
	
	    <!-- 지도 모듈 (mapComponent.jsp) include 하여 지도 컴포넌트 삽입 -->
	    <jsp:include page="/WEB-INF/views/program/mapComponent.jsp" />
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
                $("#selected-round-label").text(data.roundCount + "회차");
                $("#round-dropdown-label").text(data.roundCount + "회차");
                $("#program-descript1").html(`
                        \${data.detailLocation}<br>
                        <strong>체험일:</strong> \${data.roundDate}<br>
                        <strong>최대모집인원:</strong> \${data.roundMaxPeople}<br>`);
                $("#program-descript2").html(`
                		<strong>참가비:</strong>
                		\${data.roundPrice!=0 ? data.roundPrice +"원":"무료"}`);
                $("#program-descript3").html(`
                        <p><strong>목표:</strong> \${data.goal}</p>
                        <p><strong>프로그램 핵심 요약:</strong> \${data.summary}</p>
                        <p><strong>유의사항:</strong> \${data.note!=null?data.note:'없음'}</p>
                        <p><strong>상세 내용:</strong></p>
                        <div class="border p-3 bg-light">\${data.detail}</div>`);
                
	         	 // 시간 리스트 갱신
                let html = "";
                if (data.proTimes.length > 0) {
                    html += `<div class="card mb-4">
                                <div class="card-header fw-bold">체험 가능 시간</div>
                                <div class="card-body">
                                    <div class="d-flex flex-wrap gap-2">`;
                    data.proTimes.forEach(e=> {
                        html += `<button class="btn btn-outline-secondary">\${e.start} ~ \${e.end}</button>`;
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