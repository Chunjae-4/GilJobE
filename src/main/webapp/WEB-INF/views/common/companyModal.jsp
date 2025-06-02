<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<script>
$(document).ready(function() {
  // 기업 - 인증번호 요청
  $('#findCompanyPwForm').on('submit', function(e) {

    const companyId = $('#findPwCompanyId').val();
    const companyEmail = $('#findPwCompanyEmail').val();
    e.preventDefault();

    $.ajax({  
      url: "<%=request.getContextPath()%>/company/sendmail",
      type: "POST",
      data: {
        "comId": companyId,
        "comEmail": companyEmail
      },
      dataType: 'html',
      success: function(response) {
        if (response.trim() === "success") {
          alert('인증번호가 이메일로 발송되었습니다');
          $('#findCompanyPwModal').modal('hide');
          $('#insertCompanyNumModal').modal('show');
        } else {
          alert('아이디와 이메일이 일치하는 기업 회원이 없습니다');
        }
      },
      error: function(xhr, status, error) {
        alert('요청 중 오류가 발생했습니다.');
      }
    });
  });

  // 기업 - 인증번호 검증
  $('#verifyCompanyCodeForm').on('submit', function(e) {
    e.preventDefault();

    const verifyCode = $('#verifyCompanyCode').val();

    $.ajax({
      url: "<%=request.getContextPath()%>/company/checkAuthNum",
      type: "POST",
      data: { "verifyCompanyCode": verifyCode },
      dataType: "html",
      success: function(response) {
        if (response.trim() === "success") {
          alert('인증 완료! 비밀번호를 재설정 하세요.');
          $('#insertCompanyNumModal').modal('hide');     
          $('#resetCompanyPwModal').modal('show');    
        } else {
          alert('인증번호가 일치하지 않습니다. 다시 확인해주세요.');
        }
      },
      error: function() {
        alert('인증번호 확인 중 오류가 발생했습니다.');
      }
    });
  });

  // 기업 - 비밀번호 재설정
  $('#resetCompanyPwForm').on('submit', function(e) {
    e.preventDefault();

    const resetCompanyPw = $('#resetCompanyPw').val();
    const checkResetCompanyPw = $('#checkResetCompanyPw').val();

    if (!PwCompanyValidationForm()) return;

    $.ajax({
      url: "<%=request.getContextPath()%>/company/updatePw",
      type: "POST",
      data: {
        "resetCompanyPw": resetCompanyPw,
        "checkResetCompanyPw": checkResetCompanyPw
      },
      dataType: "html",
      success: function(response) {
        if (response.trim() === "success") {
          alert('비밀번호가 성공적으로 재설정되었습니다.');
          $('#resetCompanyPwModal').modal('hide');
        } else {
          alert('비밀번호 재설정에 실패했습니다. 다시 시도해주세요.');
        }
      },
      error: function() {
        alert('비밀번호 재설정 중 오류가 발생했습니다.');
      }
    });
  });

  // 비밀번호 검증 함수 (기업용)
  const PwCompanyValidationForm = () => {
    const resetCompanyPw = $("#resetCompanyPw").val().trim();
    const checkResetCompanyPw = $("#checkResetCompanyPw").val().trim();
    const pwReg = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\/\-]).{8,}$/;

    if (!pwReg.test(resetCompanyPw)) {
      alert("비밀번호는 영문, 숫자, 특수문자를 하나씩 포함한 8자 이상이어야 합니다.");
      $("#resetCompanyPw").focus();
      return false;
    }
    if (resetCompanyPw !== checkResetCompanyPw) {
      alert("비밀번호 확인이 일치하지 않습니다.");
      $("#checkResetCompanyPw").focus();
      return false;
    }
    return true;
  }
});
</script>

<!-- 기업 비밀번호 찾기 모달 -->
<div class="modal fade" id="findCompanyPwModal" tabindex="-1" aria-labelledby="findPwCompanyModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="findCompanyPwModalLabel">비밀번호 찾기 (기업)</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
		  <form id="findCompanyPwForm" method="post">
		    <div class="mb-3">
		      <label for="companyId" class="form-label">아이디</label>
		      <input type="text" class="form-control" id="findPwCompanyId" name="companyId" required>
		    </div>
		    <div class="mb-3">
		      <label for="companyEmail" class="form-label">이메일</label>
		      <input type="email" class="form-control" id="findPwCompanyEmail" name="companyEmail" required>
		    </div>
		    <div class="modal-footer">
		      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		      <button type="submit" class="btn btn-primary">인증번호 받기</button>
		    </div>
		  </form>
		</div>
	  </div>
    </div>
  </div>

<!-- 인증번호 입력 모달 (기업) -->
<div class="modal fade" id="insertCompanyNumModal" tabindex="-1" aria-labelledby="insertCompanyNumModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <form id="verifyCompanyCodeForm" class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="insertCompanyNumModalLabel">인증번호 입력 (기업)</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        <div class="mb-3">
          <label for="verifyCompanyCode" class="form-label">이메일로 받은 인증번호를 입력하세요</label>
          <input type="text" class="form-control" id="verifyCompanyCode" name="verifyCompanyCode" required>
        </div>
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-primary">확인</button>
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </form>
  </div>
</div>

<!-- 비밀번호 재설정 모달 (기업) -->
<div class="modal fade" id="resetCompanyPwModal" tabindex="-1" aria-labelledby="resetCompanyPwModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <form id="resetCompanyPwForm" method="post" class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="resetCompanyPwModalLabel">비밀번호 재설정 (기업)</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        <div class="mb-3">
          <label for="resetCompanyPw" class="form-label">새 비밀번호</label>
          <input type="password" class="form-control" id="resetCompanyPw" name="resetCompanyPw" required>
        </div>
        <div class="mb-3">
          <label for="confirmResetCompanyPw" class="form-label">새 비밀번호 확인</label>
          <input type="password" class="form-control" id="checkResetCompanyPw" name="checkResetCompanyPw" required>
        </div>
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-primary">재설정</button>
        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </form>
  </div>
</div>

