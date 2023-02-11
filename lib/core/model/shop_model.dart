List<ShopModel> shopListFromJson(List str) =>
    List<ShopModel>.from(str.map((x) => ShopModel.fromJson(x)));

class ShopModel {
  int? id;
  String? name;
  String? image;
  String? location;
  String? category;
  String? subCategory;
  String? phone;
  String? email;
  String? ownerName;
  String? city;
  String? area;
  double? rate;

  ShopModel(
      {this.id,
      this.name,
      this.image,
      this.location,
      this.category,
      this.subCategory,
      this.phone,
      this.email,
      this.ownerName,
      this.city,
      this.area,
      this.rate});

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: json["id"],
      name: json["shop_name"] ?? "--",
      image: json["shop_image"] ?? "",
      category: json["category"] ?? "--",
      location: json["location"] ?? "--",
      subCategory: json["sub_category"] ?? "--",
      phone: json["phone"] ?? "--",
      email: json["email"] ?? "--",
      ownerName: json["owner_name"] ?? "--",
      city: json["city"] ?? "--",
      area: json["area"] ?? "--",
      rate: double.parse(json["rate"].toString()) ?? 0.0,
    );
  }

  @override
  String toString() {
    return 'ShopModel{id: $id, name: $name, image: $image, location: $location, category: $category, subCategory: $subCategory, phone: $phone, email: $email, ownerName: $ownerName, city: $city, area: $area, rate: $rate}';
  }
}
