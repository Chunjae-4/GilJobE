<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"
         import="com.giljobe.common.Constants" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.giljobe.user.model.dto.User" %>
<%@ page import="com.giljobe.company.model.dto.Company" %>
<%@ page import="com.giljobe.common.LoggerUtil" %>
<%@ page import="com.giljobe.program.model.dto.Program" %>


<div id="chat-section" class="card mb-5 border-0 rounded-4 shadow-sm">
    <div class="card-header bg-white fw-bold">단체 채팅방</div>
    <div class="card-body text-muted small bg-white">자유롭게 대화할 수 있어요.</div>

    <div class="card-body bg-light px-4 py-3" id="chat-container" style="height: 320px; overflow-y: auto;">
        <!-- 메시지 출력 영역 -->
    </div>

    <div class="card-footer bg-white border-top-0 pt-3">
        <div class="input-group">
            <input type="text" id="msg" class="form-control rounded-start-pill" placeholder="메시지를 입력하세요..." />
            <button id="send-btn" class="btn btn-outline-primary rounded-end-pill">전송</button>
        </div>
    </div>
</div>


<style>

    #chat-container {
        font-size: 0.95rem;
        padding-bottom: 0.5rem;
    }

    #chat-container .message-row {
        display: flex;
        margin-bottom: 0.5rem;
    }

    #chat-container .message-row.text-start {
        justify-content: flex-start;
    }

    #chat-container .message-row.text-end {
        justify-content: flex-end;
    }

    #chat-container .message-bubble {
        max-width: 70%;
        padding: 0.6rem 1rem;
        border-radius: 1rem;
        word-break: break-word;
        box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
    }

    #chat-container .bg-primary.message-bubble {
        color: #fff;
    }

    #chat-container .bg-white.message-bubble {
        color: #212529;
        border: 1px solid #dee2e6;
    }

    #msg {
        flex: 1;
    }

    .card-footer .form-control {
        border-top-right-radius: 0 !important;
        border-bottom-right-radius: 0 !important;
    }

    .card-footer .btn {
        border-top-left-radius: 0 !important;
        border-bottom-left-radius: 0 !important;
    }
</style>

<%
    User chatLoginUser = (User)session.getAttribute("user");
    Company chatLoginCompany = (Company)session.getAttribute("company");
    Program chatProgram = (Program)request.getAttribute("program");
    LoggerUtil.debug("chat client chatProgram: " + chatProgram);
    LoggerUtil.debug("chat client chatLoginCompany: " + chatLoginCompany);
    LoggerUtil.debug("chat client chatLoginUser: " + chatLoginUser);
%>


<script src="${pageContext.request.contextPath}/resources/js/chatting/model/Message.js"></script>

<script>
    //TODO: 첫 입장시 메세지가 보이지 않도록 세팅해서 onOpen에 데이터를 보낸다
    let contextPath = "<%=request.getContextPath()%>";
    let socket = new WebSocket("ws://" + location.host + contextPath + "/program/detail");
    // let socket = new WebSocket("wss://" + "chunjaefullstack.r-e.kr" + contextPath + "/program/detail");


    let sender = "";
    let senderType = "";
    let isUser = false;
    let msgProgramNo = 1;
    <% if (chatProgram != null) { %>
    msgProgramNo = <%= chatProgram.getProNo() %>;
    <% } else { %>
    msgProgramNo = 0;
    <% } %>
    console.log("msgProgramNo: " + msgProgramNo);

    <%--//유저면 sender 이름을 닉네임으로 지정--%>
    <%if(chatLoginUser != null && chatLoginCompany == null){%>
    const senderTypeUserNo = <%=chatLoginUser.getUserNo() %>;

    sender = "<%=chatLoginUser.getUserNickName()%>";
       if (senderTypeUserNo === 1){
           senderType = "Admin";
       } else {
           senderType = "User";
       }

        isUser = true;
    <%--//기업이면 sender 이름을 기업 이름으로 지정--%>
    <%} else if (chatLoginUser == null && chatLoginCompany != null) {%>
        sender = "<%=chatLoginCompany.getComName()%>";
        senderType = "Company";
        isUser = true;
    <%--//유저, 기업 로그인 아니면 사용 못하게 막기--%>
    <%} else {%>
        $("#msg").attr('placeholder', '로그인을 하면 이용할 수 있어요.');
        $("#msg").attr('readonly', 'readonly');
    <%}%>
    console.log("sender: " + sender);
    console.log("senderType: " + senderType);

    <%--//TODO: roomId 세팅, pro_No마다 할당--%>
    <%--//버튼 이벤트시 sendMessage()함수로 가도록--%>
    $("#send-btn").on("click", (e) => {
    <%--    //유저이고 guest가 아닐때--%>
        if (isUser === true) {
            const message = $("#msg").val();
            if (message.trim() !== '') {
                sendMessage(message);
                //초기화
                $("#msg").val('');
            }
        //유저가 아닐때
        } else if (isUser === false) {
            $("#send-btn").off("click");
        }

    })

    //open 이벤트시
    socket.onopen = (e) => {
        console.log("client onopen");
        <%LoggerUtil.debug("Client onOpen");%>
        const initMessage = new Message("Init", -1, -1, "init", "", "", msgProgramNo);

        socket.send(initMessage.msgToJson());
    }

    //onmessage 이벤트시
    socket.onmessage = (e) => {
        console.log("client onmessage");
        const message = JSON.parse(e.data);
        console.log(message);
        msgPrint(message)
    }
    const sendMessage = (e) => {
        console.log("senderType: " + senderType);

        if (senderType === "User") {
            const msgUserNo = <%=(chatLoginUser != null ? chatLoginUser.getUserNo() : -1)%>;
            const chatMessage = new Message(senderType, msgUserNo, -1, sender, '', e, msgProgramNo);
            socket.send(chatMessage.msgToJson());
        } else if (senderType === "Admin") {
            const msgUserNo = <%=(chatLoginUser != null ? chatLoginUser.getUserNo() : -1)%>;
            const chatMessage = new Message(senderType, msgUserNo, -1, sender, '', e, msgProgramNo);
            socket.send(chatMessage.msgToJson());
        } else if (senderType === "Company") {
            const msgCompanyNo = <%=chatLoginCompany != null ? chatLoginCompany.getComNo() : 0%>;
            const chatMessage = new Message(senderType, -1, msgCompanyNo, sender, '', e, msgProgramNo);
            socket.send(chatMessage.msgToJson());
        }
    }

    const msgPrint = (data) => {
        const isMine =
            (data.senderType === senderType) &&
            (data.sender === sender);

        const align = isMine ? "text-end" : "text-start";
        const bgClass = isMine ? "bg-primary text-white" : "bg-white";

        const date = new Date(data.dateTime); // "2025-05-27T16:32:00"
        let timeStr;
        if (!isNaN(date)) {
           timeStr = date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
        } else {
            console.warn("Invalid dateTime:", data.dateTime);
        }

        const html =
            "<div class='message-row " + align + "'>" +
                "<div class= 'message-bubble " + bgClass +"'>" +
                    "<div class='small fw-bold mb-1'>" + data.sender + "</div>" +
                    "<div>"+ data.data+ "</div>" +
                    "<div class='text-muted small text-end mt-1'>" + timeStr + "</div>" +
                "</div>" +
            "</div>"

        $('#chat-container').append(html);
        $('#chat-container').scrollTop($('#chat-container')[0].scrollHeight);
    }
</script>
