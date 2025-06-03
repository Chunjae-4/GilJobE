<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"
         import="com.giljobe.common.Constants" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/js-cookie@3.0.1/dist/js.cookie.min.js"></script>


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
                     <%-- value="<%=savedUser != null ? savedUser : "" %>" --%>>
              <label for="userId">아이디</label>
            </div>

            <div class="form-floating mb-3">
              <input type="password" class="form-control" name="userPw" id="userPw" placeholder="비밀번호">
              <label for="userPw">비밀번호</label>
            </div>

            <div class="form-check mb-4 text-start">
              <input class="form-check-input" type="checkbox" name="userSave" id="userSave"
             <%--  <%=savedUser != null ? "checked" : "" %> --%>>
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
              <%--  value="<%=savedCompany != null ? savedCompany : "" %>" --%> placeholder="아이디">
              <label for="companyId">아이디</label>
            </div>

            <div class="form-floating mb-3">
              <input type="password" class="form-control" name="companyPw" id="companyPw" placeholder="비밀번호">
              <label for="companyPw">비밀번호</label>
            </div>

            <div class="form-check mb-4 text-start">
              <input class="form-check-input" type="checkbox" name="companySave" id="companySave"
  						<%-- <%= savedCompany != null ? "checked" : "" %> --%>>
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
<script>
	//박스 체크할때마다 체크값을 쿠키에 저장하고 풀리면 쿠키에서 값을 지움
	$(document).ready(function() {
	
		  $("#userSave").on("change", function() {//체크박스가 바뀌었어
		    if ($("#userSave").prop("checked") && $.trim($("#userId").val())) {
		 //클라이언트가 체크박스를 체크했고 체크되어있으면서 공백 지운 값이 만약 있 다 면
		      Cookies.set("savedUser", $.trim($("#userId").val()), { expires: 7 });
		//쿠키 여기서 설정
		    } else {
		      Cookies.remove("savedUser");
		      //체크가 풀리면 쿠키삭제
		    }
		  });
	
		  $("#companySave").on("change", function() {
		    if ( $("#companySave").prop("checked") && $.trim($("#companyId").val())) {
		      Cookies.set("savedCompany", $.trim($("#companyId").val()), { expires: 7 });
		    } else {
		      Cookies.remove("savedCompany");
		    }
		  });
		});
	
	//그 값이 있다면 아이디 창에 넣고 체크박스도 풀어
	$(document).ready(function() {
	    const savedUser = Cookies.get("savedUser");
	    if (savedUser) {
		//쿠키가 존재한다면 아이디창에 쿠키의 키값으로 저장된 밸류값을 집어넣어
	      $("#userId").val(savedUser);
		//체크박스도 체크되게 바꿔야해
	      $("#userSave").prop("checked", true);
	    }
	
	    const savedCompany = Cookies.get("savedCompany");
	    if (savedCompany) {
	      $("#companyId").val(savedCompany);
	      $("#companySave").prop("checked", true);
	    }
	  });
</script>

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
