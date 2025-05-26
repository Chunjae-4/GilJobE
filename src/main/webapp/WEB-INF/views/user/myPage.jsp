<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>


<!-- 사이드바 영역 -->
<main>
	<aside>
		<div class="d-flex flex-column flex-shrink-0 p-3 bg-body-tertiary"
			style="width: 280px;">

			<span class="fs-4">Sidebar</span>

			<hr>
			<ul class="nav nav-pills flex-column mb-auto">
				<li class="nav-item"><a href="#" class="nav-link active">내
						정보 보기</a></li>
				<li><a href="#" class="nav-link link-body-emphasis" >신청 프로그램 관리</a></li>
				<li><a href="#" class="nav-link link-body-emphasis" id="love" onclick="">좋아요
						누른 글</a></li>
				<li><a href="#" class="nav-link link-body-emphasis" onclick="">문의
						내역</a></li>
				<li><a href="#" class="nav-link link-body-emphasis" onclick="">기타
						등등</a></li>
			</ul>
			<hr>
		</div>
	</aside>

	<!-- 본문 영역 -->
	<section class="p-3">
		<form action="" onsubmit="return fn_validate()">
			<table>
				<tr>
					<th>아이디</th>
					<td><input type="text" value="<%=loginUser.getUserId()%>"
						name="userId" id="userId_" readonly></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="userName" id="userName"
						value="<%=loginUser.getUserName()%>"></td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td><input type="date" name="age" id="age"
						value="<%=loginUser.getUserBirth()%>"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="email" placeholder="abc@xyz.com" name="email"
						id="email" value="<%=loginUser.getUserEmail()%>"></td>
				</tr>
				<tr>
					<th>휴대폰</th>
					<td><input type="tel" placeholder="(-없이)01012345678"
						name="phone" id="phone" maxlength="11" required
						value="<%=loginUser.getUserPhone()%>"></td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td><input type="text" placeholder="닉네임" name="nickName"
						id="nickName" value="<%=loginUser.getUserNickName()%>"></td>
				</tr>
			</table>
			<input type="submit" value="수정"> <input type="submit"
				value="비밀번호수정">
		</form>
	</section>
</main>
<style>
main {
	flex: 1;
	display: flex;
	min-height: 0; /* 내부 요소 overflow 방지 */
}

aside {
	width: 280px;
	background-color: #f8f9fa;
	padding: 1rem;
	box-sizing: border-box;
}

section {
	flex-grow: 1;
	padding: 1rem;
	overflow-y: auto;
	background-color: #fff;
}
</style>
<script>
  	
  	$("#love").click(e=>{
	location.replace("<%=request.getContextPath()%>/user/love");
	
  	
  	})
  	
  </script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>