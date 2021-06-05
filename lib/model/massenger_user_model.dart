class MessengerModel {
  String text;
  String recevireId;
  String senderId;
  String dateTime;


  MessengerModel({
    this.text,
    this.recevireId,
    this.senderId,
    this.dateTime,

  });

  MessengerModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    recevireId = json['recevireId'];
    senderId = json['senderId'];
    dateTime = json['dateTime'];

  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'recevireId': recevireId,
      'senderId': senderId,
      'dateTime': dateTime,

    };
  }
}