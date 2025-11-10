class ConstatCategoryModel {
  String? id;
  String? name;
  String? typeEquipement;
  List<Constats>? constats;

  ConstatCategoryModel(
      {this.id, this.name, this.typeEquipement, this.constats});

  ConstatCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    typeEquipement = json['typeEquipement'];
    if (json['constats'] != null) {
      constats = <Constats>[];
      json['constats'].forEach((v) {
        constats!.add(Constats.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['typeEquipement'] = typeEquipement;
    if (constats != null) {
      data['constats'] = constats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Constats {
  String? id;
  String? name;
  List<Actions>? actions;

  Constats({this.id, this.name, this.actions});

  Constats.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['actions'] != null) {
      actions = <Actions>[];
      json['actions'].forEach((v) {
        actions!.add(Actions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (actions != null) {
      data['actions'] = actions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Actions {
  String? id;
  String? name;
  int? statut;

  Actions({this.id, this.name, this.statut});

  Actions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    statut = json['statut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['statut'] = statut;
    return data;
  }
}
