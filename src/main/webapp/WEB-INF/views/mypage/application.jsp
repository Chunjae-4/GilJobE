<%@page import="com.giljobe.user.model.dto.User"%>
<%@page import="com.giljobe.application.model.dto.ApplicationProgram"%>
<%@page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<%
  List<ApplicationProgram> apppro = (List<ApplicationProgram>) request.getAttribute("applicationProgram");
  //SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
  SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");

%>

<div class="table-responsive">
  <table class="table table-hover align-middle shadow-sm border rounded-3 overflow-hidden">
    <thead class="table-light">
    <tr class="text-center">
      <th scope="col">📌 프로그램 이름</th>
      <th scope="col">시작 날짜</th>
      <th scope="col">회차</th>
      <th scope="col">시작 시간</th>
      <th scope="col">종료 시간</th>
    </tr>
    </thead>
    <tbody>
    <% if (apppro != null && !apppro.isEmpty()) {
      for (ApplicationProgram a : apppro) { %>
    <tr>
      <td>
        <a href="<%=request.getContextPath()%>/program/detail?proNo=<%=a.getProNo()%>"
           class="text-decoration-none text-primary fw-semibold">
          <%= a.getProName() %>
        </a>
      </td>
      <td class="text-center"><%= a.getRoundDate() %></td>
      <td class="text-center"><%= a.getRoundCount() %></td>
      <td class="text-center"><%= timeFormat.format(a.getStartTime()) %></td>
      <td class="text-center"><%= timeFormat.format(a.getEndTime()) %></td>
    </tr>
    <% }
    } else { %>
    <tr>
      <td colspan="4" class="text-center text-muted py-4">
        현재 신청한 프로그램이 없습니다.
      </td>
    </tr>
    <% } %>
    </tbody>
  </table>
</div>


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