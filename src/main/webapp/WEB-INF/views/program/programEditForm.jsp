<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.giljobe.program.model.dto.*,
				 com.giljobe.common.ProCategory" %>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
    Program program = (Program) request.getAttribute("program");
	String selectedCategory = program.getProCategory();
%>
<section class="container py-5">
    <h2>프로그램 수정</h2>
    <form action="<%=request.getContextPath()%>/program/edit-submit" method="post" enctype="multipart/form-data">
        <input type="hidden" name="proNo" value="<%=program.getProNo()%>">

        <div class="mb-3">
            <label class="form-label">프로그램 이름</label>
            <input type="text" name="proName" class="form-control" value="<%=program.getProName()%>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">프로그램 유형</label>
            <input type="text" name="proType" class="form-control" value="<%=program.getProType()%>" required>
        </div>

        <div class="mb-3">
            <label class="form-label">주소</label>
            <input type="text" name="proLocation" class="form-control" value="<%=program.getProLocation()%>" required>
        </div>

        <div class="mb-3">
		    <label class="form-label">카테고리</label>
		    <select name="proCategory" class="form-select" required>
		        <% 
		            for (ProCategory c : ProCategory.values()) { 
		        %>
		            <option value="<%=c.name()%>" <%= c.name().equals(selectedCategory) ? "selected" : "" %>>
		                <%=c.name()%>
		            </option>
		        <% } %>
		    </select>
		</div>

        <div class="mb-3">
            <label class="form-label">프로그램 이미지</label><br>
            <img src="<%=request.getContextPath()%>/resources/upload/<%=program.getProImageUrl()%>" width="200"><br>
            <input type="file" name="proImage">
        </div>

        <div class="mt-4 d-flex gap-2">
            <button type="submit" class="btn btn-primary">수정 완료</button>
            <a href="<%=request.getContextPath()%>/program/detail?proNo=<%=program.getProNo()%>" class="btn btn-secondary">수정 취소</a>
        </div>
    </form>
</section>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
