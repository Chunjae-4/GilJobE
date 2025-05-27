<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<section id="content">

	<div class="login-wrapper d-flex justify-content-center gap-4">
		<main class="form-signin">
			<form method="get" action="<%=request.getContextPath()%>/user/enrolluser">
				<img class="mb-4"
					src="<%=request.getContextPath()%><%=Constants.IMAGE_FILE_PATH%>/groom_2920507.png"
					alt="유저" width="100" height="100">
				<h1 class="h3 mb-3 fw-normal">유저 회원가입</h1>

				<button class="btn btn-primary login-btn" type="submit">회원가입</button>
			
			</form>
		</main>

		<main class="form-signin">
			<form method="get" action="<%=request.getContextPath()%>/company/enrollcompany">
				<img class="mb-4"
					src="<%=request.getContextPath()%><%=Constants.IMAGE_FILE_PATH%>/edu_4943347.png"
					alt="기업" width="100" height="100">
				<h1 class="h3 mb-3 fw-normal">기업 회원가입</h1>

				<button class="btn btn-primary login-btn" type="submit">회원가입</button>
			</form>
		</main>
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