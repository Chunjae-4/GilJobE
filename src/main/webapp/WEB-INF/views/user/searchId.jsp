<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<form method="post">
	<label>이름 입력</label>
	<input type="text" placeholder="이름" id="name">
	<label>아이디 입력</label>
	<input type="text" placeholder="아이디" id="id">
	<label>이메일 입력</label>
	<input type="text" placeholder="이메일" id="email" name="searchPwByEmail">
	<button id="sendEmail">메일 보내기</button>>
</form>
<script>
	$("#sendEmail").click(
		const function=()=>{	
			$.ajax({
			
				url:"<%=request.getContextPath()%>/user/sendmail",
				type:"post",
				async : true,
				data:{"mail":$("#mail").val()"},
				success : function(response, status, request){
				dataType : "json"
				},
				error: console.log("error"+error),
				cache: false;
			})
		
		});
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>