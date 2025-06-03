<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8"
		 import="com.giljobe.common.Constants"%>
<%@ page import="com.giljobe.program.model.dto.*,
				com.giljobe.qna.model.dto.*,
				com.giljobe.company.model.dto.*,
				com.giljobe.application.model.dto.*,
				java.util.List, java.util.Comparator" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
Program program = (Program)request.getAttribute("program");
List<Round> rounds = (List<Round>)request.getAttribute("rounds");
Round selectedRound = (Round)request.getAttribute("selectedRound");
List<Round> availableRounds = (List<Round>)request.getAttribute("availableRounds");
List<Round> expiredRounds = (List<Round>)request.getAttribute("expiredRounds");
boolean noAvailableRounds = availableRounds.isEmpty();
List<ProTime> proTimes = (List<ProTime>) request.getAttribute("proTimes");
List<Application> userApps = (loginUser != null) ? loginUser.getApplications() : java.util.Collections.emptyList();
if (proTimes != null) {
    proTimes.sort(Comparator.comparing(ProTime::getStartTime));
}
java.text.SimpleDateFormat timeFormat = new java.text.SimpleDateFormat("HH:mm");
String imageUrl = "/resources/images/logo.png"; // 기본 이미지
if (program != null) {
    String dbImage = program.getProImageUrl();
    if (dbImage != null && !dbImage.trim().isEmpty() && !"null".equalsIgnoreCase(dbImage.trim())) {
        imageUrl = Constants.DEFAULT_UPLOAD_PATH + dbImage; // ex: /resources/upload/1/4/1.png
    }
}
boolean isLiked = false;
if (loginUser != null) {
    isLiked = com.giljobe.love.model.service.LoveService.getInstance().hasLoved(
        loginUser.getUserNo(), program.getProNo());
}
boolean isMyProgram = false;
if (loginCompany != null && loginCompany.getComNo() == program.getComNoRef()) {
    isMyProgram = true;
}
%>

