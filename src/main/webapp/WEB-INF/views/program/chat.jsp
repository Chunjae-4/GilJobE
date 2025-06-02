<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"
         import="com.giljobe.common.Constants" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.giljobe.user.model.dto.User" %>
<%@ page import="com.giljobe.company.model.dto.Company" %>
<%@ page import="com.giljobe.common.LoggerUtil" %>
<%@ page import="com.giljobe.program.model.dto.Program" %>


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

<%
    User chatLoginUser = (User)session.getAttribute("user");
    Company chatLoginCompany = (Company)session.getAttribute("company");
    Program chatProgram = (Program)request.getAttribute("program");
    LoggerUtil.debug("chat client chatProgram: " + chatProgram);
    LoggerUtil.debug("chat client chatLoginCompany: " + chatLoginCompany);
    LoggerUtil.debug("chat client chatLoginUser: " + chatLoginUser);
%>


<script src="${pageContext.request.contextPath}/resources/js/chatting/model/Message.js"></script>
<%--<script src="<%=request.getContextPath()%>/resources/js/jquery-3.7.1.min.js"></script>--%>
<script>
    let contextPath = "<%=request.getContextPath()%>";
    let socket = new WebSocket("ws://" + location.host + contextPath + "/program/detail");
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
    }

    //onmessage 이벤트시
    socket.onmessage = (e) => {
        console.log("client onmessage");
        const message = JSON.parse(e.data);
        msgPrint(message)
    }
    const sendMessage = (e) => {
        console.log("sendMessage");
        console.log("senderType: " + senderType);

        if (senderType === "User" || senderType === "Admin") {
            const msgUserNo = <%=(chatLoginUser != null ? chatLoginUser.getUserNo() : -1)%>;
            const chatMessage = new Message(senderType, msgUserNo, -1, sender, '', e, msgProgramNo);
            socket.send(chatMessage.msgToJson());

        } else if (senderType === "Company") {
            const msgCompanyNo = <%=chatLoginCompany != null ? chatLoginCompany.getComNo() : 0%>;
            const chatMessage = new Message(senderType, -1, 0, sender, '', e, msgProgramNo);
            socket.send(chatMessage.msgToJson());
        }
    }

    const msgPrint = (data) => {
        const align = data.sender === sender ? "text-end" : "text-start";
        const bgClass = data.sender === sender ? "bg-primary text-white" : "bg-white";
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
