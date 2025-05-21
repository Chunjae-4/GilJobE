<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

header.jsp 에서 <지도 화면>을 클릭하면 여기로 넘어온다. <br>
네이버 지도 API를 활용할 것이다 <br>
기본적으로, 클라이언트의 위치 정보를 받아올 필요가 있다<br>
그러면 아마 그 과정에서 클라이언트에게 위치 정보를 허용 할거냐는 알림이 갈 것<br>
위치 정보 허용했다고 쳤을때, 허용하지 않았을때 분기처리(if else)가 필요하다<br>

 - ok : 위치 정보를 허용했다면,
 		우선, 클라이언트의 위치에 해당 하는 마크가 별도로 지도에 표시가 되어야 할 것
 		그리고 해당 위치를 중심으로 지도 화면을 보여주는 것으로 시작하면 될 것
 
 
 - no : 위치 정보 허용하지 않았다면,
 		클라이언트의 위치를 표현해주는 마크는 지도에 표시가 되지 않아야 할 것
 		그리고 클라이언트가 스스로 줌인 하도록 수도권 지역을 보여주는 것으로 시작하면 될 것
 		
 		


<%@ include file="/WEB-INF/views/common/footer.jsp" %>