
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"
         import="com.giljobe.common.Constants"
%>
<!DOCTYPE html>
<html>
<head>
    <title>길잡이</title>
    <%-- bootstrap css, js --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="icon" type="image/png" sizes="32x32" href="<%=request.getContextPath()%><%=Constants.IMAGE_FILE_PATH%>/favicon-32x32.png">

</head>

<body>
<nav class="navbar navbar-light" style="background-color: #e3f2fd; height: 45px;">
    <div class="container-fluid d-flex align-items-center" style="height: 100%;">
        <ul class="nav nav-pills d-flex align-items-center ms-auto mb-0">
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/user/login" class="nav-link py-0">로그인</a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>" class="nav-link py-0">로그아웃</a>
            </li>
            <li class="nav-item">
                <a href="<%=request.getContextPath()%>/user/enroll" class="nav-link py-0">회원가입</a>
            </li>
        </ul>
    </div>
</nav>
<div class="container-fluid">
    <header class="d-flex flex-wrap justify-content-center align-items-center py-3 mb-4 border-bottom" style="margin-top: 5px;">
        <%--활성화 "nav-link active"--%>
        <%--현재 페이지 확인 aria-current="page"--%>
        <ul class="nav nav-pills d-flex justify-content-around align-items-center w-100">
            <li>
                <a href="<%=request.getContextPath()%>">
                    <img class="bi me-2" width="100" src="<%=request.getContextPath()%><%=Constants.IMAGE_FILE_PATH%>/logo.png">
                </a>
            </li>

            <li class="<%=Constants.CSS_LI_ITEM%>>"><a href="<%=request.getContextPath()%>/program/programlist" class="nav-link">진로체험리스트</a></li>
            <li class="<%=Constants.CSS_LI_ITEM%>>"><a href="<%=request.getContextPath()%>/program/map" class="nav-link">지도화면</a></li>
            <li class="<%=Constants.CSS_LI_ITEM%>>"><a href="<%=request.getContextPath()%>/notice/noticelist" class="nav-link">공지사항</a></li>
            <li class="<%=Constants.CSS_LI_ITEM%>>"><a href="<%=request.getContextPath()%>/user/mypage" class="nav-link">마이페이지</a></li>
        </ul>
    </header>
</div>
</body>

</html>


