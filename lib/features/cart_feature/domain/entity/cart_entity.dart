import 'package:captien_omda_customer/core/model/product_model.dart';

class CartEntity {
  int id;
  num total;
  num price;
  int quantity;
  ProductModel productModel;

  CartEntity({
    required this.id,
    required this.total,
    required this.price,
    required this.quantity,
    required this.productModel,
  });
}
