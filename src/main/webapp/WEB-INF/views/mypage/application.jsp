<%@page import="com.giljobe.application.model.dto.ApplicationProgram"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%
	List<ApplicationProgram> apppro =(List<ApplicationProgram>)request.getAttribute("applications");
%>
<ul>
<%for(ApplicationProgram a : apppro){%>
	<li><a href="<%=request.getContextPath()%>/program/detail?proNo=<%=a.getProNo()%>"><%=a.getProName() %></a></li>
<%}%>
</ul>