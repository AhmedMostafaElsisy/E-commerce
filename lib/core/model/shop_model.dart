List<ShopModel> shopListFromJson(List str) =>
    List<ShopModel>.from(str.map((x) => ShopModel.fromJson(x)));

class ShopModel {
  int? id;
  String? name;
  String? image;
  String? location;
  String? category;

  ShopModel({this.id, this.name, this.image, this.location, this.category});

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
        id: json["id"],
        name: json["shop_name"] ?? "--",
        image: json["shop_image"] ?? "",
        category: json["category"] ?? "--",
        location: json["location"] ?? "--");
  }
}
