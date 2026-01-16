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
  String? birthdate;
  String? gender;
  String? country;
  FashionPreferences? fashionPreferences;

  User({
    this.id,
    this.googleId,
    this.email,
    this.password,
    this.name,
    this.avatar,
    this.appleId,
    this.createdAt,
    this.birthdate,
    this.gender,
    this.country,
    this.fashionPreferences,
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
    birthdate = json['birthdate'];
    gender = json['gender'];
    country = json['country'];
    fashionPreferences = json['fashionPreferences'] != null
        ? FashionPreferences.fromJson(json['fashionPreferences'])
        : null;
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
    data['birthdate'] = birthdate;
    data['gender'] = gender;
    data['country'] = country;
    if (fashionPreferences != null) {
      data['fashionPreferences'] = fashionPreferences!.toJson();
    }
    return data;
  }
}

class FashionPreferences {
  int? id;
  int? userId;
  dynamic season; // Can be String or List<String>
  dynamic style; // Can be String or List<String>
  dynamic preferencesColor; // Can be String or List<String>
  String? bodyType;
  String? skinTone;
  String? color;
  String? createdAt;
  String? updatedAt;

  FashionPreferences({
    this.id,
    this.userId,
    this.season,
    this.style,
    this.preferencesColor,
    this.bodyType,
    this.skinTone,
    this.color,
    this.createdAt,
    this.updatedAt,
  });

  FashionPreferences.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    season = json['season']; // Keep as dynamic to handle both String and List
    style = json['style']; // Keep as dynamic to handle both String and List
    preferencesColor = json['preferences_color']; // Keep as dynamic
    bodyType = json['body_type'];
    skinTone = json['skin_tone'];
    color = json['color'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['season'] = season;
    data['style'] = style;
    data['preferences_color'] = preferencesColor;
    data['body_type'] = bodyType;
    data['skin_tone'] = skinTone;
    data['color'] = color;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
