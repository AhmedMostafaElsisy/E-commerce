List<LocationAreaModel> locationAreaListFromJson(List str) =>
    List<LocationAreaModel>.from(str.map((x) => LocationAreaModel.fromJson(x)));

class LocationAreaModel {
  int? id;
  String? name;
  int? countryId;

  LocationAreaModel({
    this.id,
    this.countryId,
    this.name,
  });

  factory LocationAreaModel.fromJson(Map<String, dynamic> json) {
    return LocationAreaModel(
      id: json["id"],
      countryId: json["country_id"],
      name: json["name"],
    );
  }

  @override
  String toString() {
    return 'LocationModel{id: $id, name: $name, countryId: $countryId}';
  }
}
