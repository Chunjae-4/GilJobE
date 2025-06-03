<%@page import="com.giljobe.user.model.dto.User"%>
<%@page import="com.giljobe.program.model.dto.Program"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%
	List<Program> programs = (List<Program>) request.getAttribute("programs");
	User user = (User) session.getAttribute("user");
%>

<ul class="list-group mb-4">
	<% for (Program p : programs) { %>
	<li class="list-group-item d-flex justify-content-between align-items-center"
		id="proNo-<%=p.getProNo()%>">
		<span><%= p.getProName() %></span>
		<button class="btn btn-outline-danger btn-sm"
				onclick="cancelLove(<%=p.getProNo()%>, <%=user.getUserNo()%>)">
			❤️ 취소
		</button>
	</li>
	<% } %>
</ul>


<script>
	const cancelLove = (proNo, userNo) => {
		if (!confirm("정말 좋아요를 취소하시겠습니까?")) return;

		$.ajax({
			url: "<%=request.getContextPath()%>/love/cancellove",
			type: "POST",
			dataType: "json",
			data: { proNo: proNo, userNo: userNo },
			success: function(response) {
				if (response.result === 1) {
					alert("좋아요가 취소되었습니다.");
					document.getElementById("proNo-" + proNo)?.remove();
				} else {
					alert("취소 처리에 실패했습니다.");
				}
			},
			error: function() {
				alert("서버 오류: 취소 요청이 실패했습니다.");
			}
		});
	};
</script>