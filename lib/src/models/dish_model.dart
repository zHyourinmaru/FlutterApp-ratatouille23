import 'allergen_model.dart';

class DishModel {
  DishModel({
     this.id,
     this.name,
     this.description,
     this.price,
     this.allergens
  });

  int? id;
  String? name;
  String? description;
  double? price;
  List<AllergenModel>? allergens;

  factory DishModel.fromJson(Map<String, dynamic> json) => DishModel(
      id: json["id"],
      name: json["name"],
      description: json["description"] ?? "",
      price: json["price"].toDouble(),
      allergens: []
  );

  Map<String, dynamic> toJson() => {
    "id": id ?? 0,
    "name": name ?? "",
    "description": description ?? "",
    "price": price ?? 0,
    "allergensID": allergens ?? [],
  };
}