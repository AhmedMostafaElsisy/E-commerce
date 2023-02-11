class CityModel {
  int? id;
  String? name;

  CityModel({this.id, this.name});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(id: json["id"], name: json["name"]);
  }
  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,

  };
}
