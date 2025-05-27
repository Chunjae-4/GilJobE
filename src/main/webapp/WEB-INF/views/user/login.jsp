<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"
         import="com.giljobe.common.Constants" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<section class="bg-body-tertiary py-5">
  <div class="container">
    <div class="row justify-content-center g-4">

      <!-- 유저 로그인 -->
      <div class="col-md-5">
        <div class="bg-white p-4 rounded-4 shadow-sm">
          <form method="post" action="<%=request.getContextPath()%>/user/loginend">
            <div class="text-center mb-4">
              <img src="<%=request.getContextPath()%><%=Constants.IMAGE_FILE_PATH%>/groom_2920507.png"
                   alt="유저" width="64" class="mb-2">
              <h4 class="fw-bold">유저 로그인</h4>
              <p class="text-muted small">개인 이용자를 위한 로그인</p>
            </div>

            <div class="form-floating mb-3">
              <input type="text" class="form-control" name="userId" id="userId" placeholder="아이디"
                     value="<%=savedUser != null ? savedUser : "" %>">
              <label for="userId">아이디</label>
            </div>

            <div class="form-floating mb-3">
              <input type="password" class="form-control" name="userPw" id="userPw" placeholder="비밀번호">
              <label for="userPw">비밀번호</label>
            </div>

            <div class="form-check mb-3">
              <input class="form-check-input" type="checkbox" name="userSave" id="userSave"
                <%=savedUser != null ? "checked" : "" %>>
              <label class="form-check-label" for="userSave">아이디 저장</label>
            </div>

            <button class="btn btn-primary w-100 py-2 rounded-pill" type="submit">로그인</button>

            <div class="d-flex justify-content-center gap-4 mt-3 small">
              <a href="<%=request.getContextPath()%>/user/searchId" class="text-secondary">아이디 찾기</a>
              <a href="<%=request.getContextPath()%>/user/searchPw" class="text-secondary">비밀번호 찾기</a>
            </div>
          </form>
        </div>
      </div>

      <!-- 기업 로그인 -->
      <div class="col-md-5">
        <div class="bg-white p-4 rounded-4 shadow-sm">
          <form method="post" action="<%=request.getContextPath()%>/company/loginend">
            <div class="text-center mb-4">
              <img src="<%=request.getContextPath()%><%=Constants.IMAGE_FILE_PATH%>/edu_4943347.png"
                   alt="기업" width="64" class="mb-2">
              <h4 class="fw-bold">기업 로그인</h4>
              <p class="text-muted small">기업 회원 전용 로그인</p>
            </div>

            <div class="form-floating mb-3">
              <input type="text" class="form-control" name="companyId" id="companyId" placeholder="아이디">
              <label for="companyId">아이디</label>
            </div>

            <div class="form-floating mb-3">
              <input type="password" class="form-control" name="companyPw" id="companyPw" placeholder="비밀번호">
              <label for="companyPw">비밀번호</label>
            </div>

            <div class="form-check mb-3">
              <input class="form-check-input" type="checkbox" name="companySave" id="companySave">
              <label class="form-check-label" for="companySave">아이디 저장</label>
            </div>

            <button class="btn btn-primary w-100 py-2 rounded-pill" type="submit">로그인</button>

            <div class="d-flex justify-content-center gap-4 mt-3 small text-secondary">
              <span>아이디 찾기</span>
              <span>비밀번호 찾기</span>
            </div>
          </form>
        </div>
      </div>

    </div>
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
