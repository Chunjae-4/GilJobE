<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>


<div class="form-wrapper">
	<form action="<%=request.getContextPath()%>/user/enrolluserend"
		method="post">
		<div class="mb-3">
			<label for="name" class="form-label">이름<span style="color:red">*</span></label> <input type="text"
				class="form-control" name="userName" required>
		</div>
		<div class="mb-3">
			<label for="id" class="form-label">아이디<span style="color:red">*</span></label> <input type="text"
				class="form-control" name="userId" id="userId_" placeholder="최대 20자 까지 입력(특수문자 입력불가)" required>
		</div>
		<div class="mb-3">
			<label for="Password" class="form-label">비밀번호<span style="color:red">*</span></label> <input
				type="password" class="form-control" name="userPw" placeholder="8자리 이상 영문 대소문자, 숫자, 특수문자 중 2가지 이상을 조합하여 사용" required>
		</div>
		<div class="mb-3">
			<label for="checkPassword" class="form-label">비밀번호 확인<span style="color:red">*</span></label>
			<input type="password" class="form-control" name="checkPw" placeholder="비밀번호 재입력" required>
		</div>
		<div class="mb-3">
			<label for="checkPassword" class="form-label">전화번호<span style="color:red">*</span></label> <input
				type="text" class="form-control" name="userPhone" placeholder="'-'제외하고 입력" required>
		</div>
		<div class="mb-3">
			<label for="nickname" class="form-label">닉네임</label> <input
				type="text" class="form-control" name="userNickName" placeholder="최대 10자 까지 입력(특수문자 입력불가)">
		</div>
		<div class="mb-3">
			<label for="checkPassword" class="form-label">이메일<span style="color:red">*</span></label> <input
				type="email" class="form-control" name="userEmail" placeholder="user@email.com" required>
		</div>
		<div class="mb-3">
			<label for="checkPassword" class="form-label">생년월일<span style="color:red">*</span></label> <input
				type="date" class="form-control" name="userBirth" required>
		</div>

		<button type="submit" class="btn btn-primary">가입</button>
	</form>
</div>

<style>
.form-wrapper {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 500px; /* 화면 전체 높이 */
}

form {
	width: 100%;
	max-width: 500px; /* 조절 가능 */
	padding: 2rem;
	border: 1px solid #ddd;
	border-radius: 8px;
	background-color: #f9f9f9;
}

</style>
<script>
	let request;
	$("#userId_").keyup(((request)=>{return e=>{
					if(request) clearTimeout(request);
					//0.8초안에 누르면 request 가 true인 상태 니까 
					//조건문에 걸려서 clear를 시키면
					request=setTimeout(()=>{
						const userId=e.target.value.trim();
						//디바운서 -> 특정 딜레이시간을 발생시켜서 로직실행 지연시킴
						fetch("<%=request.getContextPath()%>/user/idduplicate?id="+userId)
								.then(response=>{
									if(response.ok) return response.json();
									else alert("요청실패 "+response.status);
								}).then(data=>{
									$(e.target).next().remove();
									if(data.result){
										$(e.target).after(
												$("<span>").text("사용할 수 있는 아이디").css("color","green"));
									}else{
										$(e.target).after(
												$("<span>").text("사용할 수 없는 아이디").css("color","red"));
									}
								});
					},800);
					}
			})()
	);
	
	$("#checkPw")
</script>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>