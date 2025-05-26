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
<% List<Program> programList = (List<Program>)request.getAttribute("programList");%>
<section class="py-5 text-center container-fluid">
    <div class="row py-lg-5">
        <div class="col-lg-10 col-md-12 mx-auto">
            <h1 class="fw-light">진로 체험 프로그램 페이지</h1>
            <p class="lead text-body-secondary">다양한 체험 프로그램을 만나보세요.</p>
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
            <p>programList count :<%=programList.size()%></p>
            <%--프로그램 리스트가 있다면--%>
            <% if(programList != null && !programList.isEmpty()){%>
            <div class="album py-5 bg-body-tertiary container-fluid ">
                <div class="container">
                    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
                    <% for (Program p : programList) {%>
                        <div class="col programDetail" data-prono="<%=p.getProNo()%>">
                        
                            <div class="card shadow-sm">
                            	<div>
	                                <img src="<%=request.getContextPath()%><%=Constants.IMAGE_FILE_PATH%>/logo.png" style="background-size: contain" class="bd-placeholder-img card-img-top" height="250" width="100%">
	                                <div class="card-body"><p class="card-text"><%=p.getProName()%></p>
	                                    <%=p.toString()%>
                                 </div>   
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div class="btn-group">
                                            <button type="button" class="btn btn-sm btn-outline-secondary"><%=p.getProType()%></button>
                                            <button type="button" class="btn btn-sm btn-outline-secondary">Like: <%=p.getLikes() != null? p.getLikes() : '0'%></button>
                                            <button type="button" class="btn btn-sm btn-outline-secondary"><%=p.getProLocation()%></button>
                                        </div>
                                        <small class="text-body-secondary">뭐넣지</small></div>
                                </div>
                            </div>
                        </div>
                    <%}%>
                    </div>
                </div>
            </div>
            <%--만약 프로그램 리스트가 없다면--%>
            <%} else {%>
            <div>조회된 프로그램 리스트가 없습니다.</div>
            <%--TODO: 프로그램 랜덤 추천을 여기에 출력 및 연결--%>
            <%}%>

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