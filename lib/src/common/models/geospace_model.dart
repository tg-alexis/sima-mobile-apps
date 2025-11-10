class GeospaceModel {
  String? id;
  String? code;
  String? name;
  List<Sectors>? sectors;

  GeospaceModel({this.id, this.code, this.name, this.sectors});

  GeospaceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    if (json['secteurs'] != null) {
      sectors = <Sectors>[];
      json['secteurs'].forEach((v) {
        sectors!.add(Sectors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (code != null) data['code'] = code;
    if (name != null) data['name'] = name;
    if (sectors != null) {
      data['secteurs'] = sectors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sectors {
  String? id;
  String? code;
  String? name;

  Sectors({this.id, this.code, this.name});

  Sectors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (code != null) data['code'] = code;
    if (name != null) data['name'] = name;
    return data;
  }
}
