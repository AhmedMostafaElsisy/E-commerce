import 'package:captien_omda_customer/core/model/shop_model.dart';

import 'image_model.dart';

List<ProductModel> productListFromJson(List str) =>
    List<ProductModel>.from(str.map((x) => ProductModel.fromJson(x)));

class ProductModel {
  int? id;
  String? name;
  List<ImageModel>? images;
  String? price;
  String? discount;
  String? description;
  String? time;
  String? state;
  String? type;
  String? brand;
  ShopModel? shopModel;
  bool? isFav;

  ProductModel(
      {this.id,
      this.name,
      this.images,
      this.price,
      this.description,
      this.time,
      this.shopModel,
      this.isFav,
      this.discount,
      this.type,
      this.state,
      this.brand});

  ///Todo:check the json key when integrate with the api
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      name: json["name"] ?? "--",
      images: json['image'] != null && json['image'].isNotEmpty
          ? imageListFromJson(json['image'])
          : [],
      price: json["price"] == null ? "00" : json["price"].toString(),
      discount: json["discount"] == null ? "00" : json["discount"].toString(),
      description: json["description"] ?? "--",
      isFav: json["favorite"] ?? false,
      shopModel: json["store"] == null
          ? ShopModel()
          : ShopModel.fromJson(json["store"]),
      time: json["time"],
      state: json["state"] ?? "state",
      type: json["type"] ?? "type",
      brand: json["brand"] ?? "brand",
    );
  }

  @override
  String toString() {
    return 'ProductModel{id: $id, name: $name, images: $images, price: $price, discount: $discount, description: $description, time: $time, state: $state, type: $type, brand: $brand, shopModel: $shopModel, isFav: $isFav}';
  }
}
