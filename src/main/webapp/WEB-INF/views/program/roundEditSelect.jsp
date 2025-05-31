<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page import="com.giljobe.program.model.dto.*,
                 com.giljobe.company.model.dto.*,
                 java.util.List" %>
<%
    List<Round> rounds = (List<Round>) request.getAttribute("rounds");
    int proNo = Integer.parseInt(request.getParameter("proNo"));
%>
<section class="container py-5">
    <h2>회차 수정 및 삭제</h2>
    <form action="<%=request.getContextPath()%>/round/edit-form" method="get">
        <input type="hidden" name="proNo" value="<%=proNo%>">
        <% for (Round r : rounds) { %>
            <div class="form-check mb-2">
                <input type="radio" name="roundNo" class="form-check-input" value="<%=r.getRoundNo()%>">
                <label class="form-check-label"><%=r.getRoundCount()%>회차 - <%=r.getRoundDate()%></label>
            </div>
        <% } %>

        <div class="mt-3 d-flex gap-2">
            <button type="submit" class="btn btn-warning">수정</button>
            <button type="submit" formaction="<%=request.getContextPath()%>/round/delete" formmethod="post" class="btn btn-danger">삭제</button>
            <a href="<%=request.getContextPath()%>/program/detail?proNo=<%=proNo%>" class="btn btn-secondary">취소</a>
        </div>
    </form>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
