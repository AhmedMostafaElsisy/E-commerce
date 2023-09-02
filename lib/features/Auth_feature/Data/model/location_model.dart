
import '../../../../core/location_feature/domain/model/location_area_model.dart';

class LocationModel {
  int? id;
  String? streetName;
  LocationAreaModel? cityModel;
  LocationAreaModel? areaModel;

  LocationModel({this.id, this.streetName, this.cityModel, this.areaModel});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json["id"],
      streetName: json["street"],
      areaModel: LocationAreaModel.fromJson(json["area"]),
      cityModel: LocationAreaModel.fromJson(json["city"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "street": streetName,
        "city": cityModel!.toJson(),
        "area": areaModel!.toJson(),
      };
}
