<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" 
		 import="com.giljobe.common.Constants"%>
<%@ page import="com.giljobe.program.model.dto.Program" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<% Program program = (Program)request.getAttribute("program");%>
<section class="container py-5">
    <% if (program != null) { %>
        <h1><%= program.getProName() %></h1>
        <p><strong>유형:</strong> <%= program.getProType() %></p>
        <p><strong>장소:</strong> <%= program.getProLocation() %></p>
        <p><strong>카테고리:</strong> <%= program.getProCategory() %></p>
        <p><strong>이미지 경로:</strong> <%= program.getProImageUrl() %></p>
        <p><strong>위도 / 경도:</strong> <%= program.getProLatitude() %> / <%= program.getProLongitude() %></p>
    <% } else { %>
        <p>프로그램 정보가 없습니다.</p>
    <% } %>
</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>