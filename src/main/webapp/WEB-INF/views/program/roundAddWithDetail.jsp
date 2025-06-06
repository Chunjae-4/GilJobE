<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
	String todayDate = (String)request.getAttribute("todayDate");

    String proNoParam = request.getParameter("proNo");
    String actionUrl = (proNoParam != null && !proNoParam.isEmpty())
        ? request.getContextPath() + "/round/insert-with-detail-existing"
        : request.getContextPath() + "/round/insert-with-detail";
    // 새로운 프로그램에서 오는 것인지, 아니면 기존 프로그램에서 오는 것인지 분기처리
%>
<section class="container py-5">
    <div class="mb-4 text-center">
        <h2 class="fw-bold">회차 정보 직접 입력</h2>
        <p class="text-muted">회차별 날짜, 시간, 인원, 상세 내용을 설정해주세요.</p>
    </div>

    <form action="<%= actionUrl %>" method="post" class="bg-white p-4 rounded-4 shadow-sm">

        <% if (proNoParam != null && !proNoParam.isEmpty()) { %>
        <input type="hidden" name="proNo" value="<%= proNoParam %>">
        <% } %>

        <!-- 체험 날짜 -->
        <div class="mb-4">
            <label class="form-label fw-semibold">📅 체험 날짜 *</label>
            <input type="date" name="roundDate" class="form-control" required min="<%= todayDate %>">
        </div>

        <!-- 체험 시간 -->
        <div class="mb-4">
            <label class="form-label fw-semibold">⏳ 체험 시간 (분 단위) *</label>
            <input type="number" name="duration" class="form-control" min="1" required placeholder="예: 60">
        </div>

        <!-- 시작 시간들 -->
        <div class="mb-4">
            <label class="form-label fw-semibold">⏱ 시작 시간 (여러 개 입력 가능)</label>
            <div id="startTimeContainer">
                <div class="d-flex mb-2 start-time-row">
                    <select name="startHour" class="form-select me-2" style="width:auto;">
                        <% for (int i = 0; i <= 23; i++) { %>
                        <option value="<%=i%>"><%=String.format("%02d", i)%></option>
                        <% } %>
                    </select>
                    <select name="startMinute" class="form-select me-2" style="width:auto;">
                        <% for (int i = 0; i < 60; i += 5) { %>
                        <option value="<%=i%>"><%=String.format("%02d", i)%></option>
                        <% } %>
                    </select>
                    <button type="button" class="btn btn-outline-danger btn-sm remove-time">-</button>
                </div>
            </div>
            <button type="button" class="btn btn-outline-primary btn-sm mt-2" onclick="addStartTime()">+ 시간 추가</button>
        </div>

        <!-- 최대 인원 / 가격 -->
        <div class="row mb-4">
            <div class="col-md-6">
                <label class="form-label fw-semibold">👥 최대 인원 *</label>
                <input type="number" name="roundMaxPeople" class="form-control" min="1" required placeholder="예: 20">
            </div>
            <div class="col-md-6">
                <label class="form-label fw-semibold">💰 가격 (원) *</label>
                <input type="number" name="roundPrice" class="form-control" min="0" required placeholder="예: 15000">
            </div>
        </div>

        <!-- 상세 위치 및 설명 -->
        <div class="mb-3">
            <label class="form-label fw-semibold">📍 상세 위치 *</label>
            <input type="text" name="detailLocation" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">🎯 체험 목표 *</label>
            <input type="text" name="goal" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">📖 요약 설명 *</label>
            <input type="text" name="summary" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label fw-semibold">📝 상세 설명 *</label>
            <textarea name="detail" class="form-control" rows="3" required></textarea>
        </div>

        <div class="mb-4">
            <label class="form-label fw-semibold">⚠️ 유의사항</label>
            <textarea name="note" class="form-control" rows="2"></textarea>
        </div>

        <div class="text-end">
            <button type="submit" class="btn btn-success px-4">회차 등록 완료</button>
        </div>
    </form>
