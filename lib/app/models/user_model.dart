class LoginResponse {
  String? token;
  String? refreshToken;
  User? user;

  LoginResponse({this.token, this.refreshToken, this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['refreshToken'] = refreshToken;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? googleId;
  String? email;
  String? password;
  String? name;
  String? avatar;
  String? appleId;
  String? createdAt;

  User({
    this.id,
    this.googleId,
    this.email,
    this.password,
    this.name,
    this.avatar,
    this.appleId,
    this.createdAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    googleId = json['google_id'];
    email = json['email'];
    password = json['password'];
    name = json['name'] ?? json['full_name'];
    avatar = json['avatar'];
    appleId = json['apple_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['google_id'] = googleId;
    data['email'] = email;
    data['password'] = password;
    data['name'] = name;
    data['avatar'] = avatar;
    data['apple_id'] = appleId;
    data['created_at'] = createdAt;
    return data;
  }
}
