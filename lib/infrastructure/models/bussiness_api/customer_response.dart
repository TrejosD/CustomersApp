class CustomerResponse {
  final String name;
  final String? lastName;
  final String gender;
  final String id;
  CustomerResponse(this.lastName,
      {required this.id, required this.name, required this.gender});

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      CustomerResponse(json['apellido'],
          id: json["_id"], name: json["nombre"], gender: json["gender"]);
}
