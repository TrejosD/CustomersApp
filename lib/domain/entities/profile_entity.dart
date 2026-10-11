enum Gender { woman, man, undefined }

class Profile {
  // id = el ID lo deberia asignar el API
  String? id;
  String name;
  String? lastName;
  Gender? gender;

  Profile({required this.name, this.lastName, this.gender, this.id});
}
