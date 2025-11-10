class ListEventModel {
  List<EventModel>? result;
  int? count;
  PaginationResult? paginationResult;

  ListEventModel({this.result, this.count, this.paginationResult});

  ListEventModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <EventModel>[];
      json['result'].forEach((v) {
        result!.add(EventModel.fromJson(v));
      });
    }
    count = json['count'];
    paginationResult = json['paginationResult'] != null
        ? PaginationResult.fromJson(json['paginationResult'])
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

class EventModel {
  int? id;
  String? name;
  String? description;
  String? date;
  String? startTime;
  String? endTime;

  EventModel(
      {this.id,
        this.name,
        this.description,
        this.date,
        this.startTime,
        this.endTime});

  EventModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    date = json['date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['date'] = date;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    return data;
  }
}

class PaginationResult {
  int? currentPage;
  Null? previousPage;
  int? nextPage;
  int? count;
  int? totalCount;
  int? totalPages;

  PaginationResult(
      {this.currentPage,
        this.previousPage,
        this.nextPage,
        this.count,
        this.totalCount,
        this.totalPages});

  PaginationResult.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    previousPage = json['previousPage'];
    nextPage = json['nextPage'];
    count = json['count'];
    totalCount = json['totalCount'];
    totalPages = json['totalPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['previousPage'] = previousPage;
    data['nextPage'] = nextPage;
    data['count'] = count;
    data['totalCount'] = totalCount;
    data['totalPages'] = totalPages;
    return data;
  }
}
