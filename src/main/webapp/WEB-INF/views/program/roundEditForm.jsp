<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%@ page import="com.giljobe.program.model.dto.*,
                 com.giljobe.company.model.dto.*,
                 java.util.List" %>
<%
    Round round = (Round) request.getAttribute("round");
%>
<section class="container py-5">
    <h2>회차 수정</h2>
    <form action="<%=request.getContextPath()%>/round/edit-submit" method="post">
        <input type="hidden" name="roundNo" value="<%=round.getRoundNo()%>">
        <input type="hidden" name="proNo" value="<%=round.getProNoRef()%>">

        <div class="mb-3">
            <label class="form-label">체험 날짜</label>
            <input type="date" name="roundDate" class="form-control" value="<%=round.getRoundDate()%>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">상세 주소</label>
            <input type="text" name="detailLocation" class="form-control" value="<%=round.getDetailLocation()%>">
        </div>

        <div class="mb-3">
            <label class="form-label">최대 인원</label>
            <input type="number" name="roundMaxPeople" class="form-control" value="<%=round.getRoundMaxPeople()%>">
        </div>

        <div class="mb-3">
            <label class="form-label">참가비</label>
            <input type="number" name="roundPrice" class="form-control" value="<%=round.getRoundPrice()%>">
        </div>

        <!-- TODO: 타임 정보도 이곳에서 추가/수정 가능하게 구성할 수 있음 -->

        <div class="mt-4 d-flex gap-2">
            <button type="submit" class="btn btn-primary">수정 완료</button>
            <a href="<%=request.getContextPath()%>/program/detail?proNo=<%=round.getProNoRef()%>" class="btn btn-secondary">수정 취소</a>
        </div>
    </form>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
