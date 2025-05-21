<%@page import="com.giljobe.common.Constants"%>
<%@ page import="oracle.jdbc.driver.Const" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>길잡이</title>
    <%-- bootstrap css, js --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
<div class="container">
    <nav class="navbar fixed-top navbar-light" style="background-color: #e3f2fd;">
        <div class="container-fluid">
            mini nav, login, signup
        </div>
    </nav>

    <header class="d-flex flex-wrap justify-content-center align-items-center py-3 mb-4 border-bottom" style="margin-top: 70px;">
        <a href="<%=request.getContextPath()%>" class="d-flexmb-md align-items-center mb-3 -0 me-md-auto text-dark text-decoration-none">
            <img class="bi me-2" width="70" src="<%=request.getContextPath()%><%=Constants.IMAGE_FILE_PATH%>/logo.png">
        </a>

        <%--활성화 "nav-link active"--%>
        <%--현재 페이지 확인 aria-current="page"--%>
        <ul class="nav nav-pills align-items-center">
            <li class="nav-item"><a href="<%=request.getContextPath()%>/program/programlist" class="nav-link">진로체험리스트</a></li>
            <li class="nav-item"><a href="<%=request.getContextPath()%>/program/map" class="nav-link">지도화면</a></li>
            <li class="nav-item"><a href="<%=request.getContextPath()%>" class="nav-link">공지사항</a></li>
            <li class="nav-item"><a href="<%=request.getContextPath()%>" class="nav-link">마이페이지</a></li>
        </ul>
    </header>
</div>



</body>

</html>


