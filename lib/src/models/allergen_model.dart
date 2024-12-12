import 'dart:ffi';

class AllergenModel {
  AllergenModel({required this.id, required this.name});
  int id;
  String name;

  factory AllergenModel.fromJson(Map<String, dynamic> json) => AllergenModel(
    id: json["id"] ,
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

}

