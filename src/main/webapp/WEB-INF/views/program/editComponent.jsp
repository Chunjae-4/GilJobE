<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.giljobe.program.model.dto.*,
                 com.giljobe.company.model.dto.*,
                 java.util.List" %>

<%
    Company loginCompany = (Company) session.getAttribute("company");
    Program program = (Program) request.getAttribute("program");
    List<Round> availableRounds = (List<Round>) request.getAttribute("availableRounds");
    Round selectedRound = (Round) request.getAttribute("selectedRound");
%>

<div class="card mb-4">
    <div class="card-header fw-bold">프로그램 관리</div>
    <div class="card-body d-flex flex-wrap gap-3">

        <!-- 프로그램 수정 버튼 -->
        <form action="<%=request.getContextPath()%>/program/edit-form" method="get">
            <input type="hidden" name="proNo" value="<%=program.getProNo()%>">
            <button type="submit" class="btn btn-outline-primary">프로그램 수정</button>
        </form>

        <!-- 회차 수정/삭제 버튼 -->
        <% if (availableRounds != null && !availableRounds.isEmpty()) { %>
        <form action="<%=request.getContextPath()%>/round/edit-select" method="get">
            <input type="hidden" name="proNo" value="<%=program.getProNo()%>">
            <button type="submit" class="btn btn-outline-warning">회차 수정/삭제</button>
        </form>
        <% } %>

        <!-- 프로그램 타임 수정 버튼 -->
        <% if (selectedRound != null) { %>
        <form action="<%=request.getContextPath()%>/protime/edit-form" method="get"
              onsubmit="return confirm('현재 선택된 <%=selectedRound.getRoundCount()%>회차의 타임 정보를 수정합니다.\n다른 회차를 수정하려면 상세 페이지에서 다시 선택해주세요.')">
            <input type="hidden" name="roundNo" value="<%=selectedRound.getRoundNo()%>">
            <button type="submit" class="btn btn-outline-success">프로그램 타임 수정</button>
        </form>
        <% } %>

        <!-- 프로그램 삭제 버튼 -->
        <form action="<%=request.getContextPath()%>/program/delete" method="post"
              onsubmit="return confirm('정말로 이 프로그램을 삭제하시겠습니까?\n연관된 회차, 타임, 신청 정보도 모두 삭제됩니다.')">
            <input type="hidden" name="proNo" value="<%=program.getProNo()%>">
            <button type="submit" class="btn btn-outline-danger">프로그램 삭제</button>
        </form>

    </div>
</div>