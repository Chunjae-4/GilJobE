<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"
         import="com.giljobe.common.Constants" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

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
              <input type="text" class="form-control" name="companyId" id="companyId" 
               value="<%=savedCompany != null ? savedCompany : "" %>" placeholder="아이디">
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
                <a href="<%=request.getContextPath()%>/company/searchId" class="text-decoration-none">아이디 찾기</a>
                <a href="" class="text-decoration-none" data-bs-toggle="modal" data-bs-target="#findCompanyPwModal">비밀번호 찾기</a>
              </div>
            </div>

          </form>
        </div>
      </div>

    </div>
  </div>
  
<%@ include file="/WEB-INF/views/common/userModal.jsp" %>

<%@ include file="/WEB-INF/views/common/companyModal.jsp" %>
  
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
