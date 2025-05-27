<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"
         import="com.giljobe.common.Constants" %>
<%@ page import="com.giljobe.program.model.dto.Program" %>
<%@ page import="java.util.List" %>
<%@ page import="com.giljobe.common.ProCategory" %>
<%@ page import="java.util.Optional" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<%--TODO: 프로그램 검색--%>
<%--TODO: 페이징 처리--%>
<%--TODO: 클릭시 프로그램 페이지 이동--%>

<%--programlist servlet 에서 리스트 가져오기--%>
<% List<Program> programList = (List<Program>) request.getAttribute("programList");%>

<!-- 검색 섹션 -->
<section class="text-center mb-5 py-5 ">
    <div class="row py-lg-5">
        <div class="col-lg-10 col-md-12 mx-auto">
            <h1 class="fw-normal">진로 체험 프로그램 페이지</h1>
            <p class="lead text-body-secondary">다양한 체험 프로그램을 만나보세요.</p>
        </div>
    </div>
    <form role="search" action="<%=request.getContextPath()%>/program/programsearchform" method="get">
        <!-- 검색창 -->
        <div class="d-flex justify-content-center mb-3">
            <div class="input-group" style="max-width: 600px;">
                <input type="search" name="keyword"
                       class="form-control form-control-lg rounded-start-pill"
                       placeholder="검색어를 입력하세요" aria-label="Search">
                <button class="btn btn-primary btn-lg rounded-end-pill" type="submit">
                    🔍 검색
                </button>
            </div>
        </div>

        <!-- 숨겨진 input (선택된 카테고리 전송용) -->
        <input type="hidden" name="category" id="selectedCategoryInput">

        <!-- 카테고리 버튼들 -->
        <div class="d-flex flex-wrap justify-content-center gap-2 mt-3"
             style="max-width: 700px; margin: 0 auto;">
            <% for (ProCategory sc : ProCategory.values()) {
                Optional<String> result = java.util.Arrays.stream(sc.getSubcategories())
                        .reduce((prev, next) -> prev + " · " + next); %>
            <button type="button"
                    class="btn btn-outline-secondary category-btn px-3 py-2"
                    data-category="<%= result.get() %>">
                <%= result.get() %>
            </button>
            <% } %>
        </div>
    </form>
</section>

<%--<%if(company && login){%>--%>

<%--<%}%>--%>
<%--TODO: 프로그램 등록은 기업회원이 로그인 되어있지 않으면 보이지않도록 분기점 추가 필요--%>
<%--loginUser로 처리해두고, 나중에 기업 회원 추가되면 그때 수정 ㄱㄱ--%>
<% if(loginUser != null) { %>
<section class="container my-5">
    <div class="p-4 p-md-5 bg-light rounded-3 shadow-sm d-flex justify-content-between align-items-center flex-wrap gap-3">

        <!-- 설명 텍스트 -->
        <div>
            <h4 class="fw-bold mb-1">나만의 체험 프로그램을 소개해보세요!</h4>
            <p class="mb-0 text-muted">직접 체험한 내용을 공유하거나 새로운 프로그램을 등록해보세요.</p>
        </div>

        <!-- 작성 버튼 -->
        <div class="text-end">
            <a href="<%=request.getContextPath()%>/program/selectform" class="btn btn-primary btn-lg">
                ✏️ 프로그램 등록
            </a>
        </div>
    </div>
</section>
<%}%>

<section class="bg-body-tertiary py-5">
    <div class="container">
        <p class="mb-4 text-muted">총 <%=programList.size()%>개의 프로그램이 검색되었습니다.</p>

        <% if (programList != null && !programList.isEmpty()) { %>
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">
            <% for (Program p : programList) { %>
            <div class="col programDetail" data-prono="<%=p.getProNo()%>">
                <div class="card h-100 shadow-sm border-0 rounded-4 overflow-hidden">

                    <!-- 이미지 -->
                    <div class="ratio ratio-16x9">
                        <img src="<%=request.getContextPath()%><%=Constants.DEFAULT_UPLOAD_PATH%><%=p.getProImageUrl()%>.jpg"
                             class="w-100 h-100 object-fit-cover" alt="프로그램 이미지">
                    </div>

                    <!-- 카드 바디 -->
                    <div class="card-body">
                        <h5 class="card-title mb-2"><%=p.getProName()%></h5>
                        <p class="card-text text-muted small">
                            <%-- 간단 설명이 있으면 여기에 --%>
                            <%=p.getProCategory()%> / <%=p.getProLocation()%>
                        </p>
                    </div>

                    <!-- 하단 버튼 그룹 -->
                    <div class="card-footer bg-white border-top-0 d-flex justify-content-between align-items-center">
                        <div class="btn-group">
                            <button type="button" class="btn btn-sm btn-outline-primary"><%=p.getProType()%></button>
                            <button type="button" class="btn btn-sm btn-outline-secondary">
                                ♥ <%=p.getLikes() != null ? p.getLikes() : "0"%>
                            </button>
                        </div>
                        <small class="text-muted">ID: <%=p.getProNo()%></small>
                    </div>

                </div>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <div class="alert alert-warning mt-4 text-center" role="alert">
            조회된 프로그램 리스트가 없습니다.
        </div>
        <% } %>
    </div>
</section>
<script>
    // 프로그램 카드 전체 클릭 시
    $(".programDetail").click(e => {
        const proNo = $(e.currentTarget).data("prono");
        location.href = "<%=request.getContextPath()%>/program/detail?proNo=" + proNo;

    });

    // 내부 버튼 클릭 시, 이벤트 전파 방지
    $(".programDetail button").click(e => {
        e.stopPropagation(); // 이벤트가 상위로 전파되지 않게 함
    });

    document.addEventListener("DOMContentLoaded", function () {
        const buttons = document.querySelectorAll('.category-btn');
        const hiddenInput = document.getElementById('selectedCategoryInput');

        buttons.forEach(btn => {
            btn.addEventListener('click', function () {
                const isActive = this.classList.contains('active');

                // 모든 버튼 초기화
                buttons.forEach(b => b.classList.remove('active', 'btn-primary'));
                buttons.forEach(b => b.classList.add('btn-outline-secondary'));

                if (!isActive) {
                    this.classList.remove('btn-outline-secondary');
                    this.classList.add('active', 'btn-primary');
                    hiddenInput.value = this.getAttribute('data-category');
                } else {
                    hiddenInput.value = ''; // 선택 해제
                }
            });
        });
    });

</script>
<style>
    .programDetail {
        cursor: pointer;
    }
</style>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>