<%@page import="com.giljobe.company.model.dto.Company"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%
	Company loginCompany = (Company)session.getAttribute("company");
%>
<section class="form-wrapper">
	<form action="<%=request.getContextPath()%>/company/Company"
		method="post" onsubmit="return validateForm()">
		<div class="mb-3">
			<label for="name" class="form-label">기업명<span
				style="color: red">*</span></label> <input type="text" class="form-control"
				name="companyName" placeholder="개명하셨나요?" value="<%=loginCompany.getComName() %>" required>
		</div>
		<div class="mb-3">
			<label for="id" class="form-label">아이디<span
				style="color: red">*</span></label> <input type="text" class="form-control"
				name="companyId" id="userId"
				value="<%=loginCompany.getComId() %>" readonly>
		</div>
		<div class="mb-3">
			<label for="phone" class="form-label">전화번호<span
				style="color: red">*</span></label> <input type="text" class="form-control"
				name="companyPhone" placeholder="'-'제외하고 입력" id="companyPhone" value="<%=loginCompany.getComPhone() %>" required>
		</div>
		<div class="mb-3">
			<label for="binNo" class="form-label">사업자 등록번호<span
				style="color: red">*</span></label> <input type="text" class="form-control"
				name="companyBinNo" id="companyBinNo" value="<%=loginCompany.getComBinNo() %>"
				placeholder="-제외 입력" required>
		</div>
		<div class="mb-3">
			<label for="email" class="form-label">이메일<span
				style="color: red">*</span></label> <input type="email" class="form-control"
				name="companyEmail" placeholder="company@email.com" value="<%=loginCompany.getComEmail() %>" required>
		</div>
		<input type="submit" value="회원 정보 수정" id="submitBtn"> <input type="submit" id="pwsubmitBtn"
				value="비밀번호수정"> 
	</form>
</section>
<script>
	const numonly = /[^0-9]/g; //문자가 있니 없니
	
	const validateForm=()=>{
				const companyPhone = $("#companyPhone").val().trim();
				const binNo = $("#companyBinNo").val().trim();
				if(numonly.test(companyPhone)){ // 문자 없으면 false 잘썻으면 false !때문에 true
					alert("전화번호 형식에 맞지 않습니다. -를 제외한 숫자만 입력해주세요.");
					$("#companyPhone").focus();
					return false;
				}
				if(numonly.test(binNo)){
					alert("사업자 등록번호 형식에 맞지 않습니다. -를 제외한 숫자만 입력해주세요.");
					$("#companyBinNo").focus();
					return false;
				}
				return true;
		}
		
</script>

<style>
.form-wrapper {
  max-width: 500px;
  margin: 0 auto;
  min-height: calc(100vh - 210px); /* 화면 전체 높이 - (header+footer 높이) */
  background-color: #f9f9f9;
  padding: 2rem;
  border: 1px solid #ddd;
  border-radius: 8px;
  box-sizing: border-box;
}

</style>