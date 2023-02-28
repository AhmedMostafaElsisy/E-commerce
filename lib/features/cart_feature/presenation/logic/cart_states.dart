import '../../../../core/Error_Handling/custom_error.dart';
import '../../../../core/model/cart_model.dart';

abstract class CartState {}

class CartInitState extends CartState {}

class GetCartItemsLoadingState extends CartState {}

class GetCartItemsFailedState extends CartState {
  CustomError error;

  GetCartItemsFailedState({required this.error});
}

class GetCartItemsSuccessState extends CartState {
  List<CartModel> cartItems;

  GetCartItemsSuccessState({required this.cartItems});
}
