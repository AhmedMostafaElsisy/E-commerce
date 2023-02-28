import 'package:captien_omda_customer/core/model/base_model.dart';
import 'package:captien_omda_customer/core/model/cart_model.dart';
import 'package:captien_omda_customer/features/cart_feature/data/data_sources/cart_data_source_remote.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/Error_Handling/custom_exception.dart';
import '../../domain/repo_interface/cart_repo_interface.dart';

class CartRepositoryImplementation implements CartRepositoryInterFace {
  final CartDataSourceRemoteInterface dataSource;

  CartRepositoryImplementation({
    required this.dataSource,
  });

  @override
  Future<Either<CustomException, CartModel>> addProductToCart(
      {required int productId, required int quantity}) async {
    return await dataSource
        .addOREditProductQuantityCart(productId: productId, quantity: quantity)
        .then((value) => value.fold((l) => left(l), (r) {
              CartModel cartModel = CartModel.fromJson(r.data);
              return right(cartModel);
            }));
  }

  @override
  Future<Either<CustomException, CartModel>> decreaseProductQuantity(
      {required int productId, required int quantity}) async {
    return await dataSource
        .addOREditProductQuantityCart(productId: productId, quantity: quantity)
        .then((value) => value.fold((l) => left(l), (r) {
              CartModel cartModel = CartModel.fromJson(r.data);
              return right(cartModel);
            }));
  }

  @override
  Future<Either<CustomException, List<CartModel>>> getCartItems() async {
    return await dataSource.getCartItems().then(
          (value) => value.fold(
            (l) => left(l),
            (r) {
              List<CartModel> carts = cartsListFromJson(r.data);
              return right(carts);
            },
          ),
        );
  }

  @override
  Future<Either<CustomException, CartModel>> increaseProductQuantity(
      {required int productId, required int quantity}) async {
    return await dataSource
        .addOREditProductQuantityCart(productId: productId, quantity: quantity)
        .then((value) => value.fold((l) => left(l), (r) {
              CartModel cartModel = CartModel.fromJson(r.data);
              return right(cartModel);
            }));
  }

  @override
  Future<Either<CustomException, BaseModel>> removeItemFromCart(
      {required int productId}) async {
    return await dataSource.removeProduct(productId: productId).then(
          (value) => value.fold(
            (l) => left(l),
            (r) => right(r),
          ),
        );
  }

  @override
  Future<Either<CustomException, BaseModel>> createOrder() async {
    return await dataSource.checkOut().then(
          (value) => value.fold(
            (l) => left(l),
            (r) => right(r),
          ),
        );
  }
}
