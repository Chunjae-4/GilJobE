<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" 
import="com.giljobe.common.Constants,
		com.google.gson.Gson,
		java.util.List,
		com.giljobe.program.model.dto.Program"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %> <%-- 공통 헤더 파일 포함 (메뉴, CSS 등) --%>

<!-- 네이버 지도 API 스크립트 로드 (ncpKeyId는 네이버 클라우드 콘솔에서 발급받은 API 키 사용) -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpKeyId=<%=request.getAttribute("naverMapKey")%>"></script>

<section class="bg-body-tertiary text-center py-5 mb-4">
    <div class="container">
        <div class="mb-4">
            <h1 class="fw-semibold mb-3">체험 프로그램 지도</h1>
            <p class="lead text-muted fst-italic">현재 위치를 기준으로 주변의 체험 프로그램을 확인해보세요.</p>
        </div>

        <!-- 지도 -->
        <div id="map"
             class="rounded-4 border shadow-sm mx-auto"
             style="width: 100%; max-width: 960px; height: 500px;">
        </div>
    </div>
</section>


<script>
    let map; // 지도 객체를 외부에서도 접근 가능하도록 전역 변수로 선언
    //let programMarkers = []; // 모든 마커를 저장할 배열 - 줌 수준에 따라 다르게 보여주려고 했지만 시연할 때에는 다 보여주는게 좋을 듯 하여 일단 주석처리

   	const contextPath = "<%= request.getContextPath() %>"
    const programList = <%= new com.google.gson.Gson().toJson(request.getAttribute("programList")) %>;
    console.log(programList);

    // 클라이언트가 위치정보 사용을 허용했는지 확인
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function (position) {
            var lat = position.coords.latitude;
            var lng = position.coords.longitude;

            const mapOptions = {
                center: new naver.maps.LatLng(lat, lng),
                zoom: 16,
                zoomControl: true,
                zoomControlOptions: {
                    position: naver.maps.Position.RIGHT_BOTTOM
                }
            };

            map = new naver.maps.Map("map", mapOptions);

            new naver.maps.Marker({
                position: new naver.maps.LatLng(lat, lng),
                map: map,
                icon: {
                    url: contextPath+'/resources/images/newMyLocationMarker.png',
                    size: new naver.maps.Size(40, 40),
                    scaledSize: new naver.maps.Size(40, 40),
                    origin: new naver.maps.Point(0, 0),
                    anchor: new naver.maps.Point(20, 40)
                },
                title: "내 위치"
            });

            addProgramMarkers();

        }, function (error) {
            // 위치 정보 접근 실패 시 기본 위치
            map = new naver.maps.Map('map', {
                center: new naver.maps.LatLng(37.478113, 126.881508),
                zoom: 15
            });
            addProgramMarkers();
        });
    } else {
        map = new naver.maps.Map('map', {
            center: new naver.maps.LatLng(37.478113, 126.881508),
            zoom: 15
        });
        addProgramMarkers();
    }

    function addProgramMarkers() {

        programList.forEach(program => {
            const marker = new naver.maps.Marker({
                position: new naver.maps.LatLng(program.proLatitude, program.proLongitude),
                map: map,
                icon: {
                    url: contextPath+'/resources/images/newProgramMarker.png',
                    size: new naver.maps.Size(30, 30),
                    scaledSize: new naver.maps.Size(30, 30),
                    anchor: new naver.maps.Point(15, 30)
                },
                title: program.proName
            });

            const infoWindow = new naver.maps.InfoWindow({
                content: `<div style='padding:5px; font-size:12px;'>\${program.proName}</div>`,
                borderColor: null,
                disableAnchor: true
            });

            naver.maps.Event.addListener(marker, 'mouseover', () => infoWindow.open(map, marker));
            naver.maps.Event.addListener(marker, 'mouseout', () => infoWindow.close());

            // 📌 상세 페이지 이동
            naver.maps.Event.addListener(marker, 'click', () => {
                location.href = contextPath+`/program/detail?proNo=\${program.proNo}`;
            });

            // 툴팁 클릭 시도 동일 동작
            naver.maps.Event.addListener(infoWindow, 'domready', () => {
                const el = infoWindow.getContentElement();
                el.addEventListener('click', () => {
                    location.href = contextPath+`/program/detail?proNo=\${program.proNo}`;
                });
            });
        });
    }
</script>


<%@ include file="/WEB-INF/views/common/footer.jsp" %> <%-- 공통 푸터 포함 --%>