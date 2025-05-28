<%@page import="com.giljobe.company.model.dto.Company"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"
         import="com.giljobe.common.Constants, com.giljobe.user.model.dto.User"
%>
<%
	User loginUser = (User)session.getAttribute("user");
	Company loginCompany = (Company)session.getAttribute("company");
	
	
	Cookie[] cookies = request.getCookies();//쿠키 싹다 가져오기
	String savedUser = null;
	String savedCompany = null;
	if(cookies!=null){
		for(Cookie c:cookies){
			if(c.getName().equals("userSave")){//savaUser라는 이름의 쿠키를 가져와서 String변수에 담기
				savedUser=c.getValue();//여기엔 버튼을 누른 id값이 저장될것
				break;
			}
			if(c.getName().equals("companySave")){//savaUser라는 이름의 쿠키를 가져와서 String변수에 담기
				savedCompany=c.getValue();//여기엔 버튼을 누른 id값이 저장될것
				break;
			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
    <title>길잡이</title>
    <%-- bootstrap css, js --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="icon" type="image/png" sizes="32x32" href="<%=request.getContextPath()%><%=Constants.IMAGE_FILE_PATH%>/favicon-32x32.png">
	<script src="<%=request.getContextPath()%>/resources/js/jquery-3.7.1.min.js"></script>
</head>

<body>
<!-- 상단 로그인/회원가입 바 -->
<nav class="navbar navbar-light bg-light py-1 border-bottom">
    <div class="container-fluid d-flex justify-content-end align-items-center">
        <ul class="nav d-flex align-items-center mb-0">
            <% if (loginUser == null && loginCompany == null) { %>
            <li class="nav-item d-flex align-items-center">
                <a href="<%=request.getContextPath()%>/user/login" class="nav-link px-2">로그인</a>
            </li>
            <li class="nav-item d-flex align-items-center">
                <a href="<%=request.getContextPath()%>/user/enroll" class="nav-link px-2">회원가입</a>
            </li>
            <% } else if (loginUser != null) { %>
            <li class="nav-item d-flex align-items-center">
          <span class="nav-link fw-bold text-primary px-2">
            <%=loginUser.getUserId()%>님 환영합니다.
          </span>
            </li>
            <li class="nav-item d-flex align-items-center">
                <a href="<%=request.getContextPath()%>/user/logout" class="nav-link px-2">로그아웃</a>
            </li>
            <% } else { %>
            <li class="nav-item d-flex align-items-center">
          <span class="nav-link fw-bold text-primary px-2">
            <%=loginCompany.getComId()%>님 환영합니다.
          </span>
            </li>
            <li class="nav-item d-flex align-items-center">
                <a href="<%=request.getContextPath()%>/user/logout" class="nav-link px-2">로그아웃</a>
            </li>
            <% } %>
        </ul>
    </div>
</nav>
<!-- 메인 내비게이션 바 -->
<header class="bg-white shadow-sm">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-between py-3">

            <!-- 로고 -->
            <a href="<%=request.getContextPath()%>" class="text-decoration-none">
                <img class="rounded-3" src="<%=request.getContextPath()%><%=Constants.IMAGE_FILE_PATH%>/logo.png" alt="로고" width="100">
            </a>

            <!-- 내비 메뉴 + 환영 메시지 -->
            <div class="d-flex align-items-center gap-4 ms-auto">

                <!-- 메뉴 -->
                <ul class="nav gap-4 mb-0 fs-5 fw-semibold">
                    <li class="nav-item">
                        <a href="<%=request.getContextPath()%>/program/programlist" class="nav-link text-dark">체험리스트</a>
                    </li>
                    <li class="nav-item">
                        <a href="<%=request.getContextPath()%>/program/map" class="nav-link text-dark">지도</a>
                    </li>
                    <li class="nav-item">
                        <a href="<%=request.getContextPath()%>/notice/noticelist" class="nav-link text-dark">공지사항</a>
                    </li>
                    <li class="nav-item">
                        <% if (loginUser != null) { %>
                        <a href="<%=request.getContextPath()%>/mypage/mypageview" class="nav-link text-dark">마이페이지</a>
                        <% } else if(loginCompany != null){ %>
						<a href="<%=request.getContextPath()%>/mypage/companymypageview" class="nav-link text-dark">마이페이지</a>
                        <%}else{ %>
                        <a href="<%=request.getContextPath()%>/user/login" class="nav-link text-dark">마이페이지</a>
                        <% } %>
                    </li>
                </ul>

            </div>
        </div>
    </div>
</header>
</body>
<style>
    .nav-link {
        transition: all 0.2s ease-in-out;
    }

    .nav-link:hover {
        color: #0d6efd; /* primary */
        text-decoration: none; /* 밑줄 제거 */
        font-weight: 600;
        background-color: rgba(13, 110, 253, 0.1); /* primary-light */
        border-radius: 0.375rem;
    }
</style>
</html>


