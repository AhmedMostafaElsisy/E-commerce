import '../../../Auth_feature/Data/model/location_model.dart';
import 'cart_model.dart';

List<OrderModel> orderListFromJson(List str) =>
    List<OrderModel>.from(str.map((x) => OrderModel.fromJson(x)));

class OrderModel {
  int? id;
  String? status;
  num? total;
  LocationModel? locationModel;
  List<CartModel>? orderCart;

  OrderModel(
      {this.id, this.status, this.total, this.locationModel, this.orderCart});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        id: json["id"],
        status: json["status"],
        total: json["total"],
        locationModel: LocationModel.fromJson(json["location"]),
        orderCart: cartListFromJson(json["carts"]));
  }
}
