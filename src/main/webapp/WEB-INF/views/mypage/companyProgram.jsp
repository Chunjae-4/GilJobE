<%@page import="com.giljobe.program.model.dto.Program"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>


<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<%
  List<Program> pro =(List<Program>)request.getAttribute("programs");
%>
<div class="table-responsive">
  <table class="table table-hover align-middle shadow-sm border rounded-3 overflow-hidden">
    <thead class="table-light">
    <tr>
      <th scope="col">프로그램 이름</th>
    </tr>
    </thead>
    <tbody>
    <% if (pro != null && !pro.isEmpty()) {
      for (Program p : pro) { %>
    <tr>
      <td>
        <a href="<%=request.getContextPath()%>/program/detail?proNo=<%=p.getProNo()%>" class="text-decoration-none text-primary fw-semibold">
          <%= p.getProName() %>
        </a>
      </td>
    </tr>
    <% }
    } else { %>
    <tr>
      <td class="text-center text-muted py-4">등록된 프로그램이 없습니다.</td>
    </tr>
    <% } %>
    </tbody>
  </table>
</div>