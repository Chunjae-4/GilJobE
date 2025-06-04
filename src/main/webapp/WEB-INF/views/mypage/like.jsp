<%@page import="com.giljobe.user.model.dto.User"%>
<%@page import="com.giljobe.program.model.dto.Program"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%
	List<Program> programs = (List<Program>) request.getAttribute("programs");
	User user = (User) session.getAttribute("user");
%>

<div class="table-responsive">
	<table class="table table-hover align-middle shadow-sm border rounded-3 overflow-hidden">
		<thead class="table-light text-center">
		<tr>
			<th scope="col">📌 프로그램 이름</th>
			<th scope="col">❤️ 좋아요</th>
		</tr>
		</thead>
		<tbody>
		<% if (programs != null && !programs.isEmpty()) {
			for (Program p : programs) { %>
		<tr id="proNo-<%=p.getProNo()%>">
			<td>
				<a href="<%=request.getContextPath()%>/program/detail?proNo=<%=p.getProNo()%>"
				   class="text-decoration-none text-primary fw-semibold">
					<%= p.getProName() %>
				</a>
			</td>
			<td class="text-center">
				<button class="btn btn-outline-danger btn-sm"
						onclick="cancelLove(<%=p.getProNo()%>, <%=user.getUserNo()%>)">
					❤️ 취소
				</button>
			</td>
		</tr>
		<% }
		} else { %>
		<tr>
			<td colspan="2" class="text-center text-muted py-4">
				좋아요한 프로그램이 없습니다.
			</td>
		</tr>
		<% } %>
		</tbody>
	</table>
</div>


<script>
	function cancelLove(proNo, userNo) {
		if (confirm("정말 취소하시겠습니까?")) {
			$.ajax({
				url: "<%=request.getContextPath()%>/love/cancellove",
				type: "post",
				dataType: "json",
				data: { proNo: proNo, userNo: userNo },
				success: function (response) {
					if (response.result === 1) {
						alert("좋아요 취소 성공");
						$("#proNo-" + proNo).remove();
					} else {
						alert("좋아요 취소 실패");
					}
				},
				error: function () {
					alert("서버 오류로 인해 취소할 수 없습니다.");
				}
			});
		}
	}
</script>