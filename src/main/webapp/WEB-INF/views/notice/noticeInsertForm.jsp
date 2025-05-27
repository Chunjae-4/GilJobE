<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"
         import="com.giljobe.common.Constants" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="bg-body-tertiary py-5">
    <div class="container" style="max-width: 720px;">
        <!-- 타이틀 -->
        <div class="mb-4">
            <h2 class="fw-bold">공지사항 작성</h2>
            <p class="text-muted">공지할 내용을 입력한 후 등록 버튼을 눌러주세요.</p>
        </div>

        <!-- 작성 폼 -->
        <form action="<%=request.getContextPath()%>/notice/insertend" method="post">
            <div class="bg-white p-4 rounded-4 shadow-sm">

                <!-- 제목 -->
                <div class="mb-4">
                    <label for="title" class="form-label fw-semibold">제목</label>
                    <input type="text" id="title" name="title" class="form-control form-control-lg" placeholder="공지 제목을 입력하세요" required>
                </div>

                <!-- 내용 -->
                <div class="mb-4">
                    <label for="content" class="form-label fw-semibold">내용</label>
                    <textarea id="content" name="content" rows="10" class="form-control form-control-lg" placeholder="공지 내용을 입력하세요" required></textarea>
                </div>

                <!-- 버튼 그룹 -->
                <div class="d-flex justify-content-between">
                    <a href="<%=request.getContextPath()%>/notice/noticelist" class="btn btn-outline-secondary rounded-pill px-4">
                        ← 목록으로 돌아가기
                    </a>
                    <button type="submit" class="btn btn-primary rounded-pill px-4">
                        등록하기
                    </button>
                </div>
            </div>
        </form>
    </div>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
