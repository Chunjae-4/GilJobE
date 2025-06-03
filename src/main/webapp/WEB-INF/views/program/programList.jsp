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
<%
List<Program> programList = (List<Program>) request.getAttribute("programList");
int pageStart = (int) request.getAttribute("pageStart");
int pageEnd = (int) request.getAttribute("pageEnd");
int totalPage = (int) request.getAttribute("totalPage");
int cPage = (int) request.getAttribute("cPage");
String pageUri = (String) request.getAttribute("pageUri");
%>

<!-- 검색 섹션 -->
<section class="text-center py-5 mb-4">
    <div class="mb-4">
        <h1 class="fw-semibold mb-3">진로 체험 프로그램 페이지</h1>
        <p class="lead text-muted fst-italic">다양한 체험 프로그램을 만나보세요.</p>
    </div>

    <form role="search" action="<%=request.getContextPath()%>/program/programsearchform" method="get">
        <div class="d-flex justify-content-center">
            <div class="input-group" style="max-width: 600px;">
                <input type="search" name="keyword"
                       class="form-control form-control-lg rounded-start-pill border"
                       placeholder="검색어를 입력해서 원하는 체험을 찾아보세요." aria-label="Search">
                <button class="btn btn-primary btn-lg rounded-end-pill" type="submit">
                    🔍 검색
                </button>
            </div>
        </div>
    </form>
</section>

<% if(loginCompany != null) { %>
<section class="container mb-5">
    <div class="p-4 p-md-5 bg-light rounded-4 shadow-sm d-flex justify-content-between align-items-center flex-wrap gap-3">
        <div>
            <h4 class="fw-bold mb-1">진로 체험 프로그램 등록</h4>
            <p class="mb-0 text-muted">새로운 프로그램을 등록하여 청소년에게 새로운 꿈을 심어주세요.</p>
        </div>
        <a href="<%=request.getContextPath()%>/program/selectform" class="btn btn-primary btn-lg rounded-pill">
            ✏️ 프로그램 등록
        </a>
    </div>
</section>
<% } %>

<form method="get" action="<%=request.getContextPath()%>/program/programlist" id="filterForm" class="mb-5">
    <div class="container d-flex justify-content-end flex-wrap gap-3 align-items-center">
        <label for="categorySelect" class="form-label mb-0 fw-semibold text-secondary">카테고리 선택</label>
        <select class="form-select w-auto rounded-pill px-3 py-2" name="pro-category" id="categorySelect"
                onchange="document.getElementById('filterForm').submit();">
            <option value="" disabled selected>무슨 직업들이 있을까요?</option>
            <% for (ProCategory sc : ProCategory.values()) { %>
            <option value="<%= sc %>"><%= sc.getSubcategoriesStr() %></option>
            <% } %>
        </select>

        <a href="<%=request.getContextPath()%>/program/programlist"
           class="btn btn-outline-dark rounded-pill px-3 py-2">
            전체 보기
        </a>
    </div>
</form>


<section class="bg-body-tertiary py-5">
    <div class="container">
        <p class="mb-4 text-muted"><%=cPage%> 페이지입니다.</p>

        <% if (programList != null && !programList.isEmpty()) { %>
        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-4">
            <% for (Program p : programList) { %>
            <div class="col programDetail" data-prono="<%=p.getProNo()%>">
                <div class="card h-100 shadow-sm border-0 rounded-4 overflow-hidden">

                    <!-- 이미지 -->
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
                             alt="프로그램 이미지" loading="lazy">
                    </div>

                    <!-- 카드 본문 -->
                    <div class="card-body">
                        <h5 class="card-title mb-2"><%=p.getProName()%></h5>
                        <p class="card-text text-muted small">
                            <%=p.getProCategory()%> | <%=ProCategory.valueOf(p.getProCategory()).getSubcategoriesStr()%>
                        </p>
                        <p class="card-text text-muted small"><%=p.getProLocation()%></p>
                    </div>

                    <!-- 하단 버튼 -->
                    <div class="card-footer bg-white border-top-0 d-flex justify-content-between align-items-center">
                        <div class="btn-group">
                            <button type="button" disabled class="btn btn-sm btn-outline-primary"><%=p.getProType()%></button>

                            <%
                                boolean isLiked = false;
                                if (loginUser != null) {
                                    isLiked = com.giljobe.love.model.service.LoveService.getInstance().hasLoved(
                                            loginUser.getUserNo(), p.getProNo());
                                }
                            %>
                            <button type="button"
                                    class="btn btn-sm <%= isLiked ? "btn-danger" : "btn-outline-secondary" %>"
                                    data-prono="<%= p.getProNo() %>">
                                ♥ <span class="like-count"><%= p.getLikeCount() %></span>
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

<%--페이징 버튼 --%>
<section class="my-4">
    <ul class="pagination justify-content-center">
        <% if (totalPage != 1) { %>
        <li class="page-item <%= (pageStart == 1 ? "disabled" : "") %>">
            <a class="page-link" href="<%= (pageStart == 1 ? "#" : pageUri + "?cPage=" + (pageStart - 1)) %>">이전</a>
        </li>
        <% for (; pageStart <= pageEnd && pageStart <= totalPage; pageStart++) { %>
        <li class="page-item <%= (pageStart == cPage ? "active" : "") %>">
            <a class="page-link" href="<%= pageUri %>?cPage=<%= pageStart %>"><%= pageStart %></a>
        </li>
        <% } %>
        <li class="page-item <%= (pageStart > totalPage ? "disabled" : "") %>">
            <a class="page-link" href="<%= (pageStart > totalPage ? "#" : pageUri + "?cPage=" + pageStart) %>">다음</a>
        </li>
        <% } %>
    </ul>
</section>


<script>

    // 프로그램 카드 전체 클릭 시
    $(".programDetail").click(e => {
        const proNo = $(e.currentTarget).data("prono");
        location.href = "<%=request.getContextPath()%>/program/detail?proNo=" + proNo;

    });

 	// 내부 버튼 클릭 시, 이벤트 전파 방지
    $(".programDetail").on("click", "button", function(e) {
        // 버튼이 disabled 상태여도 전파를 막음
        // 좋아요 버튼 빠르게 클릭할 때 발생하는 거 대비
        /* e.stopPropagation(); */
        e.preventDefault();
    });

    document.addEventListener("DOMContentLoaded", function (e) {
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

     select.form-select {
         min-width: 220px;
     }

    #filterForm label {
        font-size: 1rem;
    }
</style>

<!-- loveToggle, 좋아요 버튼 반영 -->
<script>
    const contextPath = "<%= request.getContextPath() %>";
</script>
<script src="<%= request.getContextPath() %>/resources/js/loveToggle.js"></script>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>