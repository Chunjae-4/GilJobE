<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // 외부에서 setAttribute로 넘겨준 값 가져오기
    String name = (String) request.getAttribute("programName");
    String location = (String) request.getAttribute("programLocation");
    Double lat = (Double) request.getAttribute("programLat");
    Double lng = (Double) request.getAttribute("programLng");

    // 기본값 지정 (위도/경도 값이 null이면 금천구 마리오아울렛으로 기본 표시)
    if (lat == null || lng == null) {
        lat = 37.478113;
        lng = 126.881508;
    }

    if (name == null) name = "체험 프로그램";
    if (location == null) location = "위치 정보 없음";
%>

<!-- 지도가 표시될 HTML 영역 -->
<div id="map" style="width: 100%; height: 300px;"></div>

<!-- 네이버 지도 API 스크립트 로드 -->
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpKeyId=<%=request.getAttribute("naverMapKey")%>"></script>

<script>
document.addEventListener("DOMContentLoaded", function () {
    // 위도/경도 값 자바스크립트 변수로 전달
    const lat = <%= lat %>;
    const lng = <%= lng %>;

    // 지도 생성
    const map = new naver.maps.Map("map", {
        center: new naver.maps.LatLng(lat, lng),
        zoom: 16
    });

    // 마커 추가
    const marker = new naver.maps.Marker({
        position: new naver.maps.LatLng(lat, lng),
        map: map,
        title: "<%= name %>"
    });

    // 정보창 (툴팁) 설정
    const infoWindow = new naver.maps.InfoWindow({
        content: `<div style="padding:5px; font-size:13px;"><strong><%= name %></strong><br><%= location %></div>`
    });

    // 마우스 올리면 툴팁 열기
    naver.maps.Event.addListener(marker, "mouseover", function () {
        infoWindow.open(map, marker);
    });

    // 마우스 벗어나면 툴팁 닫기
    naver.maps.Event.addListener(marker, "mouseout", function () {
        infoWindow.close();
    });
});
</script>