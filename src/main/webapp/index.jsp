<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>
<%@ page import="com.giljobe.common.ProCategory" %>
<%@ page import="java.util.Optional" %>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container-fluid"></div>
<div class="px-4 pt-5 my-5 text-center border-bottom ">
<%-- TODO: 진로 프로그램 검색바   --%>
    <div class=" d-flex flex-wrap align-items-center justify-content-center w-100">
        <form class="d-flex align-items-center  justify-content-center justify-content-center gap-2 mb-3 w-100" action="<%=request.getContextPath()%>/program/programsearchform">
            <span class="fw-bold">체험 프로그램 찾기</span>
            <input name="keyword" type="search" class="w-50 form-control form-control-light" placeholder="Search...(개발중)" aria-label="Search">
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

        <div class="row row-cols-1 row-cols-lg-3 align-items-stretch g-4 py-5">
            <div class="col">
                <div class="card card-cover h-100 overflow-hidden text-gray bg-light rounded-5 shadow-lg" style="background-image: url('<%=request.getContextPath()%><%=Constants.IMAGE_FILE_PATH%>/logo.png'); background-position : center; background-size: cover;">
                    <div class="d-flex flex-column h-100 p-5 pb-3 text-gray text-shadow-1">
                        <h2 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">1</h2>
<%--                        <ul class="d-flex list-unstyled mt-auto">--%>
<%--                            <li class="me-auto">--%>
<%--                                <img src="https://github.com/twbs.png" alt="Bootstrap" width="32" height="32" class="rounded-circle border border-white">--%>
<%--                            </li>--%>
<%--                            <li class="d-flex align-items-center me-3">--%>
<%--                                <svg class="bi me-2" width="1em" height="1em"><use xlink:href="#geo-fill"></use></svg>--%>
<%--                                <small>Earth</small>--%>
<%--                            </li>--%>
<%--                            <li class="d-flex align-items-center">--%>
<%--                                <svg class="bi me-2" width="1em" height="1em"><use xlink:href="#calendar3"></use></svg>--%>
<%--                                <small>3d</small>--%>
<%--                            </li>--%>
<%--                        </ul>--%>
                    </div>
                </div>
            </div>
        </div >
    </div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
