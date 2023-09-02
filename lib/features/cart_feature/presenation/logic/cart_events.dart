import '../../../../core/model/product_model.dart';

abstract class CartEvent {}

class GetCartItemEvent extends CartEvent {}

class AddProductToCartEvent extends CartEvent {
  ProductModel productModel;

  AddProductToCartEvent({required this.productModel});
}

class ChangeProductQuantityDependOnCartOrNotEvent extends CartEvent {
  ProductModel productModel;
  int quantity;

  ChangeProductQuantityDependOnCartOrNotEvent(
      {required this.productModel, required this.quantity});
}

class RemoveProductFromCartEvent extends CartEvent {
  ProductModel productModel;

  RemoveProductFromCartEvent({required this.productModel});
}

class ConfirmOrderEvent extends CartEvent {
  ConfirmOrderEvent();
}
