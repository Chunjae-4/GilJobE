<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

header.jsp 에서 <지도 화면>을 클릭하면 여기로 넘어온다. <br> header.jsp 에서 코드 확인 가능 <br>
<%-- <li class="nav-item"><a href="<%=request.getContextPath()%>/program/map" class="nav-link">지도화면</a></li>
 --%>
 지도화면 클릭하면 ProgramMapServlet 으로 연결이 된다. 그리고 거기서 forward 로 map.jsp, 여기로 연결이 되는 것.
 
 
 여기서는, 지도를 띄워준다.
 1. 기본적으로 어떤 기능을 구현하면 되는지를 먼저 정의하고
 
 2. 그리고 분기 처리 
 	- 클라이언트가 로그인을 한 상태냐, 아니냐
 	- 클라이언트가 위치 정보를 제공하는 걸 허용했느냐, 아니냐
 		-a. 로그인은 했는데 위치정보 허용을 하지 않은 경우 
 		-b. 로그인은 했는데 위치정보 허용을 한 경우 
 		-c. 로그인 하지 않았는데 위치정보 허용을 하지 않은 경우  
 		-d. 로그인 하지 않았는데 위치정보 허용을 한 경우 
 
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
 		
 		왜 안 되는거


<%@ include file="/WEB-INF/views/common/footer.jsp" %>