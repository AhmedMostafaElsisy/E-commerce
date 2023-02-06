import 'package:captien_omda_customer/features/Auth_feature/Data/model/area_model.dart';
import 'package:captien_omda_customer/features/Auth_feature/Data/model/city_model.dart';

class LocationModel {
  int? id;
  String? streetName;
  CityModel? cityModel;
  AreaModel? areaModel;

  LocationModel({this.id, this.streetName, this.cityModel, this.areaModel});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json["id"],
      streetName: json["street"],
      areaModel: AreaModel.fromJson(json["area"]),
      cityModel: CityModel.fromJson(json["city"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "street": streetName,
        "city": cityModel!.toJson(),
        "area": areaModel!.toJson(),
      };
}
