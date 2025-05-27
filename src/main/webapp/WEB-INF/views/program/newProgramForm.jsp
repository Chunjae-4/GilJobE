<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8"
	import="com.giljobe.common.Constants, com.giljobe.common.ProCategory"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<h2 class="my-4">새로운 프로그램 등록</h2>

<form action="<%=request.getContextPath()%>/program/insert" method="post" enctype="multipart/form-data">
    <!-- 프로그램명 -->
    <div class="mb-3">
        <label class="form-label">📌 프로그램명 *</label>
        <input type="text" name="proName" class="form-control" required>
    </div>

    <!-- 직업 유형 -->
    <div class="mb-3">
        <label class="form-label">👨‍💻 직업 유형 *</label>
        <input type="text" name="proType" class="form-control" required>
    </div>

    <!-- 체험 지역 -->
    <div class="mb-3">
        <label class="form-label">📍 체험 지역 (도로명주소[+ 건물명]) *</label>
        <input type="text" name="proLocation" class="form-control" required>
    </div>

    <!-- 카테고리 선택 -->
    <div class="mb-3">
        <label class="form-label">🧭 직업 유형 분류 *</label>
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

    <!-- 대표 이미지 업로드 -->
    <div class="mb-3">
        <label class="form-label">🖼 대표 이미지 *</label>
        <input type="file" name="programImage" class="form-control" accept="image/*" required>
        <small class="text-muted">대표 이미지는 1개만 업로드 가능합니다.</small>
    </div>

    <button type="submit" class="btn btn-success">회차 입력으로 이동 →</button>
</form>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>