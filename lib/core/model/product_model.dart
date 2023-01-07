import 'package:captien_omda_customer/core/model/shop_model.dart';

List<ProductModel> productListFromJson(List str) =>
    List<ProductModel>.from(str.map((x) => ProductModel.fromJson(x)));

class ProductModel {
  int? id;
  String? name;
  String? image;
  String? price;
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
      this.image,
      this.price,
      this.description,
      this.time,
      this.shopModel,
      this.isFav,
      this.type,
      this.state,
      this.brand});

  ///Todo:check the json key when integrate with the api
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json["id"],
        name: json["product_name"] ?? "--",
        image: json["product_image"] ?? "",
        price: json["price"] ?? "00",
        description: json["description"] ?? "--",
        isFav: json["is_fav"] ?? false,
        shopModel: json["shop"] == null
            ? ShopModel()
            : ShopModel.fromJson(json["shop"]),
        time: json["time"],
    state: json["state"]??"state",
      type: json["type"]??"type",
      brand: json["brand"]??"brand",
    );
  }
}
