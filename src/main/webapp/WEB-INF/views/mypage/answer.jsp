
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>
<%@ page import="com.giljobe.user.model.dto.User" %>
<%@ page import="com.giljobe.company.model.dto.Company" %>
<%@ page import="com.giljobe.program.model.dto.Program" %>
<%@ page import="com.giljobe.qna.model.dto.QNA" %>
<%@ page import="java.util.List" %>

<%
    Company loginCompany = (Company)session.getAttribute("company");
    List<QNA> qnaList = (List<QNA>)request.getAttribute("companyQnaList");
    System.out.println(qnaList);
%>

<div class="card border-0 shadow-sm rounded-4 mb-4">
    <div class="card-header bg-white fw-bold">내 Q&A 목록</div>
    <div class="card-body">

        <% if (qnaList == null || qnaList.isEmpty()) { %>
        <div class="text-muted text-center">내가 작성한 Q&A가 없습니다.</div>
        <% } else { %>
        <div class="list-group">
            <% for (QNA q : qnaList) { %>
            <a href="<%=request.getContextPath()%>/program/detail?proNo=<%=q.getProNoRef()%>"
               class="list-group-item list-group-item-action mb-3 rounded-3 border text-decoration-none text-dark">

                <div class="mb-2">
                    <strong class="text-primary">QNA</strong><br>
                    <span class="fw-semibold">상대 질문:</span> <%=q.getQnaContent() %>
                </div>

                <% if (q.getAnswer() != null && !q.getAnswer().isEmpty()) { %>
                <div class="bg-light p-3 rounded">
                    <span class="fw-semibold text-success">답변:</span><br>
                    <%= q.getAnswer() %>
                </div>
                <% } else { %>
                <div class="text-muted">아직 답변을 등록하지 않았습니다.</div>
                <% } %>

            </a>
            <% } %>
        </div>
        <% } %>

    </div>
</div>