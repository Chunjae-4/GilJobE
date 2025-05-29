<%@page import="com.giljobe.user.model.dto.User"%>
<%@page import="com.giljobe.program.model.dto.Program"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>
<%
	List<Program> programs=(List<Program>)request.getAttribute("programs");
	User user = (User)session.getAttribute("user");
%>
<ul>
<%for(Program p : programs){%>
	<li id="proNo-<%=p.getProNo()%>"><%=p.getProName() %><button onclick="cancelLove(<%=p.getProNo()%>,'<%=user.getUserNo()%>')">좋지 않아요</button></li>
<%}%>
</ul>
<script>

	const cancelLove=(proNo,userNo)=>{

		if(confirm("정말 취소하시겠습니까?")){
			//취소하겠다
			
			$.ajax({
				url : "<%=request.getContextPath()%>/love/cancellove",
				type : "post",
				dataType: "json",
				data : {"proNo" : proNo ,"userNo":userNo},
				success : function (response){
					//url타고 값이 넘어온다면 실행될 로직
					
					 if(response.result === 1) {
					      alert("좋아요 취소 성공");
					      $("#proNo-"+proNo).remove();
					    } else {
					      alert("좋아요 취소 실패");
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

</script>