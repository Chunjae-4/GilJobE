<%@ include file="/WEB-INF/views/common/header.jsp" %>
	<script>
		alert("<%=request.getAttribute("wrongData")%>");
		location.replace("<%=request.getContextPath()%><%=request.getAttribute("mapping")%>");
	</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
