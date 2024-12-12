import 'package:ratatouille23/src/models/dish_model.dart';
import 'package:ratatouille23/src/models/table_model.dart';
import 'package:ratatouille23/src/models/user_model.dart';
import 'package:time_machine/time_machine.dart';

class OrderModel {
  OrderModel({
    required this.id,
    required this.started,
    required this.completed,
    required this.dishes,
    required this.table,
    required this.waiter,
    required this.cook,
    required this.price,
  });

  int id;
  DateTime started;
  DateTime? completed;
  List<DishModel> dishes;
  int table;
  UserModel waiter;
  UserModel cook;
  double price;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json["id"],
    started: DateTime.parse(json["started"]),
    completed: json["completed"] != null ? DateTime.parse(json["completed"]) : null,
    dishes: (json["dishes"] as List<dynamic>).map((e) => DishModel.fromJson(e)).toList(),
    table: json["table"]["number"],
    waiter: UserModel.fromJson(json["waiter"]),
    cook: UserModel.fromJson(json["cook"]),
    price: (json["dishes"] as List<dynamic>).fold(0.0, (previousValue, element) => previousValue + element["price"].toDouble()),
  );
}