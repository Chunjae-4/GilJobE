<%@page import="com.giljobe.user.model.dto.User"%>
<%@page import="com.giljobe.application.model.dto.ApplicationProgram"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%
	List<ApplicationProgram> apppro =(List<ApplicationProgram>)request.getAttribute("applicationProgram");
	User user = (User)session.getAttribute("user");
	

%>
<ul>
<%for(ApplicationProgram a : apppro){%>
	<li id="proNo-<%=a.getProNo()%>">
	<a href="<%=request.getContextPath()%>/program/detail?proNo=<%=a.getProNo()%>"> <%=a.getProNo()%>  <%=a.getProName() %>   </a>
	<%-- <button onclick="cancelApp(<%=a.getTimeNo()%>,'<%=user.getUserNo()%>',<%=a.getProNo()%>)">좋지 않아요</button> --%>
	</li>
<%}%>
</ul>
<%-- <script>

	const cancelApp=(timeNo,userNo,proNo)=>{

		if(confirm("정말 취소하시겠습니까?")){
			//취소하겠다
			
			$.ajax({
				url : "<%=request.getContextPath()%>/application/cancelapplication",
				type : "post",
				dataType: "json",
				data : {"timeNo" : timeNo ,"userNo":userNo},
				success : function (response){
					//url타고 값이 넘어온다면 실행될 로직
					
					 if(response.result === 1) {
					      alert("신청 취소 성공");
					      $("#proNo-"+proNo).remove();
					    } else {
					      alert("신청 취소 실패");
					    }
				},
				error : function(){
					alert("프로그램이 당신을 안놓아줍니다")
				}
			})

			
		}else{
			//취소 안하겠단
			return;
		}
	}

</script> --%>