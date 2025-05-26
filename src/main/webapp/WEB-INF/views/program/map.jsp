<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %> <%-- 공통 헤더 파일 포함 (메뉴, CSS 등) --%>

<!-- 네이버 지도 API 스크립트 로드 (ncpKeyId는 네이버 클라우드 콘솔에서 발급받은 API 키 사용) -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpKeyId=<%=request.getAttribute("naverMapKey")%>"></script>

<!-- 지도 영역의 스타일 지정 -->
<style>
    #map {
        width: 100%;
        height: 600px;
    }
</style>

해야 할 일 - 
(1) - 내 위치에 해당하는 핀의 경우에는 디자인을 핀이 아니라 다른 걸로 하던, 아니면 다른 표시가 되든 해야 할 것 같음.
지도에 표시되는 프로그램들에 대한 핀과 본인 위치에 대한 핀이 디자인이 똑같은 건 안 된다.

(2) - programDetail.jsp 에서, 지도 영역에 해당하는 div tag 에 지도가 표시되어야 한다.
프로그램 상세페이지에 들어가면 지도가 나오게 된다. 즉, 특정 프로그램 내에 있는 지도니까, 해당 프로그램의 주소를 가지고,
해당 프로그램을 가장 중앙에 두고 있는 지도를 띄워주면 되겠다. 그 지도에서 이동하고 스크롤하고 줌인줌아웃은 가능하게 하자!

(3) - 지도 영역에 해당하는 div tag 내에, programDetailMap.jsp 을 보여주게 할 것이다. 즉, (2) 에서 얘기한 거는
programDetailMap.jsp 에 구현을 하고, programDetail.jsp 에는 programDetailMap.jsp 를 포함시켜서 보여주는 것.

(4) - 참고로, programDetail.jsp 를 연결시키는 건 ProgramDetailServlet.java 임.

(5) - 그리고 naver map api key 의 경우에는 resources에 넣어놓음 - 이걸 다운로드 받은 뒤에 리소스에 넣어놓아야 함
src/main/resources에 넣어놓아야 함

(6) - 어떤 ui 인지 이해를 위해서 피그마 확인 필.


<h2>체험 프로그램 지도</h2>
<!-- 지도가 표시될 영역 -->
<div id="map"></div>

<script>
    let map; // 지도 객체를 외부에서도 접근 가능하도록 전역 변수로 선언

    // 클라이언트가 위치정보 사용을 허용했는지 확인
    if (navigator.geolocation) {
        // 위치정보를 가져오는 함수
        navigator.geolocation.getCurrentPosition(function (position) {
            // 위치 허용한 경우: 현재 좌표를 중심으로 지도 생성
            var lat = position.coords.latitude;
            var lng = position.coords.longitude;

            // 네이버 지도 객체 생성 (현재 위치를 중심으로)
            map = new naver.maps.Map('map', {
                center: new naver.maps.LatLng(lat, lng),
                zoom: 15
            });

            // 현재 위치에 마커 추가
            new naver.maps.Marker({
                position: new naver.maps.LatLng(lat, lng),
                map: map,
                title: "내 위치"
            });

            // 체험 프로그램 마커 표시 함수 호출
            addProgramMarkers();

        }, function (error) {
            // 위치 허용을 거부했거나 오류 발생 시: 기본 위치(금천구 마리오아울렛)로 지도 표시
            map = new naver.maps.Map('map', {
                center: new naver.maps.LatLng(37.478113, 126.881508),
                zoom: 15
            });

            addProgramMarkers();
        });
    } else {
        // 위치정보 기능을 지원하지 않는 브라우저인 경우
        map = new naver.maps.Map('map', {
            center: new naver.maps.LatLng(37.478113, 126.881508),
            zoom: 15
        });

        addProgramMarkers();
    }

    // 체험 프로그램 마커를 지도에 추가하는 함수
    function addProgramMarkers() {
        // 예시용 더미 데이터 배열
        const programList = [
            { name: "천연비누 만들기", lat: 37.4785, lng: 126.8810, type: "체험A" },
            { name: "목공예 체험", lat: 37.4780, lng: 126.8820, type: "체험B" },
            { name: "도예 체험", lat: 37.4790, lng: 126.8805, type: "체험A" }
        ];

        // 각 프로그램 정보를 기반으로 마커와 이벤트 생성
        programList.forEach(program => {
            // 지도에 마커 생성
            const marker = new naver.maps.Marker({
                position: new naver.maps.LatLng(program.lat, program.lng),
                map: map,
                title: program.name
            });

         	// 툴팁에 표시할 내용: 이름만 표시
            const infoWindow = new naver.maps.InfoWindow({
                content: `<div style="padding:5px; font-size:12px;">${program.name}</div>`,
                borderColor: null,                  // 테두리 제거
                disableAnchor: true                 // ▼ 화살표(꼭짓점) 제거
            });

            // 마우스 오버 시: 마커 위에 툴팁(정보창) 표시
            naver.maps.Event.addListener(marker, 'mouseover', () => {
                infoWindow.open(map, marker);
            });

            // 마우스가 벗어날 경우 툴팁 닫힘
            naver.maps.Event.addListener(marker, 'mouseout', () => {
                infoWindow.close();
            });

            // 마커 클릭 시: 상세 페이지 이동 알림(alert)
            naver.maps.Event.addListener(marker, 'click', () => {
                alert(`'${program.name}' 상세 페이지로 이동합니다 (연결 예정)`);
                // 나중에 location.href = '/program/detail?id=...' 등으로 대체 가능
            });

            // 툴팁 내부 클릭 시에도 같은 alert 발생
            naver.maps.Event.addListener(infoWindow, 'domready', () => {
                const el = infoWindow.getContentElement(); // 툴팁 DOM 요소 가져오기
                el.addEventListener('click', () => {
                    alert(`'${program.name}' 상세 페이지로 이동합니다 (연결 예정)`);
                });
            });
        });
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %> <%-- 공통 푸터 포함 --%>