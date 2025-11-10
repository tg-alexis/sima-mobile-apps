class UserModel {
  int? id;
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  Profile? profile;
  String? createdAt;
  String? password;
  bool? isFirstConnexion;

  UserModel({this.id, this.firstname, this.lastname, this.email, this.phone, this.password, this.profile, this.createdAt, this.isFirstConnexion});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    phone = json['phone'];
    profile = json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    createdAt = json['created_at'];
    isFirstConnexion = json['is_first_connexion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (firstname != null) data['firstname'] = firstname;
    if (lastname != null) data['lastname'] = lastname;
    if (email != null) data['email'] = email;
    if (phone != null) data['phone'] = phone;
    if (password != null) data['password'] = password;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    if (createdAt != null) data['created_at'] = createdAt;
    if (isFirstConnexion != null) data['is_first_connexion'] = isFirstConnexion;
    return data;
  }
}

class Profile {
  int? id;
  String? code;
  String? name;

  Profile({this.id, this.code, this.name});

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    return data;
  }
}
