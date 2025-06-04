<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>


<section class="container py-5" style="max-width: 600px;">
	<div class="mb-4 text-center">
		<h2 class="fw-bold">🏢 기업 회원 가입</h2>
		<p class="text-muted">기업 정보를 입력하고 회원가입을 완료하세요.</p>
	</div>

	<div class="bg-white p-4 rounded-4 shadow-sm">
		<form action="<%=request.getContextPath()%>/company/enrollendcompany"
			  method="post" onsubmit="return validateCompanyForm()">

			<!-- 기업명 -->
			<div class="mb-3">
				<label class="form-label fw-semibold">기업명 <span class="text-danger">*</span></label>
				<input type="text" name="companyName" class="form-control" maxlength="50" placeholder="기업명을 입력해주세요" required>
			</div>

			<!-- 사업자 등록번호 -->
			<div class="mb-3">
				<label class="form-label fw-semibold">사업자 등록번호 <span class="text-danger">*</span></label>
				<input type="text" name="companyBinNo" id="companyBinNo" class="form-control" maxlength="10"
					   placeholder="'-' 제외 숫자만 입력" required>
			</div>

			<!-- 이메일 -->
			<div class="mb-3">
				<label class="form-label fw-semibold">이메일 <span class="text-danger">*</span></label>
				<input type="email" name="companyEmail" class="form-control" maxlength="100" placeholder="company@email.com" required>
			</div>

			<!-- 아이디 -->
			<div class="mb-3">
				<label class="form-label fw-semibold">아이디 <span class="text-danger">*</span></label>
				<input type="text" name="companyId" id="companyId" class="form-control" maxlength="16"
					   placeholder="4~16자 영문/숫자 조합" required>
			</div>

			<!-- 비밀번호 -->
			<div class="mb-3">
				<label class="form-label fw-semibold">비밀번호 <span class="text-danger">*</span></label>
				<input type="password" name="companyPw" id="companyPw" class="form-control"
					   placeholder="8자 이상, 대소문자/숫자/특수문자 포함" required>
			</div>

			<!-- 비밀번호 확인 -->
			<div class="mb-3">
				<label class="form-label fw-semibold">비밀번호 확인 <span class="text-danger">*</span></label>
				<input type="password" name="checkPw" id="checkPw" class="form-control"
					   placeholder="비밀번호 재입력" required>
			</div>

			<!-- 전화번호 -->
			<div class="mb-4">
				<label class="form-label fw-semibold">전화번호 <span class="text-danger">*</span></label>
				<input type="text" name="companyPhone" id="companyPhone" class="form-control" maxlength="11"
					   placeholder="숫자만 입력 (예: 0212345678)" required>
			</div>

			<div class="d-grid">
				<button type="submit" class="btn btn-primary" id="submitBtn" disabled>가입 완료</button>
			</div>
		</form>
	</div>
</section>


<script>
	const idReg = /^[a-zA-Z0-9]{4,16}$/;
	const pwReg = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\/\-]).{8,}$/;
	const numonly = /[^0-9]/g; //문자가 있니 없니
	
	const validateCompanyForm=()=>{
				//const companyId = $("#companyId").val().trim();
				const companyPw = $("#companyPw").val().trim();
				const binNo = $("#companyBinNo").val().trim();
				const companyPhone = $("#companyPhone").val().trim();
				const checkPw = $("#checkPw").val().trim();
				
				
				
				if(!pwReg.test(companyPw)){
					 alert("비밀번호는 영문, 숫자, 특수문자를 하나씩 포함한 8자 이상이어야 합니다.");
					 $("#companyPw").focus();
					 return false;
				}
				if(companyPw !== checkPw){
					 alert("비밀번호 확인이 일치하지 않습니다.");
					 $("#checkPw").focus();		
					 return false;
				}
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
<script>
//디바운서 -> 특정 딜레이시간을 발생시켜서 로직실행 지연시킴
	let timer;//디바운스하는 타이머 저장변수
	$("#companyId").keyup(((timer)=>{return e=>{//userId에 keyup 이벤트 바인딩
					if(timer) clearTimeout(timer);//존재하는 타이머 있으면 제거
					//시간 내에 다시 입력하면 이전 요청 취소
					
					timer=setTimeout(()=>{//이 뒤로부턴 0.5 가 지나고나서 실행될 로직

						const companyId=e.target.value.trim();
					
						$(e.target).next().remove();//기존 메세지 삭제하고 새 메세지 붙이기
						
						if (!idReg.test(companyId)) {
							$(e.target).after(
									$("<span>").text("형식에 맞지 않는 아이디").css("color","red"));
									$("#submitBtn").attr("disabled", true);
							$(e.target).focus();
							return false;
						}
					
						fetch("<%=request.getContextPath()%>/company/idduplicate?id="+companyId)
								.then(response=>{//fetch로 보내고 then으로 응답받고
									if(response.ok) return response.json();
									else alert("요청실패 "+response.status);
								}).then(data=>{
									$(e.target).next().remove();//기존 메세지 삭제하고 새 메세지 붙이기
								    $("#submitBtn").attr("disabled", true);
									if(data.result){
										$(e.target).after(
												$("<span>").text("사용할 수 있는 아이디").css("color","green"));
												$("#submitBtn").attr("disabled", false);
									}else{
										$(e.target).after(
												$("<span>").text("사용할 수 없는 아이디").css("color","red"));
												$("#submitBtn").attr("disabled", true);
									}
								}).catch(error=>{

								alert("중복체크 중 오류 발생");
								$("#submitBtn").attr("disabled", true);
								})
					},500);
					}
			})()
	);
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
<%@ include file="/WEB-INF/views/common/footer.jsp"%>