<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page import="com.giljobe.program.model.dto.*,
                 java.util.List,
                 java.text.SimpleDateFormat" %>

<%
    Program program = (Program) request.getAttribute("program");
    Round round = (Round) request.getAttribute("round");
    List<ProTime> proTimes = (List<ProTime>) request.getAttribute("proTimes");

    boolean hasProTimes = (proTimes != null && !proTimes.isEmpty());
    int durationMinutes = 0;
    if (hasProTimes) {
        java.util.Date start = proTimes.get(0).getStartTime();
        java.util.Date end = proTimes.get(0).getEndTime();
        long diffMillis = end.getTime() - start.getTime();
        durationMinutes = (int)(diffMillis / (1000 * 60));
    }

    SimpleDateFormat hourFormat = new SimpleDateFormat("HH");
    SimpleDateFormat minuteFormat = new SimpleDateFormat("mm");
%>

<section class="container py-5">
    <div class="mb-4 text-center">
        <h2 class="fw-bold">🛠 프로그램 타임 수정</h2>
        <p class="text-muted">회차별 체험 시간과 시작 시각을 편집할 수 있어요.</p>
    </div>

    <div class="mb-3">
        <h5 class="fw-semibold">📌 프로그램명: <%= program.getProName() %></h5>
        <h6 class="text-muted">🔁 <%= round.getRoundCount() %>회차</h6>
    </div>

    <form action="<%=request.getContextPath()%>/protime/edit-submit" method="post" class="bg-white p-4 rounded-4 shadow-sm">
        <input type="hidden" name="roundNo" value="<%= round.getRoundNo() %>">
        <input type="hidden" name="proNo" value="<%= program.getProNo() %>">

        <!-- 체험 시간 -->
        <div class="mb-4">
            <label class="form-label fw-semibold">⏳ 체험 시간 (분)</label>
            <input type="number" name="duration" class="form-control" min="1" required
                   value="<%= durationMinutes > 0 ? durationMinutes : "" %>">
        </div>

        <!-- 시작 시간 목록 -->
        <div class="mb-4">
            <label class="form-label fw-semibold">⏱ 시작 시간 목록</label>
            <div id="startTimeContainer">
                <%
                    if (hasProTimes) {
                        for (ProTime pt : proTimes) {
                            int hour = Integer.parseInt(hourFormat.format(pt.getStartTime()));
                            int minute = Integer.parseInt(minuteFormat.format(pt.getStartTime()));
                %>
                <div class="d-flex align-items-center mb-2 start-time-row">
                    <input type="hidden" name="timeNo" value="<%= pt.getTimeNo() %>">
                    <select name="startHour" class="form-select me-2" style="width:auto;">
                        <% for (int h = 0; h < 24; h++) { %>
                        <option value="<%=h%>" <%= h == hour ? "selected" : "" %>>
                            <%=String.format("%02d", h)%>
                        </option>
                        <% } %>
                    </select>
                    <select name="startMinute" class="form-select me-2" style="width:auto;">
                        <% for (int m = 0; m < 60; m += 5) { %>
                        <option value="<%=m%>" <%= m == minute ? "selected" : "" %>>
                            <%=String.format("%02d", m)%>
                        </option>
                        <% } %>
                    </select>
                    <button type="button" class="btn btn-outline-danger btn-sm remove-time">-</button>
                </div>
                <% }} else { %>
                <div class="d-flex align-items-center mb-2 start-time-row">
                    <select name="startHour" class="form-select me-2" style="width:auto;">
                        <% for (int h = 0; h < 24; h++) { %>
                        <option value="<%=h%>"><%=String.format("%02d", h)%></option>
                        <% } %>
                    </select>
                    <select name="startMinute" class="form-select me-2" style="width:auto;">
                        <% for (int m = 0; m < 60; m += 5) { %>
                        <option value="<%=m%>"><%=String.format("%02d", m)%></option>
                        <% } %>
                    </select>
                    <button type="button" class="btn btn-outline-danger btn-sm remove-time">-</button>
                </div>
                <% } %>
            </div>
            <button type="button" class="btn btn-outline-primary btn-sm mt-2" onclick="addStartTime()">+ 시간 추가</button>
        </div>

        <div class="d-flex justify-content-end gap-2 mt-4">
            <button type="submit" class="btn btn-primary px-4">💾 저장</button>
            <a href="<%=request.getContextPath()%>/program/detail?proNo=<%=round.getProNoRef()%>" class="btn btn-outline-secondary px-4">취소</a>
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
            hourOptions += `<option value="\${h}">\${h.toString().padStart(2, '0')}</option>`;
        }

        let minuteOptions = '';
        for (let m = 0; m < 60; m += 5) {
            minuteOptions += `<option value="\${m}">\${m.toString().padStart(2, '0')}</option>`;
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
                e.target.closest(".start-time-row").remove();
            } else {
                alert("최소 1개의 시간은 필요합니다.");
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
        
    });
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
