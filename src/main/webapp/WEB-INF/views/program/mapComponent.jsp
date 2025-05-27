<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>

<%@ page import="com.giljobe.program.model.dto.Program" %>
<% Program program = (Program)request.getAttribute("program");%>

<style>
    #programMap {
        width: 100%;
        height: 400px;
        margin-top: 10px;
        border-radius: 10px;
    }
</style>

<div id="programMap"></div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const lat = <%= program.getProLatitude() %>;
        const lng = <%= program.getProLongitude() %>;
        const programName = "<%= program.getProName().replaceAll("\"", "\\\"") %>";

        const map = new naver.maps.Map('programMap', {
            center: new naver.maps.LatLng(lat, lng),
            zoom: 16
        });

        const marker = new naver.maps.Marker({
            position: new naver.maps.LatLng(lat, lng),
            map: map,
            title: programName
        });

        const infoWindow = new naver.maps.InfoWindow({
            content: `<div style="padding:5px; font-size:13px;">${programName}</div>`,
            borderColor: null,
            disableAnchor: true
        });

        infoWindow.open(map, marker);
    });
</script>
