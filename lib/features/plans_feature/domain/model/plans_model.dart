import 'package:captien_omda_customer/features/plans_feature/domain/model/plan_feature_model.dart';

List<PlansModel> plansListFromJson(List str) =>
    List<PlansModel>.from(str.map((x) => PlansModel.fromJson(x)));

class PlansModel {
  int? id;
  String? name;
  String? type;
  String? description;
  int? price;
  int? discount;
  List<PlanFeatureModel>? features;

  PlansModel({
    this.id,
    this.type,
    this.name,
    this.description,
    this.price,
    this.discount,
    this.features,
  });

  factory PlansModel.fromJson(Map<String, dynamic> json) {
    return PlansModel(
      id: json["id"],
      type: json["type"],
      name: json["name"],
      price: json["price"],
      discount: json["discount"],
      features: plansFeatureListFromJson(json["features"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "type": type,
      };

  @override
  String toString() {
    return 'PlansModel{id: $id, name: $name, type: $type, description: $description, price: $price, discount: $discount, features: $features}';
  }
}
