<%@page import="com.giljobe.user.model.dto.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%
	User loginUser = (User)session.getAttribute("user");
%>
<section class="form-wrapper">
	<form action="<%=request.getContextPath()%>/user/updateUser"
		method="post" onsubmit="return validateForm()">
		<div class="mb-3">
			<label for="name" class="form-label">이름<span
				style="color: red">*</span></label> <input type="text" class="form-control"
				name="userName" placeholder="개명하셨나요?" value="<%=loginUser.getUserName() %>" required>
		</div>
		<div class="mb-3">
			<label for="id" class="form-label">아이디<span
				style="color: red">*</span></label> <input type="text" class="form-control"
				name="userId" id="userId"
				value="<%=loginUser.getUserId() %>" readonly>
		</div>
		<div class="mb-3">
			<label for="phone" class="form-label">전화번호<span
				style="color: red">*</span></label> <input type="text" class="form-control"
				name="userPhone" placeholder="'-'제외하고 입력" id="userPhone" value="<%=loginUser.getUserPhone() %>" required>
		</div>
		<div class="mb-3">
			<label for="nickname" class="form-label">닉네임<span
				style="color: red">*</span></label> <input
				type="text" class="form-control" name="userNickName" id="userNickName"
				placeholder="최대 10자 까지 입력(특수문자 입력불가)" value = "<%=loginUser.getUserNickName() %>" required>
		</div>
		<div class="mb-3">
			<label for="email" class="form-label">이메일<span
				style="color: red">*</span></label> <input type="email" class="form-control"
				name="userEmail" placeholder="user@email.com" value="<%=loginUser.getUserEmail() %>" required>
		</div>
		<div class="mb-3">
			<label for="birth" class="form-label">생년월일<span
				style="color: red">*</span></label> <input type="date" class="form-control"
				name="userBirth" value= "<%=loginUser.getUserBirth()%>" required>
		</div>
		<input type="submit" value="회원 정보 수정" id="submitBtn"> 
	</form>
	<input type="button" id="pwsubmitBtn"
				value="비밀번호수정"> 
</section>
<script>
	const numonly = /[^0-9]/g; //문자가 있니 없니
	
	const validateForm=()=>{
				const userPhone = $("#userPhone").val().trim();
				
				if(numonly.test(userPhone)){ // 문자 없으면 false 잘썻으면 false !때문에 true
					alert("전화번호 형식에 맞지 않습니다. -를 제외한 숫자만 입력해주세요.");
					$("#userPhone").focus();
					return false;
				}
				
				return true;
		}
		
</script>


<style>
.form-wrapper {
  max-width: 500px;
  margin: 0 auto;
  min-height: calc(100vh - 210px); /* 화면 전체 높이 - (header+footer 높이) */
  background-color: #f9f9f9;
  padding: 2rem;
  border: 1px solid #ddd;
  border-radius: 8px;
  box-sizing: border-box;
}

</style>