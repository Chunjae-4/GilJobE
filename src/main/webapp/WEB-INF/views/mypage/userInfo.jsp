<%@page import="com.giljobe.user.model.dto.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%
	User loginUser = (User)session.getAttribute("user");
%>
<h4 class="fw-bold mb-2">내 정보 수정</h4>
<p class="text-muted mb-4" style="font-size: 0.95rem;">회원가입 시 입력한 정보를 확인하고 수정할 수 있어요.</p>

<form action="<%=request.getContextPath()%>/user/updateUser" method="post" onsubmit="return validateForm()">
	<div class="row gy-4">

		<!-- 아이디 -->
		<div class="col-12">
			<label for="userId" class="form-label">아이디 <span class="text-danger">*</span></label>
			<input type="text" class="form-control" id="userId" name="userId"
				   value="<%=loginUser.getUserId()%>" readonly>
			<div class="form-text text-muted">아이디는 변경할 수 없습니다.</div>
		</div>

		<!-- 이름 -->
		<div class="col-12">
			<label for="userName" class="form-label">이름 <span class="text-danger">*</span></label>
			<input type="text" class="form-control" name="userName" maxlength="5"
				   value="<%=loginUser.getUserName()%>" required>
		</div>

		<!-- 전화번호 -->
		<div class="col-12">
			<label for="userPhone" class="form-label">전화번호 <span class="text-danger">*</span></label>
			<input type="text" class="form-control" name="userPhone" maxlength="11"
				   placeholder="예: 01012345678"
				   value="<%=loginUser.getUserPhone()%>" required>
		</div>

		<!-- 닉네임 -->
		<div class="col-12">
			<label for="userNickName" class="form-label">닉네임 <span class="text-danger">*</span></label>
			<input type="text" class="form-control" name="userNickName" maxlength="10"
				   value="<%=loginUser.getUserNickName()%>" required>
		</div>

		<!-- 이메일 -->
		<div class="col-12">
			<label for="userEmail" class="form-label">이메일 <span class="text-danger">*</span></label>
			<input type="email" class="form-control" name="userEmail"
				   value="<%=loginUser.getUserEmail()%>" required>
		</div>

		<!-- 생년월일 -->
		<div class="col-12">
			<label for="userBirth" class="form-label">생년월일 <span class="text-danger">*</span></label>
			<input type="date" class="form-control" name="userBirth"
				   value="<%=loginUser.getUserBirth()%>" required>
		</div>

		<!-- 버튼 -->
		<div class="col-12 d-flex justify-content-end gap-2 mt-3">
			<button type="submit" class="btn btn-primary px-4 py-2 rounded-pill">정보 수정</button>
			<button type="button" class="btn btn-outline-secondary px-4 py-2 rounded-pill"
      		  data-bs-toggle="modal" data-bs-target="#changePwModal">비밀번호 변경</button>
		</div>
	</div>
</form>
<!-- 비밀번호 변경 모달 -->
<div class="modal fade" id="changePwModal" tabindex="-1" aria-labelledby="changePwModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <form action="<%=request.getContextPath()%>/user/updatePw" method="post" class="modal-content" onsubmit="return PwvalidationForm()">
      <div class="modal-header">
        <h5 class="modal-title" id="changePwModalLabel">비밀번호 변경</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        <div class="mb-3">
          <label for="userPw" class="form-label">현재 비밀번호</label>
          <input type="password" class="form-control" id="userPw" name="userPw" required>
        </div>
        <div class="mb-3">
          <label for="newPw" class="form-label">새 비밀번호</label>
          <input type="password" class="form-control" id="newPw" name="newPw" required>
        </div>
        <div class="mb-3">
          <label for="checkPw" class="form-label">새 비밀번호 확인</label>
          <input type="password" class="form-control" id="checkPw" name="checkPw" required>
        </div>
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-primary px-4 py-2 rounded-pill">변경</button>
        <button type="button" class="btn btn-outline-secondary px-4 py-2 rounded-pill" data-bs-dismiss="modal">취소</button>
      </div>
    </form>
  </div>
</div>
<script>
	const numonly = /[^0-9]/g; //문자가 있니 없니
	const pwReg = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\/\-]).{8,}$/;
	
	const validateForm=()=>{
				const userPhone = $("#userPhone").val().trim();
				
				if(numonly.test(userPhone)){ // 문자 없으면 false 잘썻으면 false !때문에 true
					alert("전화번호 형식에 맞지 않습니다. -를 제외한 숫자만 입력해주세요.");
					$("#userPhone").focus();
					return false;
				}
				
				return true;
		}
	const PwvalidationForm=()=>{
		const newPw = $("#newPw").val().trim();
		const checkPw = $("#checkPw").val().trim();
		if(!pwReg.test(newPw)){
			 alert("비밀번호는 영문, 숫자, 특수문자를 하나씩 포함한 8자 이상이어야 합니다.");
			 $("#newPw").focus();
			 return false;
		}
		if(newPw !== checkPw){
			 alert("비밀번호 확인이 일치하지 않습니다.");
			 $("#checkPw").focus();		
			 return false;
		}
		return true;
	}
		
</script>

