class MessagesModel {
  String? senderId;
  String? receiverId;
  String? dataTime;
  String? message;
  MessagesModel({this.senderId, this.receiverId, this.dataTime, this.message});

  MessagesModel.fromJson({required Map<String, dynamic>? json}) {
    senderId = json!['senderId'];
    receiverId = json['receiverId'];
    dataTime = json['dataTime'];
    message = json['message'];
  }

  Map<String, dynamic> toMap() {
    return {
      "senderId": senderId,
      "receiverId": receiverId,
      "dataTime": dataTime,
      "message": message,
    };
  }
}
