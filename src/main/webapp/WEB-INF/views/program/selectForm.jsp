<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"
         import="java.util.List, com.giljobe.program.model.dto.Program" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
    String programType = request.getParameter("programType");
    String selectedProNo = request.getParameter("selectedProNo");
    String changeDetail = request.getParameter("changeDetail");
%>

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
        <label class="form-label fw-bold">3. 세부 내용(회차 정보) 변경 희망 여부</label><br>
        <input type="radio" name="changeDetail" value="no" id="changeNo" checked>
        <label for="changeNo">아니오 - 동일한 내용으로 회차 여러개 생성 가능</label>
        <input type="radio" name="changeDetail" value="yes" id="changeYes">
        <label for="changeYes">네 - 내용 변경된 회차 1개 생성 가능</label>
    </div>

    <button type="submit" class="btn btn-primary">다음</button>
</form>

<script>
    const existingRadio = document.getElementById("existingRadio");
    const newRadio = document.getElementById("newRadio");
    const programListSection = document.getElementById("programListSection");
    const changeDetailSection = document.getElementById("changeDetailSection");
    const programDropdown = document.querySelector("select[name='selectedProNo']");
    const changeYes = document.getElementById("changeYes");
    const changeNo = document.getElementById("changeNo");

    // 파라미터 값 JSP → JS 변수로 전달
    const param_programType = '<%= programType != null ? programType : "" %>';
    const param_selectedProNo = '<%= selectedProNo != null ? selectedProNo : "" %>';
    const param_changeDetail = '<%= changeDetail != null ? changeDetail : "" %>';

    function toggleSections() {
        if (existingRadio.checked) {
            programListSection.style.display = "block";
            changeDetailSection.style.display = "block";
        } else {
            programListSection.style.display = "none";
            changeDetailSection.style.display = "none";
        }
    }

    window.addEventListener("DOMContentLoaded", function() {
        // 1. 기존/신규 선택 반영
        if (param_programType === 'existing') {
            existingRadio.checked = true;
        } else {
            newRadio.checked = true;
        }

        // 2. 드롭다운에서 프로그램 선택
        if (param_selectedProNo && programDropdown) {
            programDropdown.value = param_selectedProNo;
        }

        // 3. 세부 내용 변경 여부 반영
        if (param_changeDetail === 'yes') {
            changeYes.checked = true;
        } else {
            changeNo.checked = true;
        }

        // 4. 관련 섹션 표시 여부 결정
        toggleSections();
    });

    existingRadio.addEventListener("change", toggleSections);
    newRadio.addEventListener("change", toggleSections);
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>
