class Message {
    constructor(senderType, userNo, comNo, sender, receiver, data, proNo, dateTime) {
        this.senderType = senderType;
        this.userNo = userNo;
        this.comNo = comNo;
        this.sender = sender;
        this.receiver = receiver;
        this.data = data;
        this.proNo = proNo;
        this.dateTime = dateTime;
    }
    msgToJson(){
        return JSON.stringify(this);
    }
}
