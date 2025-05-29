<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"
         import="com.giljobe.common.Constants" %>

<script>let socket = new WebSocket("ws://localhost:8080/<%=request.getContextPath()%>/chatting");</script>
<section>
    <h1>임시채팅</h1>
</section>
