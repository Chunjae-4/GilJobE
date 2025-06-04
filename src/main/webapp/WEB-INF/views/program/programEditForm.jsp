<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"
    import="com.giljobe.common.Constants, com.giljobe.common.ProCategory, com.giljobe.program.model.dto.Program" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%
    Program program = (Program) request.getAttribute("program");
    String selectedCategory = program.getProCategory();
%>

<section class="container py-5">
    <div class="mb-4 text-center">
        <h2 class="fw-bold">프로그램 정보 수정</h2>
        <p class="text-muted">프로그램의 기본 정보를 수정할 수 있어요.</p>
    </div>

    <form action="<%=request.getContextPath()%>/program/edit-submit" method="post" enctype="multipart/form-data"
          class="bg-white p-4 rounded-4 shadow-sm">
        <input type="hidden" name="proNo" value="<%=program.getProNo()%>">

        <!-- 프로그램명 -->
        <div class="mb-4">
            <label class="form-label fw-semibold">📌 프로그램명 *</label>
            <input type="text" name="proName" class="form-control" value="<%=program.getProName()%>" required>
        </div>

        <!-- 직업 유형 -->
        <div class="mb-4">
            <label class="form-label fw-semibold">👨‍💻 직업 유형 *</label>
            <input type="text" name="proType" class="form-control" value="<%=program.getProType()%>" required>
        </div>

        <!-- 체험 지역 -->
        <div class="mb-4">
            <label class="form-label fw-semibold">📍 체험 지역 *</label>
            <input type="text" name="proLocation" class="form-control" value="<%=program.getProLocation()%>" required readonly>
            <div class="form-text">주소는 도로명 주소 기준입니다.</div>
        </div>

        <!-- 카테고리 선택 -->
        <div class="mb-4">
            <label class="form-label fw-semibold">🧭 직업 분류 *</label>
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
        <div class="mb-4">
            <label class="form-label fw-semibold">🖼 대표 이미지 *</label>
            <img id="imagePreview"
                 src="<%=request.getContextPath()%>/resources/upload/<%=program.getProImageUrl()%>"
                 class="img-thumbnail mb-2 d-block" style="max-width: 200px;">
            <input type="file" name="proImage" class="form-control" accept="image/*" onchange="previewImage(event)">
            <div class="form-text">이미지를 선택하면 미리보기가 반영됩니다.</div>
        </div>

        <div class="text-end mt-4 d-flex gap-2 justify-content-end">
            <button type="submit" class="btn btn-primary px-4">수정 완료</button>
            <a href="<%=request.getContextPath()%>/program/detail?proNo=<%=program.getProNo()%>" class="btn btn-outline-secondary">취소</a>
        </div>
    </form>
</section>

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
