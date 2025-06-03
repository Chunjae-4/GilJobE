<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"
         import="java.util.List, com.giljobe.program.model.dto.Program" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
    String programType = request.getParameter("programType");
    String selectedProNo = request.getParameter("selectedProNo");
    String changeDetail = request.getParameter("changeDetail");
%>

<section class="container py-5">
    <div class="mb-4 text-center">
        <h2 class="fw-bold">프로그램 등록 방식 선택</h2>
        <p class="text-muted">기존 프로그램에 회차를 추가하거나 새 프로그램을 만들 수 있어요.</p>
    </div>

    <form method="post" action="<%=request.getContextPath()%>/program/selectsubmit" class="bg-white p-4 rounded-4 shadow-sm">
        <!-- 1. 기존/신규 선택 -->
        <div class="mb-4">
            <label class="form-label fw-bold d-block mb-2">1. 기존/신규 선택 *</label>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="programType" value="existing" id="existingRadio">
                <label class="form-check-label" for="existingRadio">기존 프로그램 회차 추가</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="programType" value="new" id="newRadio" checked>
                <label class="form-check-label" for="newRadio">새로운 프로그램 추가</label>
            </div>
        </div>

        <!-- 2. 기존 프로그램 리스트 -->
        <div class="mb-4" id="programListSection" style="display:none;">
            <label class="form-label fw-bold mb-2">2. 프로그램 선택</label>
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
        <div class="mb-4" id="changeDetailSection" style="display:none;">
            <label class="form-label fw-bold d-block mb-2">3. 세부 내용(회차 정보) 변경 희망 여부</label>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="changeDetail" value="no" id="changeNo" checked>
                <label class="form-check-label" for="changeNo">아니오 - 동일한 내용으로 회차 여러 개 생성 가능</label>
            </div>
            <div class="form-check">
                <input class="form-check-input" type="radio" name="changeDetail" value="yes" id="changeYes">
                <label class="form-check-label" for="changeYes">네 - 내용 변경된 회차 1개 생성 가능</label>
            </div>
        </div>

        <div class="text-end">
            <button type="submit" class="btn btn-primary px-4">다음</button>
        </div>
    </form>
</section>

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
