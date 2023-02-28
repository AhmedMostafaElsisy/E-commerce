import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:captien_omda_customer/core/model/cart_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/Error_Handling/custom_exception.dart';
import '../repo_interface/cart_repo_interface.dart';

class CartUseCase {
  final CartRepositoryInterFace cartRepositoryInterFace;

  CartUseCase({required this.cartRepositoryInterFace});

  Future<Either<CustomException, List<CartModel>>>
      callAllCartItemsUseCase() async {
    return cartRepositoryInterFace.getCartItems();
  }

  Future<Either<CustomException, CartModel>> callAddProductToCartUseCase({
    required int productId,
    required int quantity,
  }) async {
    return cartRepositoryInterFace.addProductToCart(
        productId: productId, quantity: quantity);
  }

  Future<Either<CustomException, CartModel>>
      callIncreaseProductQuantityInCartUseCase({
    required int productId,
    required int quantity,
  }) async {
    return cartRepositoryInterFace.increaseProductQuantity(
        productId: productId, quantity: quantity);
  }

  Future<Either<CustomException, CartModel>>
      callDecreaseProductQuantityInCartUseCase({
    required int productId,
    required int quantity,
  }) async {
    return cartRepositoryInterFace.decreaseProductQuantity(
        productId: productId, quantity: quantity);
  }

  Future<Either<CustomException, BaseModel>> callRemoveProductFormCartUseCase({
    required int productId,
  }) async {
    return cartRepositoryInterFace.removeItemFromCart(productId: productId);
  }

  Future<Either<CustomException, BaseModel>> callCreateOrderUseCase() async {
    return cartRepositoryInterFace.createOrder();
  }
}
