import '../common.dart';

class MaintenanceModel {
  String? id;
  String? reference;
  String? equipementCode;
  String? equipementType;
  String? fabricant;
  String? statut;
  int? statutMaintenance;
  int? level;
  String? position;
  String? typeCommunication;
  double? latitude;
  double? longitude;
  String? localisation;
  int? positionNumber;
  List<Operations>? operations;
  List<Mouvements>? mouvements;
  Item? item;
  String? type;
  String? identifiant;
  String? numeroCtr;
  bool? tc;
  bool? inSmartAmi;
  bool? stel;
  String? dr;
  String? secteur;
  String? observation;

  MaintenanceModel({
    this.id,
    this.reference,
    this.equipementCode,
    this.equipementType,
    this.fabricant,
    this.statut,
    this.statutMaintenance,
    this.level,
    this.position,
    this.typeCommunication,
    this.latitude,
    this.longitude,
    this.localisation,
    this.positionNumber,
    this.operations,
    this.mouvements,
    this.item,
    this.type,
    this.identifiant,
    this.numeroCtr,
    this.tc,
    this.inSmartAmi,
    this.stel,
    this.dr,
    this.secteur,
    this.observation
  });

  MaintenanceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reference = json['reference'];
    equipementCode = json['equipementCode'];
    equipementType = json['equipementType'];
    fabricant = json['fabricant'];
    statut = json['statut'].toString();
    statutMaintenance = json['statutMaintenance'];
    level = json['level'];
    position = json['position'];
    typeCommunication = json['typeCommunication'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    localisation = json['localisation'];
    positionNumber = json['positionNumber'];
    type = json['type'];
    identifiant = json['identifiant'];
    numeroCtr = json['numeroCtr'];
    tc = json['tc'];
    inSmartAmi = json['inSmartAmi'];
    stel = json['stel'];
    dr = json['dr'];
    secteur = json['secteur'];
    observation = json['observation'];
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
    if (json['operations'] != null) {
      operations = <Operations>[];
      json['operations'].forEach((v) {
        operations!.add(Operations.fromJson(v));
      });
    }
    if (json['mouvements'] != null) {
      mouvements = <Mouvements>[];
      json['mouvements'].forEach((v) {
        mouvements!.add(Mouvements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reference'] = reference;
    data['equipementCode'] = equipementCode;
    data['equipementType'] = equipementType;
    data['fabricant'] = fabricant;
    data['statut'] = statut;
    data['statutMaintenance'] = statutMaintenance;
    data['level'] = level;
    data['position'] = position;
    data['typeCommunication'] = typeCommunication;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['localisation'] = localisation;
    data['positionNumber'] = positionNumber;
    if (item != null) {
      data['item'] = item!.toJson();
    }
    if (operations != null) {
      data['operations'] = operations!.map((v) => v.toJson()).toList();
    }
    if (mouvements != null) {
      data['mouvements'] = mouvements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Operations {
  String? id;
  ConstatList? constatList;
  ActionDeCorrection? actionDeCorrection;

  Operations({this.id, this.constatList, this.actionDeCorrection});

  Operations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    constatList = json['constatList'] != null ? ConstatList.fromJson(json['constatList']) : null;
    actionDeCorrection = json['actionDeCorrection'] != null ? ActionDeCorrection.fromJson(json['actionDeCorrection']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (constatList != null) {
      data['constatList'] = constatList!.toJson();
    }
    if (actionDeCorrection != null) {
      data['actionDeCorrection'] = actionDeCorrection!.toJson();
    }
    return data;
  }
}

class ConstatList {
  String? id;
  String? name;
  Category? category;

  ConstatList({this.id, this.name, this.category});

  ConstatList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    return data;
  }
}

class Category {
  String? id;
  String? name;

  Category({this.id, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class ActionDeCorrection {
  String? id;
  String? name;
  int? statut;

  ActionDeCorrection({this.id, this.name, this.statut});

  ActionDeCorrection.fromJson(Map<String, dynamic> json) {
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

class Mouvements {
  String? id;
  String? maintenanceId;
  String? agentId;
  String? instructions;
  String? dateIntervention;
  String? supervisorId;
  String? managerId;
  int? statutMaintenance;
  int? level;
  String? receptionDate;
  String? treatmentDate;
  Agent? agent;
  Agent? manager;

  Mouvements(
      {this.id,
        this.maintenanceId,
        this.agentId,
        this.instructions,
        this.dateIntervention,
        this.supervisorId,
        this.managerId,
        this.statutMaintenance,
        this.level,
        this.receptionDate,
        this.treatmentDate,
        this.agent,
        this.manager});

  Mouvements.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    maintenanceId = json['maintenanceId'];
    agentId = json['agentId'];
    instructions = json['instructions'];
    dateIntervention = json['dateIntervention'];
    supervisorId = json['supervisorId'];
    managerId = json['managerId'];
    statutMaintenance = json['statutMaintenance'];
    level = json['level'];
    receptionDate = json['receptionDate'];
    treatmentDate = json['treatmentDate'];
    agent = json['agent'] != null ? Agent.fromJson(json['agent']) : null;
    manager =
    json['manager'] != null ? Agent.fromJson(json['manager']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['maintenanceId'] = maintenanceId;
    data['agentId'] = agentId;
    data['instructions'] = instructions;
    data['dateIntervention'] = dateIntervention;
    data['supervisorId'] = supervisorId;
    data['managerId'] = managerId;
    data['statutMaintenance'] = statutMaintenance;
    data['level'] = level;
    data['receptionDate'] = receptionDate;
    data['treatmentDate'] = treatmentDate;
    if (agent != null) {
      data['agent'] = agent!.toJson();
    }
    if (manager != null) {
      data['manager'] = manager!.toJson();
    }
    return data;
  }
}

class Agent {
  String? id;
  String? firstname;
  String? lastname;
  String? email;

  Agent({this.id, this.firstname, this.lastname, this.email});

  Agent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    return data;
  }
}

