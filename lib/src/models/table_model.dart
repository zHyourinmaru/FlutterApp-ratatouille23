import 'dart:convert';

TableModel tableModelFromJson(String str) =>
    TableModel.fromJson(json.decode(str));

String tableModelToJson(TableModel data) => json.encode(data.toJson());

class TableModel {
  TableModel({
    required this.id,
    required this.number,
    required this.capacity,
  });

  int id;
  int number;
  int capacity;

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        id: json["id"],
        number: json["number"],
        capacity: json["capacity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "capacity": capacity,
      };
}
