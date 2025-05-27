<%@page import="com.giljobe.application.model.dto.Application"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%
	List<Application> app =(List<Application>)request.getAttribute("programs");
%>
<ul>
<%for(Application a : app){%>
	<li><%=a %></li>
<%}%>
</ul>