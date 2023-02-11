List<LocationAreaModel> locationAreaListFromJson(List str) =>
    List<LocationAreaModel>.from(str.map((x) => LocationAreaModel.fromJson(x)));

class LocationAreaModel {
  int? id;
  String? name;
  int? cityId;

  LocationAreaModel({
    this.id,
    this.cityId,
    this.name,
  });

  factory LocationAreaModel.fromJson(Map<String, dynamic> json) {
    return LocationAreaModel(
      id: json["id"],
      cityId: json["city_id"],
      name: json["name"],
    );
  }
  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "city_id": cityId,
  };
  @override
  String toString() {
    return 'LocationModel{id: $id, name: $name, cityId: $cityId}';
  }
}
