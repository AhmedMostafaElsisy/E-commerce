import 'package:captien_omda_customer/features/Home_feature/Domain/enitiy/location_model.dart';

List<RequestModel> requestListFromJson(List str) =>
    List<RequestModel>.from(str.map((x) => RequestModel.fromJson(x)));

class RequestModel {
  int? id;
  num? price;
  LocationModel? fromLocation;
  LocationModel? toLocation;

  RequestModel({this.id, this.price, this.fromLocation, this.toLocation});

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json["id"],
      price: json["price"] ?? 0.0,
      fromLocation: LocationModel.fromJson(json["from"]),
      toLocation: LocationModel.fromJson(json["to"]),
    );
  }
}
