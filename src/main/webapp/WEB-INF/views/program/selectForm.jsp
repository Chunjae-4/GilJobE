<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"
         import="java.util.List, com.giljobe.program.model.dto.Program" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<h2 class="my-4">프로그램 등록 방식 선택</h2>

<form method="post" action="<%=request.getContextPath()%>/program/selectsubmit">
    <!-- 1. 기존/신규 선택 -->
    <div class="mb-3">
        <label class="form-label fw-bold">1. 기존/신규 선택 *</label><br>
        <input type="radio" name="programType" value="existing" id="existingRadio">
        <label for="existingRadio">기존 프로그램 회차 추가</label>
        <input type="radio" name="programType" value="new" id="newRadio" checked>
        <label for="newRadio">새로운 프로그램 추가</label>
    </div>

    <!-- 2. 기존 프로그램 리스트 -->
    <div class="mb-3" id="programListSection" style="display:none;">
        <label class="form-label fw-bold">2. 프로그램 선택</label><br>
        <select name="selectedProNo" class="form-select">
            <%
                List<Program> programList = (List<Program>) request.getAttribute("programList");
                if (programList != null && !programList.isEmpty()) {
                    for (Program p : programList) {
            %>
                <option value="<%=p.getProNo()%>"><%=p.getProName()%></option>
            <%
                    }
                } else {
            %>
                <option disabled>등록된 프로그램이 없습니다.</option>
            <%
                }
            %>
        </select>
    </div>

    <!-- 3. 세부 내용 변경 여부 -->
    <div class="mb-3" id="changeDetailSection" style="display:none;">
        <label class="form-label fw-bold">3. 세부 내용 변경 희망 여부</label><br>
        <input type="radio" name="changeDetail" value="no" id="changeNo" checked>
        <label for="changeNo">아니오</label>
        <input type="radio" name="changeDetail" value="yes" id="changeYes">
        <label for="changeYes">네</label>
    </div>

    <button type="submit" class="btn btn-primary">다음</button>
</form>

<script>
    const existingRadio = document.getElementById("existingRadio");
    const newRadio = document.getElementById("newRadio");
    const programListSection = document.getElementById("programListSection");
    const changeDetailSection = document.getElementById("changeDetailSection");

    function toggleSections() {
        if (existingRadio.checked) {
            programListSection.style.display = "block";
            changeDetailSection.style.display = "block";
        } else {
            programListSection.style.display = "none";
            changeDetailSection.style.display = "none";
        }
    }

    existingRadio.addEventListener("change", toggleSections);
    newRadio.addEventListener("change", toggleSections);
    window.onload = toggleSections;
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
