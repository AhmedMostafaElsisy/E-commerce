import 'package:captien_omda_customer/core/location_feature/domain/model/location_area_model.dart';
import 'package:captien_omda_customer/core/model/category_model.dart';
import 'package:captien_omda_customer/core/tags_feature/domain/model/tags_model.dart';

import '../../features/Auth_feature/Domain/entities/base_user_entity.dart';
import '../../features/plans_feature/domain/model/plans_model.dart';

List<ShopModel> shopListFromJson(List str) =>
    List<ShopModel>.from(str.map((x) => ShopModel.fromJson(x)));

class ShopModel {
  int? id;
  String? name;
  String? image;
  String? address;
  CategoryModel? category;
  List<TagsModel>? subCategory;
  String? phone;
  String? email;
  String? ownerName;
  LocationAreaModel? city;
  LocationAreaModel? area;
  double? rate;
  UserBaseEntity? currentUser;
  PlansModel? plansModel;

  ShopModel(
      {this.id,
      this.name,
      this.image,
      this.address,
      this.category,
      this.subCategory,
      this.phone,
      this.email,
      this.ownerName,
      this.city,
      this.area,
      this.currentUser,
      this.plansModel,
      this.rate});

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
        id: json["id"],
        name: json["name"] ?? "--",
        image: json["image"] ?? "",
        category: json["category"] == null
            ? CategoryModel(
                name: "--", id: -1, active: false, slug: "", image: "")
            : CategoryModel.fromJson(json["category"]),
        address: json["address"] ?? "--",
        subCategory: json["tags"] == null
            ? [TagsModel(name: "--")]
            : tagsListFromJson(json["tags"]),
        phone: json["phone"] ?? "--",
        email: json["email"] ?? "--",
        ownerName: json["username"] ?? "--",
        city: json["city"] != null
            ? LocationAreaModel.fromJson(json["city"])
            : LocationAreaModel(id: -1, name: "--"),
        area: json["area"] != null
            ? LocationAreaModel.fromJson(json["area"])
            : LocationAreaModel(id: -1, name: "--"),
        currentUser: UserBaseEntity.fromJson(json["user"]),
        rate: double.parse((json["rate"] ?? "0.0").toString()),
        plansModel: PlansModel.fromJson(json["plan"]));
  }

  @override
  String toString() {
    return 'ShopModel{id: $id, name: $name, image: $image, location: $address, category: $category, subCategory: $subCategory, phone: $phone, email: $email, ownerName: $ownerName, city: $city, area: $area, rate: $rate}';
  }
}
