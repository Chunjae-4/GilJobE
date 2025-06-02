<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

 <form class="find-id-form" method="post" id="searchIdForm">
        <label for="name">이름 입력</label>
        <input type="text" placeholder="이름" id="name" name="name" required>
        <label for="email">이메일 입력</label>
        <input type="text" placeholder="이메일" id="email" name="email" required>
        <button type="submit" id="searchIdBtn">아이디 찾기</button>
    </form>
<script>
$(document).ready(function() {
	$('#searchIdForm').on('submit', function(e) {

		e.preventDefault();
		
			const name = $("#name").val().trim();
			const email = $("#email").val().trim();
			
			$.ajax({
			
				url:"<%=request.getContextPath()%>/user/searchIdEnd",
				type:"post",
				data:{
					"userName" : name,
					"userEmail" : email
				},
				dataType : "json",
				success : function(response){
					
					 if (response.result === "fail" || !response.returnId) {

						 alert('존재하지 않는 회원입니다. 다시 확인해주세요.');
						 
			            } else {
			                
			                $("#userIdText").html("회원님의 아이디는 <strong>"+response.returnId+"</strong> 입니다.")
			                $('#idModal').modal('show');    
						}
				},
				error : function(){
					 alert('요청 중 오류가 발생했습니다.');
				}
			})
	});
});

		
</script>

<!-- 모달 HTML -->
<div class="modal fade" id="idModal" tabindex="-1" aria-labelledby="idModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="idModalLabel">아이디 찾기 결과</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button> 
      </div>
      <div class="modal-body">
        <p id="userIdText"></p>
      </div>
      <div class="modal-footer">
        <button type="button" onclick="location.href('<%=request.getContextPath() %>/user/login')" class="btn btn-primary" data-bs-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>

 <style>
	
        body {
            background: #f4f7fa;
            font-family: 'Noto Sans KR', Arial, sans-serif;
        }
        .find-id-form {
            max-width: 360px;
            margin: 80px auto;
            padding: 32px 28px 28px 28px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 6px 24px rgba(30,40,60,0.08);
        }
        .find-id-form label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #333;
            letter-spacing: 0.02em;
        }
        .find-id-form input[type="text"] {
            width: 100%;
            padding: 12px 14px;
            margin-bottom: 20px;
            border: 1.5px solid #d1d5db;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.2s;
            background: #f9fafb;
        }
        .find-id-form input[type="text"]:focus {
            outline: none;
            border-color: #4f8cff;
            background: #fff;
        }
        .find-id-form button {
            width: 100%;
            padding: 12px 0;
            background: linear-gradient(90deg, #4f8cff 0%, #6bc1ff 100%);
            color: #fff;
            font-weight: bold;
            font-size: 17px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(79,140,255,0.08);
            transition: background 0.2s, box-shadow 0.2s;
        }
        .find-id-form button:hover {
            background: linear-gradient(90deg, #357ae8 0%, #5ab2ff 100%);
            box-shadow: 0 4px 16px rgba(79,140,255,0.15);
        }
    </style>
</head>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>