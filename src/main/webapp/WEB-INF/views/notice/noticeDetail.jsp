<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"
         import="com.giljobe.common.Constants" %>
<%@ page import="com.giljobe.notice.model.dto.Notice" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<% Notice notice = (Notice)request.getAttribute("notice"); %>

<%if (notice != null){%>
<section class="bg-body-tertiary py-5">
    <div class="container">
        <!-- 제목 + 날짜 -->
        <div class="mb-4 pb-3 border-bottom">
            <h2 class="fw-bold mb-2 py-1"><%= notice.getNoticeTitle() %></h2>
            <div class="d-flex text-muted small">
                <span class="me-3">📅 <%= notice.getNoticeDate() %></span>
                <%-- 필요 시 작성자 표시 --%>
                 <span class="me-3">👤 Admin </span>
            </div>
        </div>

        <!-- 내용 -->
        <div class="bg-white p-4 rounded-3 shadow-sm mb-5" style="min-height: 500px;">
            <pre class="mb-0" style="white-space: pre-wrap; font-family: inherit;"><%= notice.getNoticeContent() %></pre>
        </div>

        <!-- 목록으로 돌아가기 -->
        <div class="text-end">
            <a href="<%=request.getContextPath()%>/notice/noticelist"
               class="btn btn-outline-secondary rounded-pill px-4 py-2">
                ← 목록으로 돌아가기
            </a>
        </div>
    </div>
</section>

<%--    TODO: 잘못된 접근입니다 alert--%>
<%} else {%>

<%}%>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>
