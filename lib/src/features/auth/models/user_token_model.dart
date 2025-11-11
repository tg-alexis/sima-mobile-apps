class UserTokenModel {
  String? accessToken;
  String? refreshToken;
  bool? requiresPasswordChange;

  UserTokenModel({
    this.accessToken,
    this.refreshToken,
    this.requiresPasswordChange,
  });

  UserTokenModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    requiresPasswordChange = json['requiresPasswordChange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    data['requiresPasswordChange'] = requiresPasswordChange;
    return data;
  }
}
