import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/model/cart_model.dart';
import '../../../../core/model/product_model.dart';

abstract class CartState {}

class CartInitState extends CartState {}

///fetch cart item states
class GetCartItemsLoadingState extends CartState {}

class GetCartItemsFailedState extends CartState {
  CustomError error;

  GetCartItemsFailedState({required this.error});
}

class GetCartItemsSuccessState extends CartState {
  List<CartModel> cartItems;

  GetCartItemsSuccessState({required this.cartItems});
}

///add product states
class AddProductToCartLoadingState extends CartState {
  ProductModel productThatInteractWith;

  AddProductToCartLoadingState({
    required this.productThatInteractWith,
  });
}

class AddProductToCartFailedState extends CartState {
  CustomError error;
  ProductModel productThatInteractWith;

  AddProductToCartFailedState({
    required this.error,
    required this.productThatInteractWith,
  });
}

class AddProductToCartSuccessState extends CartState {
  ProductModel productThatInteractWith;

  AddProductToCartSuccessState({
    required this.productThatInteractWith,
  });
}

///remove product states
class RemoveProductToCartLoadingState extends CartState {
  ProductModel productThatInteractWith;

  RemoveProductToCartLoadingState({
    required this.productThatInteractWith,
  });
}

class RemoveProductToCartFailedState extends CartState {
  CustomError error;
  ProductModel productThatInteractWith;

  RemoveProductToCartFailedState({
    required this.error,
    required this.productThatInteractWith,
  });
}

class RemoveProductToCartSuccessState extends CartState {
  ProductModel productThatInteractWith;

  RemoveProductToCartSuccessState({
    required this.productThatInteractWith,
  });
}

///change product quantity states
class ChangeProductQuantityLoadingState extends CartState {
  ProductModel productThatInteractWith;

  ChangeProductQuantityLoadingState({
    required this.productThatInteractWith,
  });
}

class ChangeProductQuantityFailedState extends CartState {
  CustomError error;
  ProductModel productThatInteractWith;

  ChangeProductQuantityFailedState({
    required this.error,
    required this.productThatInteractWith,
  });
}

class ChangeProductQuantitySuccessState extends CartState {
  ProductModel productThatInteractWith;

  ChangeProductQuantitySuccessState({
    required this.productThatInteractWith,
  });
}

///Checkout states
class CheckoutLoadingState extends CartState {
  CheckoutLoadingState();
}

class CheckoutFailedState extends CartState {
  CustomError error;

  CheckoutFailedState({
    required this.error,
  });
}

class CheckoutSuccessState extends CartState {
  CheckoutSuccessState();
}
