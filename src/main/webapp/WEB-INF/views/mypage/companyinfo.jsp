<%@page import="com.giljobe.company.model.dto.Company"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%
	Company loginCompany = (Company)session.getAttribute("company");
%>

<h4 class="fw-bold mb-2">내 정보 수정</h4>
<p class="text-muted mb-4" style="font-size: 0.95rem;">회원가입 시 입력한 정보를 확인하고 수정할 수 있어요.</p>

<form action="<%=request.getContextPath()%>/company/updateCompany" method="post" onsubmit="return validateForm()">
	<div class="row gy-4">

		<!-- 아이디 -->
		<div class="col-12">
			<label for="companyId" class="form-label">아이디 <span class="text-danger">*</span></label>
			<input type="text" class="form-control" name="companyId" id="companyId"
				   value="<%=loginCompany.getComId() %>" readonly>
			<div class="form-text text-muted">아이디는 변경할 수 없습니다.</div>
		</div>

		<!-- 이름 -->
		<div class="col-12">
			<label for="companyName" class="form-label">기업명 <span class="text-danger">*</span></label>
			<input type="text" class="form-control" name="companyName" maxlength="50"
				   value="<%=loginCompany.getComName() %>" required>
		</div>

		<!-- 전화번호 -->
		<div class="col-12">
			<label for="companyPhone" class="form-label">전화번호 <span class="text-danger">*</span></label>
			<input type="text" class="form-control" name="companyPhone" id="companyPhone" maxlength="11"
				   placeholder="예: 01012345678"
				   value="<%=loginCompany.getComPhone() %>" required>
		</div>

		<!-- 사업자 등록번호 -->
		<div class="col-12">
			<label for="companyBinNo" class="form-label">사업자 등록번호 <span class="text-danger">*</span></label>
			<input type="text" class="form-control" name="companyBinNo" maxlength="10"
				   value="<%=loginCompany.getComBinNo() %>" required>
		</div>

		<!-- 이메일 -->
		<div class="col-12">
			<label for="companyEmail" class="form-label">이메일 <span class="text-danger">*</span></label>
			<input type="email" class="form-control" name="companyEmail" maxlength="100"
				   value="<%=loginCompany.getComEmail() %>" required>
		</div>

		<!-- 버튼 -->
		<div class="col-12 d-flex justify-content-end gap-2 mt-3">
			<button type="submit" class="btn btn-primary px-4 py-2 rounded-pill">정보 수정</button>
			<button type="button" class="btn btn-outline-secondary px-4 py-2 rounded-pill"
      		  data-bs-toggle="modal" data-bs-target="#changePwModal">비밀번호 변경</button>
		</div>
	</div>
</form>
<!-- 비밀번호 변경 모달 -->
<div class="modal fade" id="changePwModal" tabindex="-1" aria-labelledby="changePwModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <form action="<%=request.getContextPath()%>/company/updatePw" method="post" class="modal-content" onsubmit="return PwvalidationForm()">
      <div class="modal-header">
        <h5 class="modal-title" id="changePwModalLabel">비밀번호 변경</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="닫기"></button>
      </div>
      <div class="modal-body">
        <div class="mb-3">
          <label for="companyPw" class="form-label">현재 비밀번호</label>
          <input type="password" class="form-control" id="companyPw" name="companyPw" required>
        </div>
        <div class="mb-3">
          <label for="newPw" class="form-label">새 비밀번호</label>
          <input type="password" class="form-control" id="newPw" name="newPw" required>
        </div>
        <div class="mb-3">
          <label for="confirmPw" class="form-label">새 비밀번호 확인</label>
          <input type="password" class="form-control" id="checkPw" name="checkPw" required>
        </div>
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-primary px-4 py-2 rounded-pill">변경</button>
        <button type="button" class="btn btn-outline-secondary px-4 py-2 rounded-pill" data-bs-dismiss="modal">취소</button>
      </div>
    </form>
  </div>
</div>
