import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:captien_omda_customer/core/model/cart_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/Error_Handling/custom_exception.dart';

abstract class CartRepositoryInterFace {
  Future<Either<CustomException, List<CartModel>>> getCartItems();

  Future<Either<CustomException, List<CartModel>>> addProductToCart({
    required int productId,
    required int quantity,
  });

  Future<Either<CustomException, List<CartModel>>> increaseProductQuantity({
    required int productId,
    required int quantity,
  });

  Future<Either<CustomException, List<CartModel>>> decreaseProductQuantity({
    required int productId,
    required int quantity,
  });

  Future<Either<CustomException, List<CartModel>>> removeItemFromCart({
    required int productId,
  });

  Future<Either<CustomException, BaseModel>> createOrder();
}
