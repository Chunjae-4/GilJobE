<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page import="com.giljobe.program.model.dto.*,
                 com.giljobe.company.model.dto.*,
                 java.util.List" %>
<%
    List<Round> rounds = (List<Round>) request.getAttribute("rounds");
	int roundCount = (rounds != null) ? rounds.size() : 0;
    int proNo = Integer.parseInt(request.getParameter("proNo"));
%>
<section class="container py-5">
	<div class="mb-4 text-center">
		<h2 class="fw-bold">회차 수정 및 삭제</h2>
		<p class="text-muted">수정 또는 삭제할 회차를 선택하세요.</p>
	</div>

	<form action="<%=request.getContextPath()%>/round/edit-form" method="get"
		  class="bg-white p-4 rounded-4 shadow-sm">
		<input type="hidden" name="proNo" value="<%=proNo%>">

		<% if (rounds == null || rounds.isEmpty()) { %>
		<p class="text-muted text-center">등록된 회차가 없습니다.</p>
		<% } else { %>
		<div class="mb-4">
			<% for (Round r : rounds) { %>
			<div class="form-check mb-2">
				<input type="radio" name="roundNo" class="form-check-input" value="<%=r.getRoundNo()%>" required id="round-<%=r.getRoundNo()%>">
				<label class="form-check-label" for="round-<%=r.getRoundNo()%>">
					<strong><%=r.getRoundCount()%>회차</strong> - <%=r.getRoundDate()%>
				</label>
			</div>
			<% } %>
		</div>
		<% } %>

		<div class="d-flex justify-content-end gap-2">
			<button type="submit" class="btn btn-warning px-4">수정</button>
			<button type="submit"
					formaction="<%=request.getContextPath()%>/round/delete"
					formmethod="post"
					class="btn btn-danger px-4"
					id="deleteBtn">삭제</button>
			<a href="<%=request.getContextPath()%>/program/detail?proNo=<%=proNo%>" class="btn btn-outline-secondary px-4">취소</a>
		</div>
	</form>
</section>
<script>
    const roundCount = <%= roundCount %>;

    document.addEventListener("DOMContentLoaded", () => {
        const deleteBtn = document.getElementById("deleteBtn");

        deleteBtn.addEventListener("click", function(event) {
            if (roundCount <= 1) {
                // 삭제 불가 안내
                alert("※ 최소 1개의 회차는 반드시 존재해야 하므로 삭제할 수 없습니다.");
                event.preventDefault(); // 폼 전송 중단
            } else {
                // 삭제 확인창
                const confirmed = confirm("해당 회차 삭제하면 프로그램 타임, 신청 전부 삭제됩니다. 정말 삭제하시겠습니까?");
                if (!confirmed) {
                    event.preventDefault(); // 취소하면 폼 전송 중단
                }
            }
        });
    });
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
