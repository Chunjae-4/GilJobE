<%@page import="java.util.Comparator"%>
<%@page import="com.giljobe.application.model.dto.Application"%>
<%@page import="com.giljobe.program.model.dto.ProTime"%>
<%@page import="com.giljobe.program.model.dto.Round"%>
<%@page import="com.giljobe.program.model.dto.Program"%>
<%@page import="com.giljobe.user.model.dto.User"%>
<%@page import="com.giljobe.qna.model.dto.QNA"%>
<%@page import="java.util.List"%>
<%@page import="com.giljobe.company.model.dto.Company"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>
<% 
User loginUser = (User)session.getAttribute("user");
Company loginCompany = (Company)session.getAttribute("company");
Program program = (Program)request.getAttribute("program");

List<Round> rounds = (List<Round>)request.getAttribute("rounds");
Round selectedRound = (Round)request.getAttribute("selectedRound");
List<Round> availableRounds = (List<Round>)request.getAttribute("availableRounds");
List<Round> expiredRounds = (List<Round>)request.getAttribute("expiredRounds");
boolean noAvailableRounds = availableRounds.isEmpty();
List<ProTime> proTimes = (List<ProTime>) request.getAttribute("proTimes");
List<Application> userApps = (loginUser != null) ? loginUser.getApplications() : java.util.Collections.emptyList();
if (proTimes != null) {
    proTimes.sort(Comparator.comparing(ProTime::getStartTime));
}
java.text.SimpleDateFormat timeFormat = new java.text.SimpleDateFormat("HH:mm");
String imageUrl = "/resources/images/logo.png"; // 기본 이미지
if (program != null) {
    String dbImage = program.getProImageUrl();
    if (dbImage != null && !dbImage.trim().isEmpty() && !"null".equalsIgnoreCase(dbImage.trim())) {
        imageUrl = Constants.DEFAULT_UPLOAD_PATH + dbImage; // ex: /resources/upload/1/4/1.png
    }
}
boolean isLiked = false;
if (loginUser != null) {
    isLiked = com.giljobe.love.model.service.LoveService.getInstance().hasLoved(
        loginUser.getUserNo(), program.getProNo());
}
boolean isMyProgram = false;
if (loginCompany != null && loginCompany.getComNo() == program.getComNoRef()) {
    isMyProgram = true;
}
%>
 <%-- bootstrap css, js --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="icon" type="image/png" sizes="32x32" href="<%=request.getContextPath()%><%=Constants.IMAGE_FILE_PATH%>/favicon-32x32.png">
	<script src="<%=request.getContextPath()%>/resources/js/jquery-3.7.1.min.js"></script>
<	
	
	
	<!-- Q&A 영역 -->
	<div class="program-qna">
	  <%
  		Company company = com.giljobe.company.model.service.CompanyService.companyService().searchCompanyByNo(program.getComNoRef());

    if (program != null) {
        List<QNA> qnaList = com.giljobe.qna.model.service.QNAService.qnaService().searchQNAByProNo(program.getProNo());
        request.setAttribute("qnaList", qnaList);
        request.setAttribute("program", program); // 이것도 필요!
    } else {
        out.println("<div class='alert alert-danger'>프로그램 정보가 없습니다.</div>");
    }
%>
		<jsp:include page="/WEB-INF/views/program/qnaComponent.jsp" />

	</div> 

<%-- <%
	User user = (User)request.getAttribute("user");
	List<QNA> qnas = user.getQnas();
%>
<ul>
<%for( QNA q: qnas){%>
	<li>문의 내용 : <%=q.getQnaContent() %></li>
	<li>답변 : <%=q.getAnswer() %></li>
<%}%>
</ul>  --%>