<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpKeyId=12feiletwc"></script>
<style>
        #map {
            width: 100%;
            height: 600px;
        }
</style>

<h2>체험 프로그램 지도</h2>
<div id="map"></div>

<script>
    let map; // 전역 선언 (블록 밖에서 사용 가능하도록)

    // 위치정보 허용 여부 체크
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function (position) {
            var lat = position.coords.latitude;
            var lng = position.coords.longitude;

            map = new naver.maps.Map('map', {
                center: new naver.maps.LatLng(lat, lng),
                zoom: 15
            });

            new naver.maps.Marker({
                position: new naver.maps.LatLng(lat, lng),
                map: map,
                title: "내 위치"
            });

            addProgramMarkers(); // 지도 생성 후 마커 추가

        }, function (error) {
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

    // 💡 체험 프로그램 마커 추가 함수 분리
    function addProgramMarkers() {
        const programList = [
            { name: "천연비누 만들기", lat: 37.4785, lng: 126.8810, type: "체험A" },
            { name: "목공예 체험", lat: 37.4780, lng: 126.8820, type: "체험B" },
            { name: "도예 체험", lat: 37.4790, lng: 126.8805, type: "체험A" }
        ];

        programList.forEach(program => {
            const marker = new naver.maps.Marker({
                position: new naver.maps.LatLng(program.lat, program.lng),
                map: map,
                title: program.name
            });

            const infoWindow = new naver.maps.InfoWindow({
                content: `<div style="padding:5px;font-size:12px;">${program.name}</div>`
            });

            naver.maps.Event.addListener(marker, 'mouseover', () => {
                infoWindow.open(map, marker);
            });

            naver.maps.Event.addListener(marker, 'mouseout', () => {
                infoWindow.close();
            });
        });
    }
</script>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

