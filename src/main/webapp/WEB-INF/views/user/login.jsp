<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<h2>로그인</h2>유형에 맞는 로그인을 하시면 알맞는 서비스를 제공합니다
	<div class="login-wrapper d-flex justify-content-center gap-4">
  <main class="form-signin">
    <form method="post" action="<%=request.getContextPath()%>/user/loginend">
      <img class="mb-4" src="<%=request.getContextPath()%><%=Constants.IMAGE_FILE_PATH%>/groom_2920507.png"
      alt="유저" width="72" height="57">
      <h1 class="h3 mb-3 fw-normal">유저 로그인</h1>
      <div class="form-floating">
        <input type="text" class="form-control" name="userId" placeholder="Id">
        <label for="userId">아이디</label>
      </div>
      <div class="form-floating">
        <input type="password" class="form-control" name="userPw" placeholder="Password">
        <label for="userPw">비밀번호</label>
      </div>
      <div class="form-check text-start my-3">
        <input class="form-check-input" type="checkbox" value="remember-me" id="userCheck">
        <label class="form-check-label" for="userCheck">아이디 저장</label>
      </div>
      <button class="btn btn-primary login-btn py-2" type="submit">로그인</button>
<div class="find-links">
  <p class="text-body-secondary mb-0">아이디 찾기</p>
  <p class="text-body-secondary mb-0">비밀번호 찾기</p>
</div>
    </form>
  </main>

  <main class="form-signin">
    <form>
      <img class="mb-4" src="<%=request.getContextPath()%><%=Constants.IMAGE_FILE_PATH%>/edu_4943347.png" alt="기업" width="72" height="57">
      <h1 class="h3 mb-3 fw-normal">기업 로그인</h1>
      <div class="form-floating">
        <input type="text" class="form-control" name="companyId" placeholder="Id">
        <label for="companyEmail">아이디</label>
      </div>
      <div class="form-floating">
        <input type="password" class="form-control" name="companyPw" placeholder="Password">
        <label for="companyPassword">비밀번호</label>
      </div>
      <div class="form-check text-start my-3">
        <input class="form-check-input" type="checkbox" value="remember-me" id="companyCheck">
        <label class="form-check-label" for="companyCheck">아이디 저장</label>
      </div>
      <button class="btn btn-primary login-btn py-2" type="submit">로그인</button>
     <div class="find-links">
  <p class="text-body-secondary mb-0">아이디 찾기</p>
  <p class="text-body-secondary mb-0">비밀번호 찾기</p>
</div>
    </form>
  </main>
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
