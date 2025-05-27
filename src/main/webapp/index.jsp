<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"
         import="com.giljobe.common.Constants" %>
<%@ page import="com.giljobe.common.ProCategory" %>
<%@ page import="java.util.Optional" %>
<%@ page import="com.giljobe.program.model.dto.Program" %>
<%@ page import="java.util.List" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<meta http-equiv="refresh" content="url=<%=request.getContextPath()%>/program/randomrecommend">
<% List<Program> randomRecommend = (List<Program>) request.getAttribute("randomRecommend");%>
<script>
    if (<%=randomRecommend == null%>) {
        location.href = "<%=request.getContextPath()%>/program/randomrecommend";
    }
</script>

<div class="container py-5">
    <!-- 검색 섹션 -->
    <section class="text-center mb-5 py-5 ">
        <h1 class="mb-4 "style="font-size: 2rem; font-weight: 300;">체험 프로그램 찾기</h1>

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
            <div class="d-flex flex-wrap justify-content-center gap-2 mt-3" style="max-width: 700px; margin: 0 auto;">
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
    <!-- 랜덤 추천 섹션 -->
    <section class="bg-light py-5 rounded-5 ">
        <div class="container-fluid px-4">
            <div class="row align-items-center">

                <!-- 왼쪽: 타이틀 -->
                <div class="col-lg-4 mb-4 mb-lg-0">
                    <h2 class="fw-bold mb-3">체험 프로그램<br>랜덤 추천</h2>
                    <p class="text-muted">새로운 체험을 발견해보세요!</p>
                </div>

                <!-- 오른쪽: 캐러셀 -->
                <div class="col-lg-8">
                    <div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
                        <div class="carousel-inner rounded-4 shadow overflow-hidden">
                            <% if (randomRecommend != null) {
                                boolean isFirst = true;
                                for (Program p : randomRecommend) { %>
                            <div class="carousel-item <%= isFirst ? "active" : "" %> programDetail"
                                 data-prono="<%=p.getProNo()%>">
                                <div class="ratio ratio-16x9">
                                    <img src="<%=request.getContextPath()%><%=Constants.DEFAULT_UPLOAD_PATH%><%=p.getProImageUrl()%>.jpg"
                                         class="d-block w-100 object-fit-cover" alt="프로그램 이미지">
                                </div>
                                <!-- 프로그램 이름 + 카테고리 묶은 왼쪽 상단 캡션 -->
                                <div class="position-absolute top-0 start-0 m-3 px-4 py-3 bg-dark bg-opacity-75 text-white rounded-3 shadow" style="font-size: 1.1rem; font-weight: 200; max-width: 70%;">

                                    <!-- 프로그램 이름 -->
                                    <div class="fw-semibold fs-4 mb-1"><%= p.getProName() %></div>

                                    <!-- 카테고리 (작은 글씨, 연한 톤) -->
                                    <div class="text-white-50" style="font-size: 0.95rem;">
                                        <%= p.getProCategory() %>
                                    </div>
                                </div>
                            </div>
                            <% isFirst = false; } } %>
                        </div>

                        <!-- 캐러셀 컨트롤 -->
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleAutoplaying"
                                data-bs-slide="prev" style="width: 5%;">
                            <span class="carousel-control-prev-icon bg-dark bg-opacity-50 rounded-circle p-2" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleAutoplaying"
                                data-bs-slide="next" style="width: 5%;">
                            <span class="carousel-control-next-icon bg-dark bg-opacity-50 rounded-circle p-2" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>
                </div>

            </div>
        </div>
    </section>
</div>
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
