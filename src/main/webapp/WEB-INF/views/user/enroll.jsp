<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<section class="bg-body-tertiary py-5">
	<div class="container">
		<div class="row justify-content-center g-4">

			<!-- 유저 회원가입 -->
			<div class="col-12 col-sm-6 col-md-5 col-lg-4">
				<div class="bg-white p-5 rounded-4 shadow-sm text-center h-100 d-flex flex-column justify-content-between">
					<form method="get" action="<%=request.getContextPath()%>/user/enrolluser">
						<img src="<%=request.getContextPath()%><%=Constants.IMAGE_FILE_PATH%>/groom_2920507.png"
							 alt="유저" width="90" class="mb-4">
						<h5 class="fw-semibold mb-2">유저 회원가입</h5>
						<p class="text-muted small mb-4">개인 사용자를 위한 회원가입</p>
						<div class="mt-auto">
							<button class="btn btn-primary rounded-pill px-4 py-2" type="submit">회원가입</button>
						</div>
					</form>
				</div>
			</div>

			<!-- 기업 회원가입 -->
			<div class="col-12 col-sm-6 col-md-5 col-lg-4">
				<div class="bg-white p-5 rounded-4 shadow-sm text-center h-100 d-flex flex-column justify-content-between">
					<form method="get" action="<%=request.getContextPath()%>/company/enrollcompany">
						<img src="<%=request.getContextPath()%><%=Constants.IMAGE_FILE_PATH%>/edu_4943347.png"
							 alt="기업" width="90" class="mb-4">
						<h5 class="fw-semibold mb-2">기업 회원가입</h5>
						<p class="text-muted small mb-4">기업 고객 전용 회원가입</p>
						<div class="mt-auto">
							<button class="btn btn-primary rounded-pill px-4 py-2" type="submit">회원가입</button>
						</div>
					</form>
				</div>
			</div>

		</div>
	</div>
</section>
<style>
body {
	height: 100%;
}

.login-wrapper {
	display: flex;
	justify-content: center;
	align-items: flex-start;
	gap: 2rem;
	margin-top: 50px;
}

.form-signin {
	width: 400px;
	max-width: 100%;
	min-height: 400px;
	padding: 1rem;
	border: 1px solid #ddd;
	border-radius: 8px;
	background-color: #f9f9f9;
	display: flex;
	justify-content: center;
	align-items: center;
}

.form-signin form {
	width: 100%;
}

.form-signin img {
	display: block;
	margin: 0 auto 1rem auto;
}

.form-signin h1 {
	text-align: center;
}

.login-btn {
	display: block;
	margin: 3.5rem auto 0 auto;
	width: 150px;
}
</style>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>