</section>


<script>
	
    function addStartTime() {
        const container = document.getElementById("startTimeContainer");

        const newRow = document.createElement("div");
        newRow.className = "d-flex mb-2 start-time-row";

        let hourOptions = '';
        for (let h = 0; h < 24; h++) {
            const padded = h.toString().padStart(2, '0');
            hourOptions += `<option value="\${h}">\${padded}</option>`;
        }

        let minuteOptions = '';
        for (let m = 0; m < 60; m += 5) {
            const padded = m.toString().padStart(2, '0');
            minuteOptions += `<option value="\${m}">\${padded}</option>`;
        }

        newRow.innerHTML = `
            <select name="startHour" class="form-select me-2" style="width:auto;">
                \${hourOptions}
            </select>
            <select name="startMinute" class="form-select me-2" style="width:auto;">
                \${minuteOptions}
            </select>
            <button type="button" class="btn btn-outline-danger btn-sm remove-time">-</button>
        `;
        container.appendChild(newRow);
    }

    document.addEventListener("click", function(e) {
        if (e.target.classList.contains("remove-time")) {
            const container = document.getElementById("startTimeContainer");
            const rows = container.querySelectorAll(".start-time-row");

            if (rows.length > 1) {
                const row = e.target.closest(".start-time-row");
                if (row) row.remove();
            } else {
                alert("최소 1개의 시작 시간이 필요합니다.");
            }
        }
    });
    
    document.querySelector("form").addEventListener("submit", function(e) {
        const duration = parseInt(document.querySelector("input[name='duration']").value);
        if (!duration || duration < 1) {
            alert("활동 시간은 1분 이상이어야 합니다.");
            e.preventDefault();
            return;
        }

        const hourEls = document.querySelectorAll("select[name='startHour']");
        const minuteEls = document.querySelectorAll("select[name='startMinute']");
        const timeRanges = [];

        for (let i = 0; i < hourEls.length; i++) {
            const h = parseInt(hourEls[i].value);
            const m = parseInt(minuteEls[i].value);
            const startMinutes = h * 60 + m;
            const endMinutes = startMinutes + duration;

            // 중복/겹침 검사
            let overlap = false;
            for (const [prevStart, prevEnd] of timeRanges) {
                // 만약 시작시간이 이전 구간 안에 들어오거나, 종료시간이 이전 시작시간보다 크면 겹침
                if (
                    (startMinutes >= prevStart && startMinutes < prevEnd) ||
                    (endMinutes > prevStart && endMinutes <= prevEnd) ||
                    (startMinutes <= prevStart && endMinutes >= prevEnd) // 완전히 감싸는 경우
                ) {
                	overlap = true;
                    break;
                	
                }
            }
            if (overlap) {
            	alert(`시작 시간 \${String(h).padStart(2, "0")}:\${String(m).padStart(2, "0")} 은 기존 타임과 겹칩니다.`);
                e.preventDefault();
                return;
            }
            timeRanges.push([startMinutes, endMinutes]);
        }

        const maxPeople = document.querySelector("input[name='roundMaxPeople']").value;
        if (!maxPeople || parseInt(maxPeople) < 1) {
            alert("최대 인원은 1명 이상이어야 합니다.");
            e.preventDefault();
            return;
        }

        const requiredFields = ["detailLocation", "goal", "summary", "detail"];
        const fieldLabels = {
        	    detailLocation: "상세 위치",
        	    goal: "체험 목표",
        	    summary: "요약 설명",
        	    detail: "상세 설명"
        };
        for (const name of requiredFields) {
            const val = document.querySelector(`[name='\${name}']`).value;
            if (!val || val.trim() === "") {
                alert(`"\${fieldLabels[name]}" 항목을 입력해주세요.`);
                e.preventDefault();
                return;
            }
        }
    });

</script>



<%@ include file="/WEB-INF/views/common/footer.jsp" %>