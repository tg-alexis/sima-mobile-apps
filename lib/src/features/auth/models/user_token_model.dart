class UserTokenModel {
  String? accessToken;
  String? refreshToken;
  bool? requiresPasswordChange;

  UserTokenModel(
      {this.accessToken, this.refreshToken, this.requiresPasswordChange});

  UserTokenModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    requiresPasswordChange = json['requiresPasswordChange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['refreshToken'] = this.refreshToken;
    data['requiresPasswordChange'] = this.requiresPasswordChange;
    return data;
  }
}
