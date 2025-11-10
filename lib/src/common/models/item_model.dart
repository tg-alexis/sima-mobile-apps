class Item {
  String? id;
  String? nom;
  String? idabon;
  int? psabon;
  String? posabon;
  String? sectact;
  String? compteur;
  num? latitude;
  String? quartier;
  String? fabricant;
  num? longitude;
  String? reference;
  String? libelleDr;
  String? refraccord;
  String? typeClient;
  String? typecompttage;
  String? equipementCode;
  String? equipementType;
  String? typeCommunication;
  String? libelleExploitation;

  Item(
      {this.id,
        this.nom,
        this.idabon,
        this.psabon,
        this.posabon,
        this.sectact,
        this.compteur,
        this.latitude,
        this.quartier,
        this.fabricant,
        this.longitude,
        this.reference,
        this.libelleDr,
        this.refraccord,
        this.typeClient,
        this.typecompttage,
        this.equipementCode,
        this.equipementType,
        this.typeCommunication,
        this.libelleExploitation});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    idabon = json['idabon'];
    psabon = json['psabon'];
    posabon = json['posabon'];
    sectact = json['sectact'];
    compteur = json['compteur'];
    latitude = json['latitude'];
    quartier = json['quartier'];
    fabricant = json['fabricant'];
    longitude = json['longitude'];
    reference = json['reference'];
    libelleDr = json['libelle_dr'];
    refraccord = json['refraccord'];
    typeClient = json['type_client'];
    typecompttage = json['typecompttage'];
    equipementCode = json['equipement_code'];
    equipementType = json['equipement_type'];
    typeCommunication = json['type_communication'];
    libelleExploitation = json['libelle_exploitation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nom'] = nom;
    data['idabon'] = idabon;
    data['psabon'] = psabon;
    data['posabon'] = posabon;
    data['sectact'] = sectact;
    data['compteur'] = compteur;
    data['latitude'] = latitude;
    data['quartier'] = quartier;
    data['fabricant'] = fabricant;
    data['longitude'] = longitude;
    data['reference'] = reference;
    data['libelle_dr'] = libelleDr;
    data['refraccord'] = refraccord;
    data['type_client'] = typeClient;
    data['typecompttage'] = typecompttage;
    data['equipement_code'] = equipementCode;
    data['equipement_type'] = equipementType;
    data['type_communication'] = typeCommunication;
    data['libelle_exploitation'] = libelleExploitation;
    return data;
  }
}