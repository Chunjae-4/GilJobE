<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!-- 사이드바 영역 -->
<main class="bg-body-tertiary py-5">
	<div class="container">
		<div class="row g-4">

			<!-- 사이드바 -->
			<aside class="col-md-4 col-lg-3">
				<div class="bg-white rounded-4 shadow-sm p-4 h-100">
					<h4 class="fw-bold mb-2">마이페이지</h4>
					<hr class="my-4">
					<div class="nav flex-column nav-pills gap-2" id="mypageMenu">
						<button class="nav-link text-start " data-menu="userinfo" onclick="sideMenu('companyinfo')">내 정보 관리</button>
						<button class="nav-link text-start" data-menu="applist" onclick="sideMenu('companyprogram')">등록 프로그램</button>
						<button class="nav-link text-start" data-menu="qnalist" onclick="sideMenu('answerlist')">문의 내역</button>
					</div>
				</div>
			</aside>

			<!-- 콘텐츠 영역 -->
			<section class="col-md-8 col-lg-9">
				<!-- 이 부분에 Ajax로 콘텐츠 삽입됨 -->
				<div class="bg-white rounded-4 shadow-sm p-4 h-100" id="content" style="min-height: 550px;">
					<p>불러오는 중...</p>
				</div>
			</section>

		</div>
	</div>
</main>

<script>

  	//ajax로 url을 서블렛으로 보내고 printwriter로 화면 조립해서 띄워주면 힘드니까
  	//서블릿에서 연결한 jsp에 입력한 코드들이 data에 저장되고 그게 content에 추가됨


	const sideMenu=(menu)=>{

		$('#content').html('<p>불러오는 중...</p>');
		$.ajax({
		url: '<%=request.getContextPath()%>/mypage/' + menu,
        method: 'GET',
        dataType: 'html', // 혹은 'json'으로 바꿀 수도 있음
        success: function (data) {
          $('#content').html(data);
        },
        error: function () {
          $('#content').html('<p>데이터를 불러오는 데 실패했습니다.</p>');
        }
      });
	}
	$(document).ready(function () {
	    sideMenu('companyinfo');
	});

  </script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %>