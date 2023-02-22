import '../../../../core/model/product_model.dart';

List<CartModel> cartListFromJson(List str) =>
    List<CartModel>.from(str.map((x) => CartModel.fromJson(x)));

class CartModel {
  int? id;
  num? total;
  num? price;
  num? discount;
  num? qnt;
  ProductModel? cartProduct;

  CartModel(
      {this.id,
      this.total,
      this.price,
      this.discount,
      this.qnt,
      this.cartProduct});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
        id: json["id"],
        price: json["price"],
        discount: json["discount"],
        total: json["total"],
        qnt: json["qnt"],
        cartProduct: ProductModel.fromJson(json["product"]));
  }
}