<section class="container py-5">

   <% if (program != null) {
   if (selectedRound != null) { %>
    <!-- 전체 화면 시작 -->
    <!-- 프로그램 요약 카드 -->
	<div class="bg-body-tertiary card mb-5 shadow-sm border-0 rounded-4 overflow-hidden">
        <div class="row g-0">
            <!-- 프로그램 이미지 -->
            <div class="col-md-5">
				<!-- 이미지 -->
				<%-- <img src="<%=request.getContextPath() + imageUrl %>"
					 class="w-100 h-100 object-fit-cover" alt="프로그램 이미지"> --%>
				<!-- 프로그램 수정 후에 이미지 캐시 무력화용 -->
				<img src="<%=request.getContextPath() + imageUrl %>?v=<%=System.currentTimeMillis()%>"
					 class="w-100 object-fit-cover rounded-start"
					 style="height: 450px;"
					 alt="프로그램 이미지">
            </div>
            <!-- 텍스트 정보 -->
            <div class="col-md-7">
                <div class="card-body">
					<h3 class="card-title fw-bold mb-3">
					    <%= program.getProName() %>
						<small class="text-muted fs-6">( <%= selectedRound.getRoundCount() %>회차 )</small>
					</h3>
					<p class="mb-2">
						<strong>주소:</strong> <%= program.getProLocation() %> <br>
						<%= selectedRound.getDetailLocation() %><br>
						<strong>체험일:</strong> <%= selectedRound.getRoundDate() %><br>
						<strong>최대모집인원:</strong> <%= selectedRound.getRoundMaxPeople() %>
						<strong>직업 유형:</strong> <%= program.getProType() %><br>
						<strong>분류:</strong> <%= program.getProCategory() %><br>
						<strong>참가비:</strong>
						<%= selectedRound.getRoundPrice()!=0 ? selectedRound.getRoundPrice() +"원":"무료"  %>
					</p>

					<div class="d-flex flex-wrap gap-2 mt-4">
						<!-- 회차 드롭다운 -->
						<div class="dropdown">
							<button class="btn btn-outline-secondary dropdown-toggle rounded-pill"
									type="button" data-bs-toggle="dropdown">
								<span id="round-dropdown-label">
									<%= selectedRound.getRoundCount() %>회차
								</span>
							</button>
							<ul class="dropdown-menu">
								<% if (noAvailableRounds) { %>
									<li class="dropdown-item text-muted">※ 현재 신청 가능한 회차 없음</li>
									<li><hr class="dropdown-divider"></li>
								<% } %>

								<% for (Round r : availableRounds) { %>
									<li><a class="dropdown-item round-option" href="#" data-roundcount="<%= r.getRoundCount() %>">
									<%= r.getRoundCount() %>회차 - <%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(r.getRoundDate()) %>
								</a></li>
								<% } %>

								<% if (!expiredRounds.isEmpty()) { %>
									<li><hr class="dropdown-divider"></li>
									<% for (Round r : expiredRounds) { %>
									<li><span class="dropdown-item text-muted"><%= r.getRoundCount() %>회차 (만료)</span></li>
									<% } %>
								<% } %>
							</ul>
						</div>

						<!-- 좋아요 버튼 -->
						<button type="button" class="btn btn-sm <%= isLiked ? "btn-danger" : "btn-outline-secondary" %> rounded-pill"
								data-prono="<%= program.getProNo() %>">
							♥ <span class="like-count"><%= program.getLikeCount() %></span>
						</button>
					</div>

					<!-- 시간 정보 -->
					<div id="protime-section" class="mt-4">
						<% if (proTimes != null && !proTimes.isEmpty()) { %>
						<div class="card border rounded-3">
							<div class="card-header bg-light fw-semibold">체험 가능 시간</div>
							<div class="card-body d-flex flex-wrap gap-2">
								<% for (ProTime pt : proTimes) {
									boolean applied = false;
									for (Application app : userApps) {
										if (app.getTimeNoRef() == pt.getTimeNo() && app.isApplyState()) {
											applied = true; break;
										}
									}
								%>
								<button type="button"
										class="btn <%= applied ? "btn-success" : "btn-outline-secondary" %> protime-btn"
										data-timeno="<%= pt.getTimeNo() %>">
									<%= timeFormat.format(pt.getStartTime()) %> ~ <%= timeFormat.format(pt.getEndTime()) %>
								</button>
								<% } %>
							</div>
						</div>
						<% } else { %>
							<p class="text-muted">시간 정보가 없습니다.</p>
						<% } %>
					</div>
					<!-- 기업 회원의 프로그램 수정과 관련하여 -->
					<% if (isMyProgram) { %>
						<jsp:include page="/WEB-INF/views/program/editComponent.jsp" />
					<% } %>
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


	<!-- 모든 회차 만료되었다면 protime 버튼 비활성화 -->
	<script>
	$(function() {
		$(document).on("click", "#protime-section button", function(e) {
			<% if (noAvailableRounds) { %>
			e.preventDefault();
			return;
			<% } %>
		});
	});
	</script>

	<!-- 프로그램 요약 -->
    <% if (selectedRound != null) { %>
		<div class="card mb-5 shadow-sm border-0 rounded-4">
			<div class="card-header bg-white fw-semibold">프로그램 요약</div>
			<div class="card-body" id="program-descript3">
				<p><strong>목표:</strong> <%= selectedRound.getGoal() %></p>
				<p><strong>프로그램 핵심 요약:</strong> <%= selectedRound.getSummary() %></p>
				<p><strong>유의사항:</strong> <%= selectedRound.getNote()!=null ? selectedRound.getNote() : "없음" %></p>
				<p><strong>상세 내용:</strong></p>
				<div class="bg-light p-3 rounded-2 border"><%= selectedRound.getDetail() %></div>
			</div>
		</div>
	<% } %>

	<!-- 지도 영역 -->

	<div class="card mb-5 border-0 rounded-4 shadow-sm">
		<div class="card-header fw-bold bg-white">지도</div>
		<div class="card-body">
			<%
				request.setAttribute("programName", program.getProName());            // 프로그램 이름
				request.setAttribute("programLocation", program.getProLocation());    // 주소
				request.setAttribute("programLat", program.getProLatitude());         // 위도 (double)
				request.setAttribute("programLng", program.getProLongitude());        // 경도 (double)
			%>
			<jsp:include page="/WEB-INF/views/program/mapComponent.jsp" />
		</div>
	</div>



	<!-- 채팅방 영역 -->
<%--	<div class="card mb-5 border-0 rounded-4 shadow-sm">--%>
<%--		<div class="card-header fw-bold bg-white">단체 채팅방</div>--%>
<%--		<div class="card-body">--%>
<%--			<jsp:include page="/WEB-INF/views/program/chat.jsp" />--%>
<%--		</div>--%>
<%--	</div>--%>
	<jsp:include page="/WEB-INF/views/program/chat.jsp" />

	<!-- Q&A 영역 -->
	<%
		Company company = com.giljobe.company.model.service.CompanyService.companyService().searchCompanyByNo(program.getComNoRef());
		List<QNA> qnaList = com.giljobe.qna.model.service.QNAService.qnaService().searchQNAByProNo(program.getProNo());
		request.setAttribute("qnaList", qnaList);
	%>
	<jsp:include page="/WEB-INF/views/program/qnaComponent.jsp" />
<%--	<div class="card mb-5 border-0 rounded-4 shadow-sm">--%>
<%--		<div class="card-header fw-bold bg-white">Q&A</div>--%>
<%--		<div class="card-body">--%>
<%--			<%--%>
<%--				Company company = com.giljobe.company.model.service.CompanyService.companyService().searchCompanyByNo(program.getComNoRef());--%>
<%--				List<QNA> qnaList = com.giljobe.qna.model.service.QNAService.qnaService().searchQNAByProNo(program.getProNo());--%>
<%--				request.setAttribute("qnaList", qnaList);--%>
<%--			%>--%>
<%--			<jsp:include page="/WEB-INF/views/program/qnaComponent.jsp" />--%>
<%--		</div>--%>
<%--	</div>--%>


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

                    data.proTimes.forEach(e => {
                        html += `<button class="btn btn-outline-secondary protime-btn"
                                         data-timeno="\${e.timeNo}">
                                     \${e.start} ~ \${e.end}
                                 </button>`;
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

<!-- 프로그램 신청과 관련하여 -->
<script>
$(document).on("click", ".protime-btn", function(e) {
	<%-- Case 0: 유효한 회차가 하나도 없으면 신청 불가 --%>
    <% if (noAvailableRounds) { %>
        alert("현재 회차는 이미 날짜가 지나서 신청할 수 없습니다.");
        return;
    <% } %>

	const timeNo = $(this).data("timeno");

    <%-- Case 1: 로그인하지 않은 사용자 --%>
    <% if (loginUser == null && loginCompany == null) { %>
        alert("로그인이 필요합니다.");
        return;
    <% } %>

    <%-- Case 2: 일반 사용자 --%>
    <% if (loginUser != null) { %>
	    // 1️ 현재 시간과 프로그램 타임 시작 시간 비교
	    const today = new Date().toISOString().split('T')[0];
	    const roundDate = "<%= selectedRound.getRoundDate() %>";
	    if (today === roundDate) {
	        const now = new Date();
	        const targetBtn = $(this);
	        const startText = targetBtn.text().split("~")[0].trim();  // e.g., "14:00"
	        const [startHour, startMin] = startText.split(":").map(Number);
	        const startTime = new Date();
	        startTime.setHours(startHour, startMin, 0, 0);

	        if (now > startTime) {
	            alert("이미 시간이 지나서 신청이 불가합니다.");
	            return;
	        } else {
	            alert("※ 해당 체험은 당일에 이루어지는 것입니다. 참고바랍니다.");
	        }
	    }

	    // 2️ 현재 신청 인원 수 확인 후 최대인원 비교
	    $.get(contextPath + "/ajax/app/count", { timeNo }, function(currentCount) {
	        const maxPeople = <%= selectedRound.getRoundMaxPeople() %>;
	        if (currentCount >= maxPeople) {
	            alert("신청 가능한 최대 인원이 이미 찼습니다.");
	            return;
	        }

	        // 3️ 실제 신청 로직
	        $.get(contextPath + "/ajax/app/check", { timeNo }, function(hasApplied) {
	            if (hasApplied) {
	                if (confirm("신청을 취소할까요?")) {
	                    $.post(contextPath + "/ajax/app/cancel", { timeNo }, function(success) {
	                        if (success) {
	                            alert("신청이 취소되었습니다.");
	                            $("button[data-timeno='" + timeNo + "']").removeClass("btn-success").addClass("btn-outline-secondary");
	                        }
	                    });
	                }
	            } else {
	                if (confirm("신청할까요?")) {
	                    $.post(contextPath + "/ajax/app/apply", { timeNo }, function(success) {
	                        if (success) {
	                            alert("신청되었습니다.");
	                            $("button[data-timeno='" + timeNo + "']").removeClass("btn-outline-secondary").addClass("btn-success");
	                        }
	                    });
	                }
	            }
	        });
	    });
	<% } %>

    <%-- Case 3: 기업회원 (본인 프로그램일 때) --%>
    <% if (loginCompany != null) { %>
	    <% if (isMyProgram) { %>
	        // ✅ 자기 회사 프로그램이면 신청자 수 조회
	        $.get(contextPath + "/ajax/app/count", { timeNo }, function(count) {
	            alert("현재까지 신청한 인원: " + count + "명");
	        });
	    <% } else { %>
	        // ❌ 타기업 프로그램이면 알림 표시만
	        alert("타기업의 신청 명단 확인은 불가합니다.");
	    <% } %>
	<% } %>

});
</script>

<!-- loveToggle, 좋아요 버튼 반영 -->
<%-- <script>
    const contextPath = "<%= request.getContextPath() %>";
</script> --%>
<script src="<%= request.getContextPath() %>/resources/js/loveToggle.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>