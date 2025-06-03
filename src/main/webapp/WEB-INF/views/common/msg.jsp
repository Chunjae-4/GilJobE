<%@ page import="com.giljobe.common.Constants" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>알림</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<link rel="icon" type="image/png" sizes="32x32" href="<%=request.getContextPath()%><%=Constants.IMAGE_FILE_PATH%>/favicon-32x32.png">
	<style>
		body {
			background-color: rgba(246, 233, 215, 0.15); /* 기존 감성 배경과 조화 */
		}
	</style>
	<script>
		setTimeout(function () {
			location.replace("<%=request.getContextPath()%><%=request.getAttribute("loc")%>");
		}, 2500); // 2.5초 후 자동 이동
	</script>
</head>
<body class="d-flex justify-content-center align-items-center vh-100">

<!-- 카드형 알림 박스 -->
<div class="card shadow-sm border-0 rounded-4" style="max-width: 480px; width: 90%;">
	<div class="card-body text-center px-4 py-5">
		<h5 class="card-title fw-bold text-primary mb-3">🔔 안내 메시지</h5>
		<p class="card-text fs-5 text-dark mb-3"><%= request.getAttribute("msg") %></p>
		<p class="text-muted small mb-0">잠시 후 자동으로 이동합니다...</p>
	</div>
</div>

</body>
</html>
