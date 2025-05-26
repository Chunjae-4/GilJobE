<%@page import="com.giljobe.program.model.dto.Program"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>
<%
	List<Program> programs=(List<Program>)request.getAttribute("programs");
%>
<ul>
<%for(Program p : programs){%>
	<li><%=p %></li>
<%}%>
</ul>