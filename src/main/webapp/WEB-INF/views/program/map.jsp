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
            
         	// 네이버 지도 옵션 설정
            const mapOptions = {
                    center: new naver.maps.LatLng(lat, lng),
                    zoom: 16,
                    zoomControl: true, // 줌 컨트롤 표시 (+, - 버튼)
                    zoomControlOptions: {
                        position: naver.maps.Position.RIGHT_BOTTOM // 오른쪽 아래에 위치
                    }
                };

         	// 네이버 지도 객체 생성 (현재 위치를 중심으로)
            const map = new naver.maps.Map("map", mapOptions);

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