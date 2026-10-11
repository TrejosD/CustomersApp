class AppointmentDb {
  final String id;
  final String bussinessId;
  final String customerId;
  final String productId;
  final DateTime startTime;
  final String slothId;
  final int v;
  final DateTime endTime;

  AppointmentDb({
    required this.id,
    required this.bussinessId,
    required this.customerId,
    required this.productId,
    required this.startTime,
    required this.slothId,
    required this.v,
    required this.endTime,
  });

  factory AppointmentDb.fromJson(Map<String, dynamic> json) => AppointmentDb(
        id: json["_id"],
        bussinessId: json["bussinessID"],
        customerId: json["customerID"],
        productId: json["productID"],
        startTime: DateTime.parse(json["startTime"]),
        slothId: json["slothID"],
        v: json["__v"],
        endTime: DateTime.parse(json["endTime"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "bussinessID": bussinessId,
        "customerID": customerId,
        "productID": productId,
        "startTime": startTime.toIso8601String(),
        "slothID": slothId,
        "__v": v,
        "endTime": endTime.toIso8601String(),
      };
}
