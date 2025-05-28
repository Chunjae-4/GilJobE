<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<h2 class="my-4">회차 정보 직접 입력</h2>

<form action="<%=request.getContextPath()%>/round/insert-with-detail" method="post">
    <input type="hidden" name="proNoRef" value="<%=request.getParameter("proNo")%>">

    <!-- 체험 날짜 -->
    <div class="mb-3">
        <label class="form-label">📅 체험 날짜 *</label>
        <input type="date" name="roundDate" class="form-control" required>
    </div>

    <!-- 활동 시간 -->
    <div class="mb-3">
        <label class="form-label">⏳ 체험 시간 (분 단위) *</label>
        <input type="number" name="duration" class="form-control" min="1" required>
        
    </div>
    
	<!-- 시작 시간들 -->
	<div class="mb-3">
	    <label class="form-label">⏱ 시작 시간 (여러 개 입력 가능)</label>
	    <div id="startTimeContainer">
	        <!-- 초기 1개 블록 -->
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
	    <button type="button" class="btn btn-outline-primary btn-sm" onclick="addStartTime()">+ 시간 추가</button>
	</div>

    
    <!-- 최대 인원 / 가격 -->
    <div class="row mb-3">
        <div class="col">
            <label class="form-label">👥 최대 인원 *</label>
            <input type="number" name="roundMaxPeople" class="form-control" min="1" required>
        </div>
        <div class="col">
            <label class="form-label">💰 가격 (원) *</label>
            <input type="number" name="roundPrice" class="form-control" min="0" required>
        </div>
    </div>

    <!-- 상세 위치 -->
    <div class="mb-3">
        <label class="form-label">📍 상세 위치 *</label>
        <input type="text" name="detailLocation" class="form-control" required>
    </div>

    <!-- 목표, 요약, 상세, 유의사항 -->
    <div class="mb-3">
        <label class="form-label">🎯 체험 목표 *</label>
        <input type="text" name="goal" class="form-control" required>
    </div>

    <div class="mb-3">
        <label class="form-label">📖 요약 설명 *</label>
        <input type="text" name="summary" class="form-control" required>
    </div>

    <div class="mb-3">
        <label class="form-label">📝 상세 설명 *</label>
        <textarea name="detail" class="form-control" rows="3" required></textarea>
    </div>

    <div class="mb-3">
        <label class="form-label">⚠️ 유의사항</label>
        <textarea name="note" class="form-control" rows="2"></textarea>
    </div>

    <button type="submit" class="btn btn-success">회차 등록 완료</button>
</form>

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