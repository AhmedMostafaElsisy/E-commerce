import 'package:captien_omda_customer/core/model/product_model.dart';

import '../../features/cart_feature/domain/entity/cart_entity.dart';

List<CartModel> cartsListFromJson(List str) =>
    List<CartModel>.from(str.map((x) => CartModel.fromJson(x)));

class CartModel extends CartEntity {
  CartModel({
    required int id,
    required num total,
    required num price,
    required int quantity,
    required ProductModel productModel,
  }) : super(
          id: id,
          total: total,
          price: price,
          quantity: quantity,
          productModel: productModel,
        );

  factory CartModel.fromJson(Map<String, dynamic> jsonObject) {
    try {
      return CartModel(
        id: jsonObject["id"],
        total: jsonObject["total"],
        price: jsonObject["price"],
        quantity: jsonObject["qnt"],
        productModel: ProductModel.fromJson(jsonObject["product"])
          ..productTempQuantity = jsonObject["qnt"],
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "total": total,
      "price": price,
      "qnt": quantity,
      "product": productModel,
    };
  }

  @override
  String toString() {
    return "cart model id: $id,total: $total, price: $price, quantity: $quantity, product: $productModel";
  }
}
