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
    
    
    
    
	<!-- 지도 영역 -->
	<div class="program-map">
	    <h3>지도</h3>
	    <div id="map" style="width:100%; height:300px;"></div>
	</div>
	
	<!-- 채팅방 영역 -->
	<div class="program-chat">
	    <h3>단체 채팅방</h3>
	    <div class="chat-placeholder">※ 이 영역은 웹소켓 적용 예정 ※</div>
	</div>
	
	<!-- Q&A 영역 -->
	<div class="program-qna">
	    <h3>Q&A</h3>
	    <div class="qna-placeholder">※ Q&A 기능은 추후 구현 예정 ※</div>
	</div>
    
</section>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>