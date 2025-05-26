<%@page import="com.giljobe.program.model.dto.Program"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%List<Program> programs = (List<Program>)request.getAttribute("lovedProgram");%>

<%for(Program p : programs){%>
	
	<span><%=p.getProName()%></span>
	
	<%}%>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>