import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:captien_omda_customer/core/model/cart_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/Error_Handling/custom_exception.dart';

abstract class CartRepositoryInterFace {
  Future<Either<CustomException, List<CartModel>>> getCartItems();

  Future<Either<CustomException, CartModel>> addProductToCart({
    required int productId,
    required int quantity,
  });

  Future<Either<CustomException, CartModel>> increaseProductQuantity({
    required int productId,
    required int quantity,
  });

  Future<Either<CustomException, CartModel>> decreaseProductQuantity({
    required int productId,
    required int quantity,
  });

  Future<Either<CustomException, BaseModel>> removeItemFromCart({
    required int productId,
  });

  Future<Either<CustomException, BaseModel>> createOrder();
}
