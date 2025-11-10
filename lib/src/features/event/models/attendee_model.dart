class AttendeeModel {
  int? eventId;
  String? attendeeId;

  AttendeeModel({this.eventId, this.attendeeId});

  AttendeeModel.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    attendeeId = json['attendee_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['event_id'] = eventId;
    data['attendee_id'] = attendeeId;
    return data;
  }
}
