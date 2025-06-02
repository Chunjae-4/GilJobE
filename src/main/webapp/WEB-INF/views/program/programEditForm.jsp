<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"
    import="com.giljobe.common.Constants, com.giljobe.common.ProCategory, com.giljobe.program.model.dto.Program" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
    Program program = (Program) request.getAttribute("program");
    String selectedCategory = program.getProCategory();
%>

<h2 class="my-4">프로그램 수정</h2>

<form action="<%=request.getContextPath()%>/program/edit-submit" method="post" enctype="multipart/form-data">
    <input type="hidden" name="proNo" value="<%=program.getProNo()%>">

    <!-- 프로그램명 -->
    <div class="mb-3">
        <label class="form-label">📌 프로그램명 *</label>
        <input type="text" name="proName" class="form-control" value="<%=program.getProName()%>" required>
    </div>

    <!-- 직업 유형 -->
    <div class="mb-3">
        <label class="form-label">👨‍💻 직업 유형 *</label>
        <input type="text" name="proType" class="form-control" value="<%=program.getProType()%>" required>
    </div>

    <!-- 체험 지역 -->
    <div class="mb-3">
        <label class="form-label">📍 체험 지역 (도로명주소[+ 건물명]) *</label>
        <input type="text" name="proLocation" class="form-control" value="<%=program.getProLocation()%>" required readonly>
    </div>

    <!-- 카테고리 선택 -->
    <div class="mb-3">
        <label class="form-label">🧭 직업 유형 분류 *</label>
        <select name="proCategory" class="form-select" required>
            <option disabled>-- 선택 --</option>
            <%
                for (ProCategory cat : ProCategory.values()) {
                    boolean isSelected = cat.name().equals(selectedCategory);
            %>
                <option value="<%=cat.name()%>" <%=isSelected ? "selected" : ""%>>
                    <%=cat.name().replace("_", " ")%>
                </option>
            <%
                }
            %>
        </select>
    </div>

    <!-- 대표 이미지 업로드 및 미리보기 -->
    <div class="mb-3">
        <label class="form-label">🖼 대표 이미지 *</label><br>
        <img id="imagePreview" 
             src="<%=request.getContextPath()%>/resources/upload/<%=program.getProImageUrl()%>" 
             width="200" class="mb-2"><br>
        <input type="file" name="proImage" class="form-control" accept="image/*" onchange="previewImage(event)">
        <small class="text-muted">이미지를 선택하면 미리보기가 즉시 반영됩니다.</small>
    </div>

    <div class="mt-4 d-flex gap-2">
        <button type="submit" class="btn btn-primary">수정 완료</button>
        <a href="<%=request.getContextPath()%>/program/detail?proNo=<%=program.getProNo()%>" class="btn btn-secondary">수정 취소</a>
    </div>
</form>

<!-- 주소 검색 팝업 -->
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script>
    function openAddressSearch() {
        new daum.Postcode({
            oncomplete: function(data) {
                let fullAddr = data.roadAddress || data.jibunAddress;
                if (data.buildingName !== '') {
                    fullAddr += ' ' + data.buildingName;
                }
                document.querySelector("input[name='proLocation']").value = fullAddr;
            }
        }).open();
    }

    // 주소 input 클릭 시 팝업 실행
    document.addEventListener("DOMContentLoaded", function() {
        const locationInput = document.querySelector("input[name='proLocation']");
        locationInput.addEventListener("click", openAddressSearch);
    });
</script>

<!-- 이미지 미리보기 -->
<script>
    function previewImage(event) {
        const reader = new FileReader();
        reader.onload = function(e) {
            document.getElementById('imagePreview').src = e.target.result;
        };
        reader.readAsDataURL(event.target.files[0]);
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
