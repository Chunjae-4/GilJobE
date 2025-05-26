<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>
<%@ page import="com.giljobe.common.ProCategory" %>
<%@ page import="java.util.Optional" %>
<%@ page import="com.giljobe.program.model.dto.Program" %>
<%@ page import="java.util.List" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<meta http-equiv="refresh" content="url=<%=request.getContextPath()%>/program/randomrecommend">
<% List<Program> programList = (List<Program>)request.getAttribute("randomRecommend");%>
<script>
    if (<%=programList == null%>){
        location.href = "<%=request.getContextPath()%>/program/randomrecommend";
    }

</script>
<div class="px-4 pt-5 my-5 text-center border-bottom ">
<%-- TODO: 진로 프로그램 검색바   --%>
    <div class=" d-flex flex-wrap align-items-center justify-content-center w-100">
        <form class="d-flex align-items-center  justify-content-center justify-content-center gap-2 mb-3 w-100" action="<%=request.getContextPath()%>/program/programsearchform">
            <span class="fw-bold">체험 프로그램 찾기</span>
            <input name="keyword" type="search" class="w-50 form-control form-control-light" placeholder="Search...(제목 일부 검색 가능)" aria-label="Search">
            <div class="btn-group">
                <button type="button" class="btn btn-primary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                    직업 카테고리
                </button>
                <ul class="dropdown-menu">
<%--                    직업 갯수: <%=ProCategory.values().length%>--%>
                    <%for(ProCategory sc: ProCategory.values()){%>
                        <% Optional<String> result = java.util.Arrays.stream(sc.getSubcategories()).reduce((prev, next) -> prev + '*' + next);%>
                    <li class="dropdown-item"><%=result.get()%></li>
                    <%}%>
                </ul>
            </div>
            <button class="btn btn-outline-light">🔎</button>
        </form>
    </div>

<%-- TODO: 랜덤 추천   --%>
    <div class="container px-4 py-5" id="custom-cards">
        <h2 class="pb-2 border-bottom">체험 프로그램 랜덤 추천</h2>
        <p>TODO: 임시로 3개까지 출력. 랜덤으로 돌려야함. 그리고 index 진입 -> 서블릿갔다가 주소창 안바뀌는법 물어봐야함</p>
        <p>게시글 연결 완료</p>
        <div class="row row-cols-1 row-cols-lg-3 align-items-stretch g-4 py-5">
            <%if (programList != null){%>
                <%for(Program p:programList){%>
                    <div class="col programDetail" data-prono="<%=p.getProNo()%>">
                        <div class="card card-cover h-100 overflow-hidden text-gray bg-light rounded-5 shadow-lg" style="background-image: url('<%=request.getContextPath()%><%=Constants.IMAGE_FILE_PATH%>/logo.png'); background-position : center; background-size: cover;">
                            <div class="d-flex flex-column h-100 p-5 pb-3 text-gray text-shadow-1">
                                <h2 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold"><%=p.getProName()%></h2>
                            </div>
                        </div>
                    </div>
                <%}%>
            <%}%>
        </div >
    </div>
</div>

<script>
    // 프로그램 카드 전체 클릭 시
    $(".programDetail").click(e=>{
        const proNo = $(e.currentTarget).data("prono");
        location.href = "<%=request.getContextPath()%>/program/detail?proNo=" + proNo;

    });

    // 내부 버튼 클릭 시, 이벤트 전파 방지
    $(".programDetail button").click(e => {
        e.stopPropagation(); // 이벤트가 상위로 전파되지 않게 함
    });
</script>
<style>
    .programDetail {
        cursor: pointer;
    }
</style>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
