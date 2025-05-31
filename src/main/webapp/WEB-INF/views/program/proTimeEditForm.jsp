<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page import="com.giljobe.program.model.dto.*,
                 com.giljobe.company.model.dto.*,
                 java.util.List" %>
<%
    List<ProTime> proTimes = (List<ProTime>) request.getAttribute("proTimes");
    Round round = (Round) request.getAttribute("round");
%>
<section class="container py-5">
    <h2><%= round.getRoundCount() %>회차 타임 수정</h2>
    <form action="<%=request.getContextPath()%>/protime/edit-submit" method="post">
        <input type="hidden" name="roundNo" value="<%=round.getRoundNo()%>">
        <div id="timeContainer">
            <% for (ProTime pt : proTimes) { %>
                <div class="d-flex mb-2">
                    <input type="time" name="startTime" value="<%=new java.text.SimpleDateFormat("HH:mm").format(pt.getStartTime())%>" class="form-control me-2" required>
                    <input type="time" name="endTime" value="<%=new java.text.SimpleDateFormat("HH:mm").format(pt.getEndTime())%>" class="form-control" required>
                </div>
            <% } %>
        </div>
        <button type="button" onclick="addTimeRow()" class="btn btn-sm btn-outline-primary mb-3">시간 추가</button>
        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-success">타임 수정 완료</button>
            <a href="<%=request.getContextPath()%>/program/detail?proNo=<%=round.getProNoRef()%>" class="btn btn-secondary">취소</a>
        </div>
    </form>
</section>

<script>
function addTimeRow() {
    const row = document.createElement("div");
    row.className = "d-flex mb-2";
    row.innerHTML = `
        <input type="time" name="startTime" class="form-control me-2" required>
        <input type="time" name="endTime" class="form-control" required>
    `;
    document.getElementById("timeContainer").appendChild(row);
}
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
