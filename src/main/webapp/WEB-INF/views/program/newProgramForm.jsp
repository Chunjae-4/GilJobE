<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8"
	import="com.giljobe.common.Constants, com.giljobe.common.ProCategory"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="container py-5">
    <div class="mb-4 text-center">
        <h2 class="fw-bold">새로운 프로그램 등록</h2>
        <p class="text-muted">기본 정보를 입력하고, 다음 단계에서 회차를 추가해요.</p>
    </div>

    <form action="<%=request.getContextPath()%>/program/insert" method="post" enctype="multipart/form-data"
          class="bg-white p-4 rounded-4 shadow-sm">

        <!-- 프로그램명 -->
        <div class="mb-4">
            <label class="form-label fw-semibold">📌 프로그램명 *</label>
            <input type="text" name="proName" class="form-control" placeholder="예: 미래 요리사 체험" required>
        </div>

        <!-- 직업 유형 -->
        <div class="mb-4">
            <label class="form-label fw-semibold">👨‍💻 직업 유형 *</label>
            <input type="text" name="proType" class="form-control" placeholder="예: 요리사, 바리스타 등" required>
        </div>

        <!-- 체험 지역 -->
        <div class="mb-4">
            <label class="form-label fw-semibold">📍 체험 지역 *</label>
            <input type="text" name="proLocation" class="form-control" placeholder="주소 검색을 클릭하세요" required readonly>
            <div class="form-text">주소는 도로명 주소 기준으로 입력됩니다.</div>
        </div>

        <!-- 직업 카테고리 -->
        <div class="mb-4">
            <label class="form-label fw-semibold">🧭 직업 분류 *</label>
            <select name="proCategory" class="form-select" required>
                <option disabled selected>-- 선택 --</option>
                <%
                    for (ProCategory cat : ProCategory.values()) {
                %>
                <option value="<%=cat.name()%>"><%=cat.name().replace("_", " ")%></option>
                <%
                    }
                %>
            </select>
        </div>

        <!-- 대표 이미지 -->
        <div class="mb-4">
            <label class="form-label fw-semibold">🖼 대표 이미지 *</label>
            <input type="file" name="programImage" class="form-control" accept="image/*" required>
            <div class="form-text">대표 이미지는 1장만 업로드해주세요. (JPG, PNG 권장)</div>
        </div>

        <div class="text-end">
            <button type="submit" class="btn btn-success px-4">회차 입력으로 이동 →</button>
        </div>
    </form>
</section>

<script src="https://unpkg.com/@egjs/jquery-pa" defer></script>
<!-- 네이버 주소 검색 API -->
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<script>
    function openAddressSearch() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 기본 주소 (도로명/지번 중 선택된 것)
                let fullAddr = data.roadAddress || data.jibunAddress;

                // 건물명 추가
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
        locationInput.setAttribute("readonly", true); // 수동 입력 방지
        locationInput.addEventListener("click", openAddressSearch);
    });
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>