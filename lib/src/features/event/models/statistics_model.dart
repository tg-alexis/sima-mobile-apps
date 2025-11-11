class StatisticsModel {
  int? totalAccess;
  int? totalEvents;

  StatisticsModel({this.totalAccess, this.totalEvents});

  StatisticsModel.fromJson(Map<String, dynamic> json) {
    totalAccess = json['total_access'];
    totalEvents = json['total_events'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_access'] = totalAccess;
    data['total_events'] = totalEvents;
    return data;
  }
}
