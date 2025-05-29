<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!-- roundAddCopy 기능 시나리오
기업회원이 기존 프로그램에서 회차 추가를 선택함
roundAddCopy.jsp 페이지로 이동
👉 입력: 회차 날짜들(복수 가능)만 선택
서버에서 마지막 회차 정보를 가져옴
마지막 Round + 연결된 ProTime들
선택한 날짜마다 동일한 회차 정보 복제
복사된 Round, ProTime 들 insert
등록 완료 후 상세 페이지로 이동 -->
<%
	String todayDate = (String)request.getAttribute("todayDate");
%>
<div class="container mt-5">
    <h4>날짜 선택</h4>

    <div class="row mb-3">
        <div class="col-md-4">
            <input type="date" id="datePicker" class="form-control" min="<%= todayDate %>">
        </div>
        <div class="col-md-2">
            <button class="btn btn-primary" id="addDateBtn" onclick="addDate()" disabled>추가</button>
        </div>
    </div>

    <ul id="selectedDates" class="list-group mb-3"></ul>

    <!-- 선택된 날짜들을 hidden input 배열로 저장 -->
    <form action="<%=request.getContextPath()%>/round/insert-copy-latest" method="post" onsubmit="return validateBeforeSubmit();">
        <input type="hidden" name="proNoRef" value="<%=request.getParameter("proNo")%>">
        <div id="hiddenDateInputs"></div>
        <button type="submit" class="btn btn-success">등록하기</button>
    </form>
</div>

<script>
    const dateList = new Set();
    const ul = document.getElementById("selectedDates");
    const hiddenContainer = document.getElementById("hiddenDateInputs");
    const dateInput = document.getElementById("datePicker");
    const addBtn = document.getElementById("addDateBtn");

    dateInput.addEventListener("input", function () {
        addBtn.disabled = !dateInput.value;
    });

    function addDate() {
        const selected = dateInput.value;
        if (!selected) return;

        // 이미 있으면 덮어쓰기
        if (dateList.has(selected)) {
            removeDateByValue(selected);
        }

        dateList.add(selected);

        const li = document.createElement("li");
        li.className = "list-group-item d-flex justify-content-between align-items-center";
        li.setAttribute("data-date", selected);
        li.innerHTML = `
            <span>\${selected}</span>
            <button type="button" class="btn btn-sm btn-danger" onclick="removeDate(this, '\${selected}')">삭제</button>
        `;
        ul.appendChild(li);

        const hidden = document.createElement("input");
        hidden.type = "hidden";
        hidden.name = "selectedDates";
        hidden.value = selected;
        hidden.id = "hidden-" + selected;
        hiddenContainer.appendChild(hidden);

        dateInput.value = "";
        addBtn.disabled = true;
    }

    function removeDate(button, date) {
        dateList.delete(date);
        button.closest("li").remove();
        document.getElementById("hidden-" + date).remove();
    }

    function removeDateByValue(date) {
        const listItems = ul.querySelectorAll("li");
        listItems.forEach(item => {
            if (item.getAttribute("data-date") === date) {
                item.remove();
            }
        });
        const hiddenInput = document.getElementById("hidden-" + date);
        if (hiddenInput) hiddenInput.remove();
    }
    
    function validateBeforeSubmit() {
        if (dateList.size === 0) {
            alert("최소 1개의 날짜를 선택해야 등록할 수 있습니다.");
            return false;
        }
        return true;
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>