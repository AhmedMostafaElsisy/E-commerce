import 'dart:developer';

import 'package:captien_omda_customer/features/Home_feature/Domain/enitiy/location_model.dart';
import 'package:captien_omda_customer/features/Home_feature/Domain/enitiy/rateing_model.dart';

import '../../../../core/Constants/Enums/request_states.dart';
import 'car_model.dart';
import 'driver_model.dart';

List<RequestModel> requestListFromJson(List str) =>
    List<RequestModel>.from(str.map((x) => RequestModel.fromJson(x)));

class RequestModel {
  int? id;
  num? price;
  RequestStates? state;
  LocationModel? fromLocation;
  LocationModel? toLocation;
  DriverModel? driverModel;
  CarModel? carModel;
  RatingModel? rateModel;

  RequestModel(
      {this.id,
      this.price,
      this.fromLocation,
      this.toLocation,
      this.state,
      this.driverModel,
      this.carModel,
      this.rateModel});

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    RequestStates getRequestStates(String state) {
      switch (state.toLowerCase()) {
        case "new":
          return RequestStates.newRequest;
        case "canceled":
          return RequestStates.cancelRequest;
        case "finished":
          return RequestStates.finishedRequest;
        case "pending":
          return RequestStates.pendingRequest;
        case "started":
          return RequestStates.startedRequest;
        default:
          return RequestStates.cancelRequest;
      }
    }

    log("this the request model ${json}");
    return RequestModel(
      id: json["id"],
      price: json["price"] ?? 0.0,
      fromLocation: LocationModel.fromJson(json["from"]),
      toLocation: LocationModel.fromJson(json["to"]),
      state: json["state"] == null
          ? RequestStates.cancelRequest
          : getRequestStates(json["state"]),
      driverModel:
          json["driver"] == null ? null : DriverModel.fromJson(json["driver"]),
      carModel: json["car"] == null ? null : CarModel.fromJson(json["car"]),
      rateModel: json["rate"] == null
          ? null
          : json["rate"].isEmpty
              ? null
              : RatingModel.fromJson(json["rate"][0]),
    );
  }

  @override
  String toString() {
    return 'RequestModel{id: $id, price: $price, state: $state, fromLocation: $fromLocation, toLocation: $toLocation, driverModel: $driverModel, carModel: $carModel}';
  }
}
