class Message {
    constructor(type, sender, receiver, data, room) {
        this.type = type;
        this.sender = sender;
        this.receiver = receiver;
        this.data = data;
        this.room = room;
    }
    msgToJson(){
        return JSON.stringify(this);
    }
}
