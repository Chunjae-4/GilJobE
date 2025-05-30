<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"
         import="com.giljobe.common.Constants" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.giljobe.user.model.dto.User" %>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<section id="chat-section" class="mt-5">
    <div class="card shadow-sm rounded-4">
        <div class="card-header bg-primary bg-opacity-75 text-white fw-semibold">
            💬 체험자 채팅
        </div>

        <div class="card-body bg-light" id="chat-container" style="height: 300px; overflow-y: auto;">
            <!-- 기존 메시지 예시 -->

        </div>

        <div class="card-footer bg-white d-flex gap-2">
            <input type="text" id="msg" name="msg" class="form-control" placeholder="메시지를 입력하세요..." required>
            <button id="send-btn" class="btn btn-outline-primary">전송</button>

        </div>
    </div>
</section>


<style>
    #chat-container {
        font-size: 0.95rem;
    }

    #chat-container .bg-white {
        max-width: 75%;
    }

    #chat-container .bg-primary {
        max-width: 75%;
    }

    #msg {
        flex: 1;
    }

    #chat-section {
        max-width: 720px;
        margin: 0 auto;
    }
</style>

<%User loginUser = (User)session.getAttribute("user");%>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/chatting/model/Message.js"></script>
<script>
    let contextPath = "<%=request.getContextPath()%>";
    let socket = new WebSocket("ws://" + location.host + contextPath + "/chatting")

    const sender = "<%=loginUser.getUserId()%>";
    let roomId = 1;

    //버튼 이벤트시 sendMessage()함수로 가도록
    $("#send-btn").on("click", (e) => {
        console.log(e);
        const message = $("#msg").val();
        if (message.trim() !== '') {
            sendMessage(message);
            //초기화
            $("#msg").val('');
        }

    })


    //open 이벤트시
    socket.onopen = (e) => {
        console.log("client onopen");
    }

    //onmessage 이벤트시
    socket.onmessage = (e) => {
        console.log("client onmessage");
        console.log(e.data);
        const message = JSON.parse(e.data);
        msgPrint(message)
    }

    const sendMessage = (e) => {
        console.log("sendMessage");
        const msg = new Message('M', sender, '', e, '');
        socket.send(msg.msgToJson());
    }

    const msgPrint = (data) => {
        const align = data.sender === sender ? "text-end" : "text-start";
        const bgClass = data.sender === sender ? "bg-primary text-white" : "bg-white";
        console.log(align, bgClass, data, data.sender, data.data);
        const html =  "<div class='mb-2 " + align + "'>" +
        "<div class= 'd-inline-block px-3 py-2 rounded shadow-sm " + bgClass +"'>" +
        "<div class='small'>" + data.sender + "</div>" +
        "<div>"+ data.data+ "</div>" +
        "</div>" +
        "</div>"

        $('#chat-container').append(html);
        $('#chat-container').scrollTop($('#chat-container')[0].scrollHeight);
    }
</script>
