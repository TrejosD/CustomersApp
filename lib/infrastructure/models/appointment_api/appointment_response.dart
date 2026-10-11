class AppointmentResponse {
  final DateTime startTime;
  final DateTime endTime;
  final bool isAvailable;
  final String id;

  AppointmentResponse({
    required this.startTime,
    required this.endTime,
    required this.isAvailable,
    required this.id,
  });

  factory AppointmentResponse.fromJson(Map<String, dynamic> json) =>
      AppointmentResponse(
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        isAvailable: json["isAvailable"],
        id: json["_id"],
      );
}
