<%@page import="com.giljobe.user.model.dto.User"%>
<%@page import="com.giljobe.qna.model.dto.QNA"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>
<%
	User user = (User)request.getAttribute("user");
	List<QNA> qnas = user.getQnas();
%>
<ul>
<%for( QNA q: qnas){%>
	<li>문의 내용 : <%=q.getQnaContent() %></li>
	<li>답변 : <%=q.getAnswer() %></li>
<%}%>
</ul>