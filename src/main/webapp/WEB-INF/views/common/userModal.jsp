<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<script>
$(document).ready(function() {
	$('#findPwForm').on('submit', function(e) {

		const userId = document.getElementById('findPwUserId').value;
		const userEmail = document.getElementById('findPwEmail').value;
	    
		e.preventDefault();
	    
		 $.ajax({	
		        url: "<%=request.getContextPath()%>/user/sendmail",
		        type: "POST",
		        data: {
		            "userId": userId,
		            "userEmail": userEmail
		        },
		        dataType: 'html', // 변경: html로 받음
		        success: function(response) {
		            // response는 서블릿에서 보내는 html 문자열
		            if (response.trim() === "success") {
		                alert('인증번호가 이메일로 발송되었습니다');
		                $('#findPwModal').modal('hide');
		                $('#insertNumModal').modal('show');
		            } else {
		                alert('아이디와 이메일이 일치하는 회원이 없습니다');
		            }
		        },
		        error: function(xhr, status, error) {
		            alert('요청 중 오류가 발생했습니다.');
		        }
		    });
	});
});
$(document).ready(function() {
	$('#verifyCodeForm').on('submit', function(e) {
	    e.preventDefault();
	    const verifyCode = $('#verifyCode').val();

	    $.ajax({
	        url: "<%=request.getContextPath()%>/user/checkAuthNum",
	        type: "POST",
	        data: { "verifyCode": verifyCode },
	        dataType: "html",
	        success: function(response) {
	            if (response.trim() === "success") {
	                alert('인증 완료! 비밀번호를 재설정 하세요.');
	                $('#insertNumModal').modal('hide');     
	                $('#resetPwModal').modal('show');    
	            } else {
	                alert('인증번호가 일치하지 않습니다. 다시 확인해주세요.');
	            }
	        },
	        error: function() {
	            alert('인증번호 확인 중 오류가 발생했습니다.');
	        }
	    });
	});
});
$(document).ready(function() {

	$('#resetPwForm').on('submit', function(e) {
	    e.preventDefault();
	    
	    const resetPw = $('#resetPw').val();
        const checkResetPw = $('#checkResetPw').val();

        if (!PwvalidationForm()) return;
        
	    $.ajax({
	        url: "<%=request.getContextPath()%>/user/updatePw" ,
	        type: "POST",
	        data: {
                "resetPw" : resetPw,
                "checkResetPw" : checkResetPw
            },
	        dataType: "html",
	        success: function(response) {
	        	if (response.trim() === "success") {
                    alert('비밀번호가 성공적으로 재설정되었습니다.');
                    $('#resetPwModal').modal('hide');
                } else {
                    alert('비밀번호 재설정에 실패했습니다. 다시 시도해주세요.');
                }
            },
	        error: function() {
	            alert('인증번호 확인 중 오류가 발생했습니다.');
	        }
	    });
	});
});
	const pwReg = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\/\-]).{8,}$/;
	
	const PwvalidationForm=()=>{
		const resetPw = $("#resetPw").val().trim();
		const checkResetPw = $("#checkResetPw").val().trim();
		if(!pwReg.test(resetPw)){
			 alert("비밀번호는 영문, 숫자, 특수문자를 하나씩 포함한 8자 이상이어야 합니다.");
			 $("#resetPw").focus();
			 return false;
		}
		if(resetPw !== checkResetPw){
			 alert("비밀번호 확인이 일치하지 않습니다.");
			 $("#checkResetPw").focus();		
			 return false;
		}
		return true;
	}
</script>

<!-- 유저 비밀번호 찾기 모달 -->
<div class="modal fade" id="findPwModal" tabindex="-1" aria-labelledby="findPwModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="findPwModalLabel">비밀번호 찾기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="findPwForm" method="post">
          <div class="mb-3">
            <label for="findPwUserId" class="form-label">아이디</label>
            <input type="text" class="form-control" id="findPwUserId" name="userId" required>
          </div>
          <div class="mb-3">
            <label for="findPwEmail" class="form-label">이메일</label>
            <input type="email" class="form-control" id="findPwEmail" name="userEmail" required>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="submit" form="findPwForm" class="btn btn-primary">인증번호 받기</button>
      </div>
    </div>
  </div>
</div>

<!-- 인증번호 입력 모달 -->
<div class="modal fade" id="insertNumModal" tabindex="-1" aria-labelledby="insertNumModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <form id="verifyCodeForm" class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="insertNumModalLabel">인증번호 입력</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        <div class="mb-3">
          <label for="verifyCode" class="form-label">이메일로 받은 인증번호를 입력하세요</label>
          <input type="text" class="form-control" id="verifyCode" name="verifyCode" required>
        </div>
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-primary">확인</button>
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </form>
  </div>
</div>


<!-- 비밀번호 재설정 모달 -->
<div class="modal fade" id="resetPwModal" tabindex="-1" aria-labelledby="resetPwModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <form id="resetPwForm" method="post" class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="resetPwModalLabel">비밀번호 재설정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        <div class="mb-3">
          <label for="newResetPw" class="form-label">새 비밀번호</label>
          <input type="password" class="form-control" id="resetPw" name="resetPw" required>
        </div>
        <div class="mb-3">
          <label for="confirmResetPw" class="form-label">새 비밀번호 확인</label>
          <input type="password" class="form-control" id="checkResetPw" name="checkResetPw" required>
        </div>
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-primary">재설정</button>
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </form>
  </div>
</div>