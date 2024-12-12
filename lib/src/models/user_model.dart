import 'dart:convert';

import 'package:ratatouille23/src/models/role.dart';

UserModel welcomeFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
  });


  int? id;
  String? firstName;
  String? lastName;
  String? email;
  Role? role;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        role: json["role"] != null ? Role.values.firstWhere((e) => e.toString() == 'Role.' + json["role"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "role": role.toString().replaceFirst("Role.", ""),
      };
}
