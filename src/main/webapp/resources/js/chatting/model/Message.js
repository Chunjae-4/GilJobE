class Message {
    constructor(senderType, userNo, comNo, sender, receiver, data, proNo) {
        this.senderType = senderType;
        this.userNo = userNo;
        this.comNo = comNo;
        this.sender = sender;
        this.receiver = receiver;
        this.data = data;
        this.proNo = proNo;
    }
    msgToJson(){
        return JSON.stringify(this);
    }
}
