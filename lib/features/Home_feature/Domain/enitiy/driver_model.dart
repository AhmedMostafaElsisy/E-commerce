class DriverModel {
  int? id;
  String? name;
  String? image;
  String? rate;

  DriverModel({this.id, this.name, this.image, this.rate});

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json["id"],
      name: json["name"] ?? "--",
      image: json["image"] ?? "--",
      rate: json["rate"] == null ? "0.0" : json["rate"].toString(),
    );
  }

  @override
  String toString() {
    return 'DriverModel{id: $id, name: $name, image: $image, rate: $rate}';
  }
}
