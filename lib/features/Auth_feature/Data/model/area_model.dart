class AreaModel {
  int? id;
  int? cityId;
  String? name;

  AreaModel({this.id, this.name, this.cityId});

  factory AreaModel.fromJson(Map<String, dynamic> json) {
    return AreaModel(
        id: json["id"], name: json["name"], cityId: json["city_id"]);
  }

  Map<String, dynamic> toJson() => {"name": name, "id": id, "city_id": cityId};
}
