

// Importez vos modèles, mais ils ne sont plus nécessaires ici !
// C'est la preuve que la classe est maintenant découplée.

class DataResponse<T> {
  // --- CHANGEMENT 1: Immutabilité ---
  // Rendre les champs 'final' est une bonne pratique.
  // Cela empêche les modifications accidentelles après la création.
  final T? item;
  final List<T>? items;
  final String? message;
  final int? statusCode;
  final ErrorStatus? errorStatus;
  final bool? error;

  // On crée un constructeur privé pour forcer l'utilisation de la factory 'fromJson'
  DataResponse._({this.item, this.items, this.message, this.errorStatus, this.statusCode, this.error});

  factory DataResponse.failure(String message) {
    return DataResponse._(
      message: message,
      error: true, // L'erreur est automatiquement mise à 'true'
      item: null, // Pas de données en cas d'échec
      items: null, // Pas de données en cas d'échec
    );
  }

  // --- CHANGEMENT 2: La Factory 'fromJson' optimisée ---
  // C'est ici que la magie opère.
  factory DataResponse.fromJson(
    Map<String, dynamic> json,
    // On exige une fonction 'parser'.
    // Elle sait comment transformer un 'dynamic' (le JSON) en un objet de type 'T'.
    T Function(dynamic json) parser,
  ) {
    final message = json['message'] as String?;
    final error = json['error'] as bool? ?? false;

    T? parsedItem;
    List<T>? parsedItems;

    // On ne tente de parser les données que si l'API a renvoyé des données
    // ET qu'il n'y a pas d'erreur.
    if (json["data"] != null && error == false) {
      dynamic decodedObject = json["data"];

      if (decodedObject is Map<String, dynamic>) {
        // On utilise le 'parser' fourni au lieu de _getData
        parsedItem = parser(decodedObject);
      } else if (decodedObject is List<dynamic>) {
        // On utilise le 'parser' pour chaque élément de la liste
        parsedItems = decodedObject.map<T>((x) => parser(x)).toList();
      }
    }

    var errorStatus = json['error'] != null ? ErrorStatus.fromJson(json['error']) : null;

    // On retourne la nouvelle instance immuable
    return DataResponse._(item: parsedItem, items: parsedItems, message: message, errorStatus: errorStatus);
  }

  // --- CHANGEMENT 3: La fonction 'when' améliorée (Objectif #3) ---
  // Elle ne retourne que les valeurs existantes dans des callbacks dédiés.
  void when({
    /// Appelé si 'item' (un objet unique) n'est pas null
    Function(T item)? onItem,

    /// Appelé si 'items' (une liste d'objets) n'est pas null
    Function(List<T> items)? onItems,

    /// Appelé en cas de succès, mais si 'item' et 'items' sont null
    Function()? onEmpty,

    /// Appelé si 'error' est true
    required Function(String? message) failure,
  }) {
    if (errorStatus != null || error == true) {
      failure(errorStatus?.message ?? "Désolé, nous n'avons pu traiter votre demande !");
      return;
    }

    // Vos callbacks ne reçoivent que des valeurs non-nulles.
    if (item != null && onItem != null) {
      onItem(item as T);
    } else if (items != null && onItems != null) {
      onItems(items as List<T>);
    } else if (onEmpty != null) {
      onEmpty(); // Succès, mais pas de données (ex: HTTP 204)
    }
  }
}

class ErrorStatus {
  int? status;
  String? code;
  String? message;
  Null? details;
  String? requestId;
  String? timestamp;

  ErrorStatus({this.status, this.code, this.message, this.details, this.requestId, this.timestamp});

  ErrorStatus.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    details = json['details'];
    requestId = json['requestId'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    data['details'] = details;
    data['requestId'] = requestId;
    data['timestamp'] = timestamp;
    return data;
  }
}
