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
  int? profileId;

  UserModel({this.id, this.firstname, this.lastname, this.email, this.phone, this.password, this.profile, this.createdAt, this.isFirstConnexion, this.profileId});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    phone = json['phone'];
    profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;
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
    if (profileId != null) data['profileId'] = profileId;
    if (profile != null) {
      data['profile'] = profile!.toJson();
    }
    if (createdAt != null) data['created_at'] = createdAt;
    if (isFirstConnexion != null) data['is_first_connexion'] = isFirstConnexion;
    return data;
  }

  bool get isAdmin => profile?.code == "ADMIN";
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

class ListUserModel {
  List<UserModel>? result;
  int? count;
  Pagination? paginationResult;

  ListUserModel({this.result, this.count, this.paginationResult});

  ListUserModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <UserModel>[];
      json['result'].forEach((v) {
        result!.add(UserModel.fromJson(v));
      });
    }
    count = json['count'];
    paginationResult = json['paginationResult'] != null
        ? Pagination.fromJson(json['paginationResult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    if (paginationResult != null) {
      data['paginationResult'] = paginationResult!.toJson();
    }
    return data;
  }
}



class Pagination {
  int? currentPage;
  int? nextPage;
  int? count;
  int? totalCount;
  int? totalPages;

  Pagination(
      {this.currentPage,
        this.nextPage,
        this.count,
        this.totalCount,
        this.totalPages});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    nextPage = json['nextPage'];
    count = json['count'];
    totalCount = json['totalCount'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['nextPage'] = nextPage;
    data['count'] = count;
    data['totalCount'] = totalCount;
    data['totalPages'] = totalPages;
    return data;
  }
}
