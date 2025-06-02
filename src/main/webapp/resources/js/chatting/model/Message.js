class Message {
    constructor(type, sender, receiver, data, roomNo) {
        this.type = type;
        this.sender = sender;
        this.receiver = receiver;
        this.data = data;
        this.roomNo = roomNo;
    }
    msgToJson(){
        return JSON.stringify(this);
    }
}
