<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>
<%@ page import="com.giljobe.notice.model.dto.Notice" %>
<%@ page import="java.util.List" %>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<% List<Notice> noticeList = (List<Notice>) request.getAttribute("noticeList");
	int pageStart = (int) request.getAttribute("pageStart");
	int pageEnd = (int) request.getAttribute("pageEnd");
	int totalPage = (int) request.getAttribute("totalPage");
	int cPage = (int) request.getAttribute("cPage");
	String pageUri = (String) request.getAttribute("pageUri");
%>

<section class="py-5 mb-4 bg-body-tertiary">
	<div class="container">

		<!-- 상단 제목 및 등록 버튼 -->
		<div class="mb-4 text-center">
			<h1 class="fw-semibold mb-3">공지사항</h1>
			<p class="lead text-muted fst-italic">길잡이의 최신 소식을 확인해보세요.</p>
			<% if (loginUser != null && loginUser.getUserRoleNo() == 1) { %>
			<div class="mt-3">
				<a href="<%=request.getContextPath()%>/notice/insertform"
				   class="btn btn-primary btn-sm px-4 py-2 rounded-pill shadow-sm">
					✏️ 공지 등록
				</a>
			</div>
			<% } %>
		</div>

		<% if (noticeList != null && !noticeList.isEmpty()) { %>

		<!-- 공지 리스트 -->
		<div class="list-group rounded-4 shadow-sm overflow-hidden bg-white">
			<% for (Notice n : noticeList) { %>
			<a href="<%=request.getContextPath()%>/notice/detail?no=<%=n.getNoticeNo()%>"
			   class="list-group-item list-group-item-action d-flex justify-content-between align-items-center px-4 py-3 border-0 border-bottom">
				<span class="fw-semibold text-dark"><%= n.getNoticeTitle() %></span>
				<span class="text-muted small"><%= n.getNoticeDate() %></span>
			</a>
			<% } %>
		</div>

		<% } else { %>
		<!-- 공지 없음 -->
		<div class="bg-white p-5 text-center rounded-4 shadow-sm mt-4">
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

		<!-- 페이징 -->
		<div class="mt-5">
			<ul class="pagination justify-content-center">
				<!-- 이전 -->
				<li class="page-item <%= (pageStart == 1 ? "disabled" : "") %>">
					<a class="page-link" href="<%= (pageStart == 1 ? "#" : pageUri + "?cPage=" + (pageStart - 1)) %>">이전</a>
				</li>

				<!-- 페이지 번호 -->
				<% for (; pageStart <= pageEnd && pageStart <= totalPage; pageStart++) { %>
				<li class="page-item <%= (pageStart == cPage ? "active" : "") %>">
					<a class="page-link" href="<%= pageUri %>?cPage=<%= pageStart %>"><%= pageStart %></a>
				</li>
				<% } %>

				<!-- 다음 -->
				<li class="page-item <%= (pageStart > totalPage ? "disabled" : "") %>">
					<a class="page-link" href="<%= (pageStart > totalPage ? "#" : pageUri + "?cPage=" + pageStart) %>">다음</a>
				</li>
			</ul>
		</div>

	</div>
</section>



<%@ include file="/WEB-INF/views/common/footer.jsp"%>

