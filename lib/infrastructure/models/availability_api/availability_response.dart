// To parse this JSON data, do
//
//     final availabilityResponse = availabilityResponseFromJson(jsonString);

class AvailabilityResponse {
  final String id;
  final String bussinessId;
  final DateTime dayDate;
  final List<AvailabilitySlot> slots;
  final int v;

  AvailabilityResponse({
    required this.id,
    required this.bussinessId,
    required this.dayDate,
    required this.slots,
    required this.v,
  });

  factory AvailabilityResponse.fromJson(Map<String, dynamic> json) =>
      AvailabilityResponse(
        id: json["_id"],
        bussinessId: json["bussinessID"],
        dayDate: DateTime.parse(json["dayDate"]),
        slots: List<AvailabilitySlot>.from(
            json["slots"].map((x) => AvailabilitySlot.fromJson(x))),
        v: json["__v"],
      );
}

class AvailabilitySlot {
  final DateTime startTime;
  final DateTime endTime;
  final bool isAvailable;
  final String id;

  AvailabilitySlot({
    required this.startTime,
    required this.endTime,
    required this.isAvailable,
    required this.id,
  });

  factory AvailabilitySlot.fromJson(Map<String, dynamic> json) =>
      AvailabilitySlot(
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        isAvailable: json["isAvailable"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "isAvailable": isAvailable,
        "_id": id,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
