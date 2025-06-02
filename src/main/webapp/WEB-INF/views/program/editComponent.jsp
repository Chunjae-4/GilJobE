<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.giljobe.program.model.dto.*,
                 com.giljobe.company.model.dto.*,
                 java.util.List" %>

<%
    Company loginCompany = (Company) session.getAttribute("company");
    Program program = (Program) request.getAttribute("program");
    List<Round> availableRounds = (List<Round>) request.getAttribute("availableRounds");
    Round selectedRound = (Round) request.getAttribute("selectedRound");
    
 	// 유효한 회차가 없는 경우 판단: 리스트가 비어있거나
    boolean noValidRounds = true;
    long now = System.currentTimeMillis();

    if (availableRounds != null && !availableRounds.isEmpty()) {
        for (Round r : availableRounds) {
            if (r.getProTimes() != null && !r.getProTimes().isEmpty()) {
                for (ProTime pt : r.getProTimes()) {
                	// 당일이지만 타임이 모두 지나간 회차도 유요하지 않은 회차로 처리되도록
                    if (pt.getStartTime().getTime() > now) {
                        noValidRounds = false;
                        break;
                    }
                }
            }
            if (!noValidRounds) break;
        }
    }
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
        <form action="<%= noValidRounds ? request.getContextPath() + "/program/selectform" : request.getContextPath() + "/round/edit-select" %>" method="get"
              onsubmit="return <%= noValidRounds ? "confirm('유효한 회차가 없습니다. 새로운 회차를 추가하는 화면으로 이동합니다.')" : "true" %>">
            <input type="hidden" name="proNo" value="<%=program.getProNo()%>">
            <% if (noValidRounds) { %>
            <input type="hidden" name="programType" value="existing">
            <input type="hidden" name="selectedProNo" value="<%=program.getProNo()%>">
            <input type="hidden" name="changeDetail" value="yes">
            <% } %>
            <button type="submit" class="btn btn-outline-warning">회차 수정/삭제</button>
        </form>

        <!-- 프로그램 타임 수정 버튼 -->
        <% if (selectedRound != null) { %>
        <form action="<%=request.getContextPath()%>/protime/edit-form" method="get"
              onsubmit="return confirm('현재 선택된 <%=selectedRound.getRoundCount()%>회차의 타임 정보를 수정합니다.\n다른 회차를 수정하려면 상세 페이지에서 회차 변경 후 다시 선택해주세요.')">
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