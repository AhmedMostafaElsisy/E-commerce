class LocationModel {
  int? id;
  String? locationName;

  LocationModel({this.id, this.locationName});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
        id: json["id"] ?? 0, locationName: json["name"] ?? '--');
  }
}