<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>
<%@ page import="com.giljobe.notice.model.dto.Notice" %>
<%@ page import="java.util.List" %>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<% List<Notice> noticeList = (List<Notice>) request.getAttribute("noticeList");%>
<section class="bg-body-tertiary py-5">
	<div class="container">
		<!-- 상단 제목 + 버튼 -->
		<div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">
			<!-- 왼쪽: 제목 + 설명 -->
			<div class="col-12 col-md-auto">
				<h1 class="fw-normal mb-1">공지사항</h1>
				<p class="lead text-body-secondary mb-0">길잡이의 소식을 확인해보세요.</p>
			</div>

			<!-- 오른쪽: 등록 버튼 -->
			<% if (loginUser != null && loginUser.getUserRoleNo() == 1) { %>
			<div class="text-md-end col-12 col-md-auto">
				<a href="<%=request.getContextPath()%>/notice/insertform"
				   class="btn btn-primary btn-sm px-4 py-2 rounded-pill shadow-sm">
					✏️ 공지 등록
				</a>
			</div>
			<% } %>
		</div>

		<% if (noticeList != null && !noticeList.isEmpty()) { %>

		<!-- 리스트 헤더 -->
		<div class="bg-opacity-50 bg-secondary border rounded-3 shadow-sm px-3 py-3 d-flex justify-content-between align-items-center mb-3 ">
			<span class="fw-bold text-light">제목</span>
			<span class="fw-bold text-light">날짜</span>
		</div>

		<!-- 게시글 리스트 -->
		<div class="list-group rounded-3 overflow-hidden" style="min-height: 500px;">
			<% for (Notice n : noticeList) { %>
			<a href="<%=request.getContextPath()%>/notice/detail?no=<%=n.getNoticeNo()%>"
			   class="list-group-item list-group-item-action d-flex justify-content-between align-items-center shadow-sm">
				<span class="fw-medium text-dark"><%= n.getNoticeTitle() %></span>
				<span class="text-muted small"><%= n.getNoticeDate() %></span>
			</a>
			<% } %>
		</div>

		<% } else { %>
		<!-- 공지 없음 -->
		<div class="bg-light p-5 text-center rounded-4 shadow-sm mt-4">
			<div class="mb-2 fs-1 text-muted">📭</div>
			<h5 class="fw-light text-muted mb-1">등록된 공지사항이 없습니다</h5>
			<% if (loginUser != null && loginUser.getUserRoleNo() == 1) { %>
			<a href="<%=request.getContextPath()%>/notice/insertform"
			   class="btn btn-outline-primary rounded-pill px-4 py-2 mt-3">
				✏️ 공지 등록하러 가기
			</a>
			<% } %>
		</div>
		<% } %>
	</div>
</section>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>

