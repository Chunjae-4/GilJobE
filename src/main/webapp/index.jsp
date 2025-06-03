<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"
         import="com.giljobe.common.Constants" %>
<%@ page import="com.giljobe.common.ProCategory" %>
<%@ page import="java.util.Optional" %>
<%@ page import="com.giljobe.program.model.dto.Program" %>
<%@ page import="java.util.List" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<% List<Program> randomRecommend = (List<Program>) application.getAttribute("randomRecommend");%>
<div class="container-fluid px-4 py-2 mb-5">
    <!-- ✅ 검색 섹션 -->
    <section class="text-center py-5 mb-5">
        <div class="mb-4">
            <h1 class="fw-semibold mb-3">체험 프로그램 검색</h1>
            <p class="text-muted fst-italic">키워드를 입력하고 원하는 체험을 찾아보세요!</p>
        </div>
        <form role="search" action="<%=request.getContextPath()%>/program/programsearchform" method="get">
            <div class="d-flex justify-content-center">
                <div class="input-group" style="max-width: 600px;">
                    <input type="search" name="keyword"
                           class="form-control form-control-lg rounded-start-pill border"
                           placeholder="검색어를 입력해서 원하는 체험을 찾아보세요." aria-label="Search">
                    <button class="btn btn-primary btn-lg rounded-end-pill shadow-sm" type="submit">
                        🔍 검색
                    </button>
                </div>
            </div>
        </form>
    </section>

    <section class="container-fluid bg-opacity-10 text-center py-4 mb-4 border-start border-4 border-warning rounded-3"
             style="background-color: rgba(246, 233, 215, 0.25);">
        <p class="fst-italic fs-4 fw-semibold mt-1 mb-2">
            “작은 체험이 인생의 방향을 바꿉니다.”
        </p>
        <p class="text-muted mb-0">청소년 진로 탐색의 첫걸음은 체험입니다</p>
    </section>

    <!-- ✅ 랜덤 추천 섹션 -->
    <section class="bg-light rounded-4 shadow-sm py-5 px-4">
        <div class="row align-items-center g-5">
            <!-- 텍스트 -->
            <div class="col-lg-4 text-center text-lg-start">
                <h2 class="fw-bold mb-4"> 체험 프로그램 <br class="d-none d-lg-block"> 랜덤 추천 </h2>
                <p class="text-muted fs-6">새로운 체험을 발견해보세요!</p>
            </div>

            <!-- 캐러셀 -->
            <div class="col-lg-8">
                <div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner rounded-4 overflow-hidden shadow-sm">
                        <% if (randomRecommend != null) {
                            boolean isFirst = true;
                            for (Program p : randomRecommend) { %>
                        <div class="carousel-item <%= isFirst ? "active" : "" %> programDetail"
                             data-prono="<%=p.getProNo()%>">
                            <div class="ratio ratio-16x9">
                                <%
                                    String imagePath;
                                    if (p.getProImageUrl() != null && !p.getProImageUrl().trim().isEmpty()) {
                                        imagePath = Constants.DEFAULT_UPLOAD_PATH + p.getProImageUrl();
                                    } else {
                                        imagePath = "/resources/images/logo.png";
                                    }
                                %>
                                <img src="<%= request.getContextPath() + imagePath %>"
                                     class="d-block w-100 object-fit-cover"
                                     alt="<%= p.getProName() %> 썸네일 이미지">
                            </div>
                            <!-- 캡션 -->
                            <div class="position-absolute top-0 start-0 m-3 px-4 py-3 bg-dark bg-opacity-75 text-white rounded-3 shadow-sm"
                                 style="font-size: 1.05rem; font-weight: 300; max-width: 70%;">
                                <div class="fw-semibold fs-5 mb-1"><%= p.getProName() %></div>
                                <div class="text-white-50 small">
                                    <%= ProCategory.valueOf(p.getProCategory()).getSubcategoriesStr() %> |
                                    <%= p.getProCategory() %>
                                </div>
                            </div>
                        </div>
                        <% isFirst = false; } } %>
                    </div>

                    <!-- 캐러셀 컨트롤 -->
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleAutoplaying"
                            data-bs-slide="prev" style="width: 10%;">
                        <span class="carousel-control-prev-icon bg-dark bg-opacity-50 rounded-circle p-2"
                              aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleAutoplaying"
                            data-bs-slide="next" style="width: 10%;">
                        <span class="carousel-control-next-icon bg-dark bg-opacity-50 rounded-circle p-2"
                              aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
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
        const searchInput = document.querySelector('input[name="keyword"]');
        const originalPlaceholder = searchInput.placeholder;
        let index = 0;
        const placeholders = [
            "요리",
            "코딩",
            "운전",
            "진로 탐색",
            "자연",
            "창업"
        ];
        searchInput.addEventListener("focus", function () {
            searchInput.placeholder = "예시: 요리, 축구, 개발, 게임 ..";
        });

        searchInput.addEventListener("blur", function () {
            if (!searchInput.value.trim()) {
                searchInput.placeholder = originalPlaceholder;
            }
        });
        // 주기적으로 키워드 자동 순환 (입력 중일 땐 멈춤)
        setInterval(() => {
            if (document.activeElement !== searchInput && searchInput.value.trim() === "") {
                searchInput.placeholder = "오늘 " + placeholders[index] + " 프로그램 어떠세요? ✨";
                index = (index + 1) % placeholders.length;
            }
        }, 3000); // 3초마다 변경
    });

</script>
<style>
    .programDetail {
        cursor: pointer;
    }

</style>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
