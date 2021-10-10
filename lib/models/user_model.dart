class UserModel {
  String? email;
  String? username;
  String? password;
  String? phone;
  String? image;
  String? cover;
  String? bio;
  String? uId;

  UserModel(
      {this.email,
      this.username,
      this.phone,
      this.uId,
      this.image,
      this.cover,
      this.bio});

  UserModel.fromJson({required Map<String, dynamic>? json}) {
    email = json!['email'];
    username = json['username'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
  }

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "username": username,
      "phone": phone,
      "uId": uId,
      "image": image,
      "cover": cover,
      "bio": bio
    };
  }
}
