class SocialUserModel {
  String? username;
  String? image;
  String? uId;

  SocialUserModel.fromJson({required Map<String, dynamic>? json}) {
    username = json!['username'];
    image = json['image'];
    uId = json['uId'];
  }
}
