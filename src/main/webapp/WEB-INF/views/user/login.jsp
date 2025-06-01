<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"
         import="com.giljobe.common.Constants" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
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
<section class="bg-body-tertiary py-5">
  <div class="container">
    <div class="row justify-content-center g-4">

      <!-- 유저 로그인 -->
      <div class="col-12 col-sm-6 col-md-5 col-lg-4">
        <div class="bg-white p-5 rounded-4 shadow-sm text-center h-100 d-flex flex-column justify-content-between">
          <form method="post" action="<%=request.getContextPath()%>/user/loginend" class="d-flex flex-column h-100">

            <!-- 상단 정보 -->
            <div class="mb-4">
              <img src="<%=request.getContextPath()%><%=Constants.IMAGE_FILE_PATH%>/groom_2920507.png"
                   alt="유저" width="90" class="mb-4">
              <h5 class="fw-semibold mb-2">유저 로그인</h5>
              <p class="text-muted small mb-0">개인 이용자를 위한 로그인</p>
            </div>

            <!-- 입력 필드 -->
            <div class="form-floating mb-3">
              <input type="text" class="form-control" name="userId" id="userId" placeholder="아이디"
                     value="<%=savedUser != null ? savedUser : "" %>">
              <label for="userId">아이디</label>
            </div>

            <div class="form-floating mb-3">
              <input type="password" class="form-control" name="userPw" id="userPw" placeholder="비밀번호">
              <label for="userPw">비밀번호</label>
            </div>

            <div class="form-check mb-4 text-start">
              <input class="form-check-input" type="checkbox" name="userSave" id="userSave"
                <%=savedUser != null ? "checked" : "" %>>
              <label class="form-check-label" for="userSave">아이디 저장</label>
            </div>

            <!-- 하단 버튼 & 링크 -->
            <div class="mt-auto">
              <button class="btn btn-primary w-100 py-2 rounded-pill mb-3" type="submit">로그인</button>
              <div class="d-flex justify-content-center gap-3 small text-secondary">
                <a href="<%=request.getContextPath()%>/user/searchId" class="text-decoration-none">아이디 찾기</a>
               <a href="" class="text-decoration-none" data-bs-toggle="modal" data-bs-target="#findPwModal">비밀번호 찾기</a>
              </div>
            </div>

          </form>
        </div>
      </div>

      <!-- 기업 로그인 -->
      <div class="col-12 col-sm-6 col-md-5 col-lg-4">
        <div class="bg-white p-5 rounded-4 shadow-sm text-center h-100 d-flex flex-column justify-content-between">
          <form method="post" action="<%=request.getContextPath()%>/company/loginend" class="d-flex flex-column h-100">

            <!-- 상단 정보 -->
            <div class="mb-4">
              <img src="<%=request.getContextPath()%><%=Constants.IMAGE_FILE_PATH%>/edu_4943347.png"
                   alt="기업" width="90" class="mb-4">
              <h5 class="fw-semibold mb-2">기업 로그인</h5>
              <p class="text-muted small mb-0">기업 회원 전용 로그인</p>
            </div>

            <!-- 입력 필드 -->
            <div class="form-floating mb-3">
              <input type="text" class="form-control" name="companyId" id="companyId" placeholder="아이디">
              <label for="companyId">아이디</label>
            </div>

            <div class="form-floating mb-3">
              <input type="password" class="form-control" name="companyPw" id="companyPw" placeholder="비밀번호">
              <label for="companyPw">비밀번호</label>
            </div>

            <div class="form-check mb-4 text-start">
              <input class="form-check-input" type="checkbox" name="companySave" id="companySave"
  						<%= savedCompany != null ? "checked" : "" %>>
              <label class="form-check-label" for="companySave">아이디 저장</label>
            </div>

            <!-- 하단 버튼 & 링크 -->
            <div class="mt-auto">
              <button class="btn btn-primary w-100 py-2 rounded-pill mb-3" type="submit">로그인</button>
              <div class="d-flex justify-content-center gap-3 small text-secondary">
                <span>아이디 찾기</span>
                <a href="" class="text-decoration-none" data-bs-toggle="modal" data-bs-target="#findCompanyPwModal">비밀번호 찾기</a>
              </div>
            </div>

          </form>
        </div>
      </div>

    </div>
  </div>
</section>



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
<!-- 기업 비밀번호 찾기 모달 -->
<div class="modal fade" id="findCompanyPwModal" tabindex="-1" aria-labelledby="findCompanyPwModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="findCompanyPwModalLabel">비밀번호 찾기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="findCompanyPwForm" action="<%=request.getContextPath()%>/company/sendmail" method="post">
          <div class="mb-3">
            <label for="findCompanyPwId" class="form-label">아이디</label>
            <input type="text" class="form-control" id="findCompanyPwId" name="companyId" required>
          </div>
          <div class="mb-3">
            <label for="findCompanyPwEmail" class="form-label">이메일</label>
            <input type="email" class="form-control" id="findCompanyPwEmail" name="companyEmail" required>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="submit" form="findCompanyPwForm" class="btn btn-primary">인증번호 받기</button>
      </div>
    </div>
  </div>
</div>



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

  }


  .form-signin img {
    display: block;
    margin: 0 auto 1rem auto;
  }

  .form-signin h1 {
    text-align: center;
  }

  .form-signin .form-floating:focus-within {
    z-index: 2;
  }

  .form-signin input[type="id"] {
    margin-bottom: -1px;
    border-bottom-right-radius: 0;
    border-bottom-left-radius: 0;
  }

  .form-signin input[type="password"] {
    margin-bottom: 10px;
    border-top-left-radius: 0;
    border-top-right-radius: 0;
  }

  .login-btn {
    width: 50%;
    display: block;
    margin: 1rem auto;
  }

  .find-links {
    display: flex;
    justify-content: center;
    gap: 1.5rem;
    margin-top: 1.5rem;
  }
</style>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>
