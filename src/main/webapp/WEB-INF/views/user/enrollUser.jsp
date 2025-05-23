<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>


<div class="form-wrapper">
	<form action="<%=request.getContextPath() %>/user/enrolluserend" method="post">
		<div class="mb-3">
			<label for="name" class="form-label">이름</label>
			<input type="text" class="form-control" name="userName">
		</div>
		<div class="mb-3">
			<label for="id" class="form-label">아이디</label>
			<input type="text" class="form-control" name="userId">
		</div>
		<div class="mb-3">
			<label for="Password" class="form-label">비밀번호</label>
			<input type="password" class="form-control" name="userPw">
		</div>
		<div class="mb-3">
			<label for="checkPassword" class="form-label">비밀번호 확인</label>
			<input type="password" class="form-control" name="checkPw">
		</div>
		<div class="mb-3">
			<label for="checkPassword" class="form-label">전화번호</label>
			<input type="text" class="form-control" name="userPhone">
		</div>
		<div class="mb-3">
			<label for="nickname" class="form-label">닉네임</label>
			<input type="text" class="form-control" name="userNickName">
		</div>
		<div class="mb-3">
			<label for="checkPassword" class="form-label">이메일</label>
			<input type="email" class="form-control" name="userEmail">
		</div>
		<div class="mb-3">
			<label for="checkPassword" class="form-label">생년월일</label>
			<input type="date" class="form-control" name="userBirth">
		</div>

		<button type="submit" class="btn btn-primary">가입</button>
	</form>
</div>

<style>
.form-wrapper {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 500px; /* 화면 전체 높이 */
}

form {
	width: 100%;
	max-width: 400px; /* 조절 가능 */
	padding: 2rem;
	border: 1px solid #ddd;
	border-radius: 8px;
	background-color: #f9f9f9;
}
</style>

<%@ include file="/WEB-INF/views/common/footer.jsp"%>