import 'package:captien_omda_customer/core/Constants/Enums/exception_enums.dart';
import 'package:captien_omda_customer/core/Error_Handling/custom_error.dart';
import 'package:captien_omda_customer/core/model/product_model.dart';
import 'package:captien_omda_customer/features/cart_feature/domain/use_case/cart_use_case.dart';
import 'package:captien_omda_customer/features/cart_feature/presenation/logic/cart_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/model/cart_model.dart';
import 'cart_events.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartUseCase cartUseCase;

  CartBloc(this.cartUseCase) : super(CartInitState()) {
    on<GetCartItemEvent>((event, emit) async {
      await getCartItems(emitter: emit);
    });
    on<AddProductToCartEvent>((event, emit) async {
      await addProductToCartItems(
        emitter: emit,
        productModel: event.productModel,
      );
    });
    on<ChangeProductQuantityDependOnCartOrNotEvent>((event, emit) async {
      await changeProductQuantity(
        emitter: emit,
        productModel: event.productModel,
        newQuantity: event.quantity,
      );
    });
    on<RemoveProductFromCartEvent>((event, emit) async {
      await removeProductFromCart(
        emitter: emit,
        productModel: event.productModel,
      );
    });
    on<ConfirmOrderEvent>((event, emit) async {
      await checkoutOrder(
        emitter: emit,
      );
    });
  }

  List<CartModel> cartItems = [];

  getCartItems({required Emitter emitter}) async {
    emitter(GetCartItemsLoadingState());
    await cartUseCase.callAllCartItemsUseCase().then(
          (value) => value.fold(
              (l) => emitter(
                    GetCartItemsFailedState(
                      error: l.error,
                    ),
                  ), (data) {
            cartItems = data;
            emitter(
              GetCartItemsSuccessState(
                cartItems: data,
              ),
            );
          }),
        );
  }

  addProductToCartItems({
    required Emitter emitter,
    required ProductModel productModel,
  }) async {
    emitter(
        AddProductToCartLoadingState(productThatInteractWith: productModel));
    await cartUseCase
        .callAddProductToCartUseCase(
            productId: productModel.id!,
            quantity: productModel.productTempQuantity.toInt())
        .then(
          (value) => value.fold(
              (l) => emitter(
                    AddProductToCartFailedState(
                        error: l.error, productThatInteractWith: productModel),
                  ), (data) {
            debugPrint("here is your cart data${cartItems.toString()}");
            cartItems = data;
            debugPrint("here is your cart data${cartItems.toString()}");

            emitter(
              AddProductToCartSuccessState(
                  productThatInteractWith: productModel),
            );
          }),
        );
  }

  changeProductQuantity({
    required Emitter emitter,
    required ProductModel productModel,
    required int newQuantity,
  }) async {
    emitter(ChangeProductQuantityLoadingState(
        productThatInteractWith: productModel));

    if ((productModel.productTempQuantity + newQuantity) >= 1) {
      if (isProductOnCart(productModel: productModel)) {
        await cartUseCase
            .callAddProductToCartUseCase(
              productId: productModel.id!,
              quantity: newQuantity,
            )
            .then(
              (value) => value.fold(
                  (l) => emitter(
                        ChangeProductQuantityFailedState(
                          error: l.error,
                          productThatInteractWith: productModel,
                        ),
                      ), (data) {
                debugPrint("here is your cart data${cartItems.toString()}");
                cartItems = data;
                debugPrint("here is your cart data${cartItems.toString()}");

                emitter(
                  ChangeProductQuantitySuccessState(
                      productThatInteractWith: productModel),
                );
              }),
            );
      } else {
        productModel.productTempQuantity += newQuantity;
        emitter(
          ChangeProductQuantitySuccessState(
              productThatInteractWith: productModel),
        );
      }
    } else {
      emitter(
        ChangeProductQuantityFailedState(
          error: CustomError(type: CustomStatusCodeErrorType.quantityNotValid),
          productThatInteractWith: productModel,
        ),
      );
    }
  }

  removeProductFromCart({
    required Emitter emitter,
    required ProductModel productModel,
  }) async {
    emitter(
        RemoveProductToCartLoadingState(productThatInteractWith: productModel));
    await cartUseCase
        .callRemoveProductFormCartUseCase(
          productId: productModel.id!,
        )
        .then(
          (value) => value.fold(
              (l) => emitter(
                    RemoveProductToCartFailedState(
                        error: l.error, productThatInteractWith: productModel),
                  ), (data) {
            debugPrint("here is your cart data${cartItems.toString()}");
            cartItems = data;
            debugPrint("here is your cart data${cartItems.toString()}");

            emitter(
              RemoveProductToCartSuccessState(
                  productThatInteractWith: productModel),
            );
          }),
        );
  }

  checkoutOrder({
    required Emitter emitter,
  }) async {
    emitter(CheckoutLoadingState());
    await cartUseCase.callCreateOrderUseCase().then(
          (value) => value.fold(
              (l) => emitter(
                    CheckoutFailedState(
                      error: l.error,
                    ),
                  ), (data) {
            debugPrint("here is your cart data${cartItems.toString()}");
            cartItems = [];
            debugPrint("here is your cart data${cartItems.toString()}");

            emitter(
              CheckoutSuccessState(),
            );
            emitter(
              CheckoutSuccessState(),
            );
          }),
        );
  }

  bool isProductOnCart({required ProductModel productModel}) {
    return cartItems
        .where((element) => element.productModel.id == productModel.id)
        .isNotEmpty;
  }

  num getProductQuantityIfFountOnCart({required ProductModel productModel}) {
    if (cartItems
        .where((element) => element.productModel.id == productModel.id)
        .isNotEmpty) {
      return cartItems
          .where((element) => element.productModel.id == productModel.id)
          .first
          .quantity;
    } else {
      return productModel.productTempQuantity;
    }
  }

  int totalPriceOfCartItems() {
    int totalPrices = 0;
    if (cartItems.isNotEmpty) {
      for (var element in cartItems) {
        totalPrices += element.total.toInt();
      }
      return totalPrices;
    } else {
      return totalPrices;
    }
  }
}
