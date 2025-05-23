<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>


<div class="form-wrapper">
	<form>
		<div class="mb-3">
			<label for="nickname" class="form-label">닉네임</label> <input
				type="text" class="form-control" id="nickname">
		</div>
		<div class="mb-3">
			<label for="id" class="form-label">아이디</label> <input type="text"
				class="form-control" id="id">
		</div>
		<div class="mb-3">
			<label for="Password" class="form-label">비밀번호</label> <input
				type="password" class="form-control" id="Password">
		</div>
		<div class="mb-3">
			<label for="checkPassword" class="form-label">비밀번호 확인</label> <input
				type="password" class="form-control" id="checkPassword">
		</div>
		<div class="mb-3">
			<label for="checkPassword" class="form-label">전화번호</label> <input
				type="number" class="form-control" id="checkPassword">
		</div>
		<div class="mb-3">
			<label for="checkPassword" class="form-label">이메일</label> <input
				type="email" class="form-control" id="checkPassword">
		</div>
		<div class="mb-3">
			<label for="checkPassword" class="form-label">생년월일</label> <input
				type="number" class="form-control" id="checkPassword">
		</div>

		<button type="submit" class="btn btn-primary">Submit</button>
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