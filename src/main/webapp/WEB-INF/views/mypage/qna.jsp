<%@page import="com.giljobe.qna.model.dto.QNA"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>
<%
	List<QNA> qnas=(List<QNA>)request.getAttribute("qnas");
%>
<ul>
<%for(QNA Q : qnas){%>
	<li><%=Q %></li>
<%}%>
</ul>