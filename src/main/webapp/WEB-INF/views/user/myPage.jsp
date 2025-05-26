<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>

<!-- 사이드바 영역 -->
<main>
	<aside>
		<div class="d-flex flex-column flex-shrink-0 p-3 bg-body-tertiary"
			style="width: 280px;">

			<span class="fs-4">마이페이지</span>

			<hr>
			<ul class="nav nav-pills flex-column mb-auto">
				<li onclick="sideMenu('userinfo')">내 정보 관리</li>
				<li onclick="sideMenu('application')">신청 프로그램 관리</li>
				<li onclick="sideMenu('love')">좋아요 누른 글</li>
				<li onclick="sideMenu('qna')">문의 내역</li>
				<li>기타 등등</li>
			</ul>
			<hr>
		</div>
	</aside>

	<!-- 본문 영역 -->
	<section class="p-3" id="content">
		
	</section>
</main>
<style>
main {
	flex: 1;
	display: flex;
	min-height: 0; /* 내부 요소 overflow 방지 */
}

aside {
	width: 280px;
	background-color: #f8f9fa;
	padding: 1rem;
	box-sizing: border-box;
}

section {
	flex-grow: 1;
	padding: 1rem;
	overflow-y: auto;
	background-color: #fff;
}
</style>
<script>
  	
  	//ajax로 url을 서블렛으로 보내고 printwriter로 화면 조립해서 띄워주면 힘드니까
  	//서블릿에서 연결한 jsp에 입력한 코드들이 data에 저장되고 그게 content에 추가됨
  	
  	
	const sideMenu=(menu)=>{
	
		$('#content').html('<p>불러오는 중...</p>');
		$.ajax({
		url: '<%=request.getContextPath()%>/user/' + menu,
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
  	
  	
  </script>


<%@ include file="/WEB-INF/views/common/footer.jsp"%>