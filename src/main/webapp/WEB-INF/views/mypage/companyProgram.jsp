<%@page import="com.giljobe.program.model.dto.Program"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%
	List<Program> pro =(List<Program>)request.getAttribute("programs");
%>
<ul>
<%for(Program p : pro){%>
	<li><a href="<%=request.getContextPath()%>/program/detail?proNo=<%=p.getProNo()%>"><%=p.getProName() %></a></li>
<%}%>
</ul>