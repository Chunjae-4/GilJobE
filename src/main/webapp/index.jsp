<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container-fluid"></div>
<div class="px-4 pt-5 my-5 text-center border-bottom ">
<%-- TODO: 진로 프로그램 검색바   --%>
    <div class=" d-flex flex-wrap align-items-center justify-content-center w-100">
        <form class="d-flex align-items-center  justify-content-center justify-content-center gap-2 mb-3 w-100">
            <span class="fw-bold">체험 프로그램 찾기</span>
            <input type="search" class="w-50 form-control form-control-light" placeholder="Search..." aria-label="Search">
            <button type="button" class="btn btn-outline-light">🔎</button>
        </form>
    </div>

<%-- TODO: 랜덤 추천   --%>
    <div class="container px-4 py-5" id="custom-cards">
        <h2 class="pb-2 border-bottom">체험 프로그램 랜덤 추천</h2>

        <div class="row row-cols-1 row-cols-lg-3 align-items-stretch g-4 py-5">
            <div class="col">
                <div class="card card-cover h-100 overflow-hidden text-white bg-light rounded-5 shadow-lg" style="background-image: url('<%=request.getContextPath()%><%=Constants.IMAGE_FILE_PATH%>/logo.png'); background-position : center; background-size: cover;">
                    <div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1">
                        <h2 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">1</h2>
                        <ul class="d-flex list-unstyled mt-auto">
                            <li class="me-auto">
                                <img src="https://github.com/twbs.png" alt="Bootstrap" width="32" height="32" class="rounded-circle border border-white">
                            </li>
                            <li class="d-flex align-items-center me-3">
                                <svg class="bi me-2" width="1em" height="1em"><use xlink:href="#geo-fill"></use></svg>
                                <small>Earth</small>
                            </li>
                            <li class="d-flex align-items-center">
                                <svg class="bi me-2" width="1em" height="1em"><use xlink:href="#calendar3"></use></svg>
                                <small>3d</small>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg" style="background-image: url('unsplash-photo-2.jpg');">
                    <div class="d-flex flex-column h-100 p-5 pb-3 text-white text-shadow-1">
                        <h2 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">2</h2>
                        <ul class="d-flex list-unstyled mt-auto">
                            <li class="me-auto">
                                <img src="https://github.com/twbs.png" alt="Bootstrap" width="32" height="32" class="rounded-circle border border-white">
                            </li>
                            <li class="d-flex align-items-center me-3">
                                <svg class="bi me-2" width="1em" height="1em"><use xlink:href="#geo-fill"></use></svg>
                                <small>Pakistan</small>
                            </li>
                            <li class="d-flex align-items-center">
                                <svg class="bi me-2" width="1em" height="1em"><use xlink:href="#calendar3"></use></svg>
                                <small>4d</small>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

            <div class="col">
                <div class="card card-cover h-100 overflow-hidden text-white bg-dark rounded-5 shadow-lg" style="background-image: url('unsplash-photo-3.jpg');">
                    <div class="d-flex flex-column h-100 p-5 pb-3 text-shadow-1">
                        <h2 class="pt-5 mt-5 mb-4 display-6 lh-1 fw-bold">3</h2>
                        <ul class="d-flex list-unstyled mt-auto">
                            <li class="me-auto">
                                <img src="https://github.com/twbs.png" alt="Bootstrap" width="32" height="32" class="rounded-circle border border-white">
                            </li>
                            <li class="d-flex align-items-center me-3">
                                <svg class="bi me-2" width="1em" height="1em"><use xlink:href="#geo-fill"></use></svg>
                                <small>California</small>
                            </li>
                            <li class="d-flex align-items-center">
                                <svg class="bi me-2" width="1em" height="1em"><use xlink:href="#calendar3"></use></svg>
                                <small>5d</small>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <h1 class="display-4 fw-bold">Context Path [Home]</h1>
    <div class="col-lg-6 mx-auto">
        <p class="lead mb-4">내용</p>
    </div>
    <div class="overflow-hidden" style="max-height: 100vh;">
        <div class="container px-5">
            <img src="<%=request.getContextPath()%><%=Constants.IMAGE_FILE_PATH%>/logo.png" class="img-fluid border rounded-3 shadow-lg mb-4" alt="Example image" width="700" loading="lazy">
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>
