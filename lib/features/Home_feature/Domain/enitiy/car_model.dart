class CarModel {
  int? id;
  String? name;
  String? plate;
  String? brand;

  CarModel({this.id, this.name, this.plate, this.brand});

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json["id"],
      name: json["name"] ?? "--",
      plate: json["plate"] ?? "--",
      brand: json["brand"] ?? "--",
    );
  }

  @override
  String toString() {
    return 'CarModel{id: $id, name: $name, plate: $plate, brand: $brand}';
  }
}
