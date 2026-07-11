class UserModel {
  final String? accessToken;
  final String? refreshToken;

  UserModel({this.accessToken, this.refreshToken});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      accessToken: json["access_token"] ?? json["token"],
      refreshToken: json["refresh_token"],
    );
  }
}
