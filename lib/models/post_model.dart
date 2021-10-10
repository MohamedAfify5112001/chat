class PostModel {
  String? username;
  String? image;
  String? uId;
  String? text;
  String? dateTime;
  String? postImage;

  PostModel({this.username, this.image, this.uId, this.text, this.dateTime,
      this.postImage});

  PostModel.fromJson({required Map<String, dynamic>? json}) {
    username = json!['username'];
    uId = json['uId'];
    image = json['image'];
    postImage = json['postImage'];
    text = json['text'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "uId": uId,
      "image": image,
      "postImage": postImage,
      "text": text,
      "dateTime": dateTime,

    };
  }
}
