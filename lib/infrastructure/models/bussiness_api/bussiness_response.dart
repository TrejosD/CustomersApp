// To parse this JSON data, do
//
//     final bussinessResponse = bussinessResponseFromJson(jsonString);

class BussinessResponse {
  final String id;
  final String name;
  final String description;
  final String address;
  final String urlGps;
  final List<Position> positions;
  final List<ProductDB> products;
  final int defaultAppointmentTime;
  final Schedule schedule;
  final ContactInfo contactInfo;
  final int doneServices;
  final List<String> customerComments;
  final int followers;
  final double rate;
  final int v;

  BussinessResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.urlGps,
    required this.positions,
    required this.products,
    required this.defaultAppointmentTime,
    required this.schedule,
    required this.contactInfo,
    required this.doneServices,
    required this.customerComments,
    required this.followers,
    required this.rate,
    required this.v,
  });

  factory BussinessResponse.fromJson(Map<String, dynamic> json) =>
      BussinessResponse(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        address: json["address"],
        urlGps: json["urlGPS"] ?? '',
        positions: List<Position>.from(
          json["positions"].map((x) => Position.fromJson(x)),
        ),
        products: List<ProductDB>.from(
          json["products"].map((x) => ProductDB.fromJson(x)),
        ),
        defaultAppointmentTime: json["defaultAppointmentTime"] ?? 30,
        schedule: Schedule.fromJson(json["schedule"] ??
            {"days": [], "startYourney": 0, "endYourney": 0}),
        contactInfo: ContactInfo.fromJson(
            json["contactInfo"] ?? {"email": '', "number": '', "social": []}),
        doneServices: json["doneServices"] ?? 0,
        customerComments: List<String>.from(
          json["customerComments"].map((x) => x),
        ),
        followers: json["followers"] ?? 0,
        rate: json["rate"]?.toDouble() ?? 0.0,
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "address": address,
        "urlGPS": urlGps,
        "positions": List<dynamic>.from(positions.map((x) => x.toJson())),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "defaultAppointmentTime": defaultAppointmentTime,
        "schedule": schedule.toJson(),
        "contactInfo": contactInfo.toJson(),
        "doneServices": doneServices,
        "customerComments": List<dynamic>.from(customerComments.map((x) => x)),
        "followers": followers,
        "rate": rate,
        "__v": v,
      };
}

class ContactInfo {
  final String email;
  final String number;
  final List<Social> social;

  ContactInfo({
    required this.email,
    required this.number,
    required this.social,
  });

  factory ContactInfo.fromJson(Map<String, dynamic> json) => ContactInfo(
        email: json["email"],
        number: json["number"],
        social:
            List<Social>.from(json["social"].map((x) => socialValues.map[x]!)),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "number": number,
        "social":
            List<dynamic>.from(social.map((x) => socialValues.reverse[x])),
      };
}

enum Social { FACEBOOK, INSTAGRAM, TIKTOK }

final socialValues = EnumValues({
  "facebook": Social.FACEBOOK,
  "instagram": Social.INSTAGRAM,
  "tiktok": Social.TIKTOK,
});

class Position {
  final String name;
  final List<ProductDB> products;

  Position({required this.name, required this.products});

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        name: json["name"],
        products: List<ProductDB>.from(
          json["products"].map((x) => ProductDB.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class ProductDB {
  final String name;
  final int time;
  final int price;
  final String id;

  ProductDB({
    required this.name,
    required this.time,
    required this.price,
    required this.id,
  });

  factory ProductDB.fromJson(Map<String, dynamic> json) => ProductDB(
        name: json["name"],
        time: json["time"],
        price: json["price"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "time": time,
        "price": price,
        "_id": id,
      };
}

class Schedule {
  final List<int> days;
  final int startYourney;
  final int endYourney;

  Schedule({
    required this.days,
    required this.startYourney,
    required this.endYourney,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        days: List<int>.from(json["days"].map((x) => x)),
        startYourney: json["startYourney"],
        endYourney: json["endYourney"],
      );

  Map<String, dynamic> toJson() => {
        "days": List<dynamic>.from(days.map((x) => x)),
        "startYourney": startYourney,
        "endYourney": endYourney,
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
