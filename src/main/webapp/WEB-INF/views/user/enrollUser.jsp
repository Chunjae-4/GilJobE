<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>


<div class="form-wrapper">
	<form action="<%=request.getContextPath()%>/user/enrolluserend"
		method="post" onsubmit="return validateForm()">
		<div class="mb-3">
			<label for="name" class="form-label">이름<span
				style="color: red">*</span></label> <input type="text" class="form-control"
				name="userName" placeholder="성함을 입력해주세요" required>
		</div>
		<div class="mb-3">
			<label for="id" class="form-label">아이디<span
				style="color: red">*</span></label> <input type="text" class="form-control"
				name="userId" id="userId"
				placeholder="4~16자 사이의 영문 대소문자, 숫자 (특수문자 입력불가)" required>
		</div>
		<div class="mb-3">
			<label for="password" class="form-label">비밀번호<span
				style="color: red">*</span></label> <input type="password"
				class="form-control" name="userPw" id="userPw"
				placeholder="8자리 이상 영문 대소문자, 숫자, 특수문자" required>
		</div>
		<div class="mb-3">
			<label for="checkPassword" class="form-label">비밀번호 확인<span
				style="color: red">*</span></label> <input type="password"
				class="form-control" name="checkPw" id="checkPw" placeholder="비밀번호 재입력" required>
		</div>
		<div class="mb-3">
			<label for="phone" class="form-label">전화번호<span
				style="color: red">*</span></label> <input type="text" class="form-control"
				name="userPhone" placeholder="'-'제외하고 입력" id="phone" required>
		</div>
		<div class="mb-3">
			<label for="nickname" class="form-label">닉네임<span
				style="color: red">*</span></label> <input
				type="text" class="form-control" name="userNickName" id="userNickName"
				placeholder="최대 10자 까지 입력(특수문자 입력불가)" required>
		</div>
		<div class="mb-3">
			<label for="email" class="form-label">이메일<span
				style="color: red">*</span></label> <input type="email" class="form-control"
				name="userEmail" placeholder="user@email.com" required>
		</div>
		<div class="mb-3">
			<label for="birth" class="form-label">생년월일<span
				style="color: red">*</span></label> <input type="date" class="form-control"
				name="userBirth" required>
		</div>

		<input type="submit" class="btn btn-primary" value="가입" id="submitBtn" disabled>
	</form>
</div>

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
<script>
	const idReg = /^[a-zA-Z0-9]{4,16}$/;
	const pwReg = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\/\-]).{8,}$/;
	const phoneReg= /[^0-9]/g; //hmm
	const validateForm=()=>{
				const userId = $("#userId").val().trim();
				const userPw = $("#userPw").val().trim();
				const userPhone = $("#phone").val().trim();
				
				if(!pwReg.test(userPw)){
					 alert("비밀번호는 영문, 숫자, 특수문자를 하나씩 포함한 8자 이상이어야 합니다.");
					 $("#userPw").focus();
					 return false;
				}
				if(userPw!==$("#checkPw").val().trim()){
					 alert("비밀번호가 일치하지 않습니다.");
					 $("#checkPw").focus();		
					 return false;
				}
				if($("#userNickName").val().trim()===""){
					alert("닉네임을 입력해주세요.");
					$("#userNickname").focus();
					return false;
				}
				if(!phoneReg.test(userPhone)){
					alert("전화번호 형식에 맞지 않습니다. -를 제외한 숫자만 입력해주세요.");
					$("#phone").focus();
					return false;
				}
				return true;
		}
		
</script>
<script>
//디바운서 -> 특정 딜레이시간을 발생시켜서 로직실행 지연시킴
	let timer;//디바운스하는 타이머 저장변수
	$("#userId").keyup(((timer)=>{return e=>{//userId에 keyup 이벤트 바인딩
					if(timer) clearTimeout(timer);//존재하는 타이머 있으면 제거
					//시간 내에 다시 입력하면 이전 요청 취소
					
					timer=setTimeout(()=>{//이 뒤로부턴 0.5 가 지나고나서 실행될 로직

						const userId=e.target.value.trim();
					
						if(!idReg.test(userId)){
							$(e.target).next().remove();//기존 메세지 삭제하고 새 메세지 붙이기
							$(e.target).after(
									$("<span>").text("사용할 수 없는 아이디").css("color","red"));
							$("#submitBtn").attr("disabled", true);//정규표현식에 맞지않으면 버튼 비활성화
							
							return;
						}
					
						fetch("<%=request.getContextPath()%>/user/idduplicate?id="+userId)
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
								});
					},500);
					}
			})()
	);
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>