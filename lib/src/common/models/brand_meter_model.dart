class BrandMeterModel {
  String? id;
  String? code;
  int? nombreChar;
  String? libelle;
  String? description;
  int? isActive;
  List<Models>? models;

  BrandMeterModel(
      {this.id,
        this.code,
        this.nombreChar,
        this.libelle,
        this.description,
        this.isActive,
        this.models});

  BrandMeterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    nombreChar = json['nombreChar'];
    libelle = json['libelle'];
    description = json['description'];
    isActive = json['isActive'];
    if (json['models'] != null) {
      models = <Models>[];
      json['models'].forEach((v) {
        models!.add(new Models.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['nombreChar'] = nombreChar;
    data['libelle'] = libelle;
    data['description'] = description;
    data['isActive'] = isActive;
    if (models != null) {
      data['models'] = models!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Models {
  String? id;
  String? libelle;
  String? marqueId;
  String? nombrePhase;
  String? description;
  int? isActive;

  Models(
      {this.id,
        this.libelle,
        this.marqueId,
        this.nombrePhase,
        this.description,
        this.isActive});

  Models.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    libelle = json['libelle'];
    marqueId = json['marqueId'];
    nombrePhase = json['nombrePhase'];
    description = json['description'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['libelle'] = libelle;
    data['marqueId'] = marqueId;
    data['nombrePhase'] = nombrePhase;
    data['description'] = description;
    data['isActive'] = isActive;
    return data;
  }
}
