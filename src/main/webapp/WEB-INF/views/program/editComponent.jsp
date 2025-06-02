<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.giljobe.program.model.dto.*,
                 com.giljobe.company.model.dto.*,
                 java.util.List,
                 java.time.LocalDate" %>
<%
    Company loginCompany = (Company) session.getAttribute("company");
    Program program = (Program) request.getAttribute("program");
    List<Round> availableRounds = (List<Round>) request.getAttribute("availableRounds");
    Round selectedRound = (Round) request.getAttribute("selectedRound");
    
 	// 유효한 회차가 없는 경우 판단: 리스트가 비어있거나
    boolean noValidRounds = true;
    long now = System.currentTimeMillis();
    LocalDate todayDate = LocalDate.now();

    if (availableRounds != null && !availableRounds.isEmpty()) {
        for (Round r : availableRounds) {
            LocalDate roundDate = r.getRoundDate().toLocalDate();

            if (roundDate.isAfter(todayDate)) {
                // 미래 회차는 무조건 유효
                noValidRounds = false;
                break;
            } else if (roundDate.isEqual(todayDate)) {
                // 당일이면 startTime > now 인 ProTime이 하나라도 있어야 유효
                List<ProTime> times = r.getProTimes();
                if (times != null && !times.isEmpty()) {
                    for (ProTime pt : times) {
                        if (pt.getStartTime().getTime() > now) {
                            noValidRounds = false;
                            break;
                        }
                    }
                }
            }

            if (!noValidRounds) break;
        }
    }
    
	// 오늘 날짜 계산
    boolean isTodayRound = selectedRound != null &&
                       selectedRound.getRoundDate().toLocalDate().isEqual(todayDate);


    String proTimeBtnAction = "";
    boolean proTimeBtnEnabled = false;
	
    if (isTodayRound) {
        // 오늘인 회차는 무조건 제한
        proTimeBtnAction = "return alert('※ 현재 선택된 회차는 오늘 날짜입니다.\\n일반 사용자들이 이미 신청했거나 신청 중일 수 있어 타임 수정을 제한합니다.\\n회차 변경 후 다시 시도해주세요.');";
    } else if (!noValidRounds) {
        if (selectedRound != null) {
            proTimeBtnAction = "return confirm('현재 선택된 " + selectedRound.getRoundCount() + "회차의 타임 정보를 수정합니다.\\n다른 회차를 수정하려면 상세 페이지에서 회차 변경 후 다시 선택해주세요.');";
            proTimeBtnEnabled = true;
        } else {
            proTimeBtnAction = "return alert('※ 회차를 먼저 선택해주세요.');";
        }
    } else {
        proTimeBtnAction = "return confirm('※ 유효한 회차가 없습니다. 먼저 회차를 추가해야 타임 수정이 가능합니다.\\n회차 추가 화면으로 이동합니다.');";
    }

    String proTimeBtnUrl = proTimeBtnEnabled
            ? request.getContextPath() + "/protime/edit-form"
            : request.getContextPath() + "/program/selectform";
    String roundNoParam = selectedRound != null ? "<input type='hidden' name='roundNo' value='" + selectedRound.getRoundNo() + "'>" : "";
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
        <form action="<%= proTimeBtnUrl %>" method="get"
		      onsubmit="<%= proTimeBtnAction %>">
		    <input type="hidden" name="proNo" value="<%= program.getProNo() %>">
		    <%= roundNoParam %>
		    <% if (noValidRounds) { %>
            <input type="hidden" name="programType" value="existing">
            <input type="hidden" name="selectedProNo" value="<%=program.getProNo()%>">
            <input type="hidden" name="changeDetail" value="yes">
            <% } %>
		    <button type="submit" class="btn btn-outline-success">프로그램 타임 수정</button>
		</form>

        <!-- 프로그램 삭제 버튼 -->
        <form action="<%=request.getContextPath()%>/program/delete" method="post"
              onsubmit="return confirm('정말로 이 프로그램을 삭제하시겠습니까?\n연관된 회차, 타임, 신청 정보도 모두 삭제됩니다.')">
            <input type="hidden" name="proNo" value="<%=program.getProNo()%>">
            <button type="submit" class="btn btn-outline-danger">프로그램 삭제</button>
        </form>

    </div>
</div>