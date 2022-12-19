import 'package:captien_omda_customer/features/Home_feature/Domain/enitiy/location_model.dart';

import '../../../../core/Constants/Enums/request_states.dart';

List<RequestModel> requestListFromJson(List str) =>
    List<RequestModel>.from(str.map((x) => RequestModel.fromJson(x)));

class RequestModel {
  int? id;
  num? price;
  RequestStates? state;
  LocationModel? fromLocation;
  LocationModel? toLocation;

  RequestModel(
      {this.id, this.price, this.fromLocation, this.toLocation, this.state});

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    RequestStates getRequestStates(String state) {
      switch (state.toLowerCase()) {
        case "new":
          return RequestStates.newRequest;
        case "Canceled":
          return RequestStates.cancelRequest;
        case "finished":
          return RequestStates.finishedRequest;
        default:
          return RequestStates.cancelRequest;
      }
    }

    return RequestModel(
        id: json["id"],
        price: json["price"] ?? 0.0,
        fromLocation: LocationModel.fromJson(json["from"]),
        toLocation: LocationModel.fromJson(json["to"]),
        state: json["state"] == null
            ? RequestStates.cancelRequest
            : getRequestStates(json["state"]));
  }
}
