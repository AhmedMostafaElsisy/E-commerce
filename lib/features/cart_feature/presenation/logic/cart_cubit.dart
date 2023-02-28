import 'package:captien_omda_customer/features/cart_feature/domain/use_case/cart_use_case.dart';
import 'package:captien_omda_customer/features/cart_feature/presenation/logic/cart_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/model/cart_model.dart';

class CartCubit extends Cubit<CartState> {
  CartUseCase cartUseCase;

  CartCubit(this.cartUseCase) : super(CartInitState());

  List<CartModel> cartItems = [];

  getCartItems() {
    emit(GetCartItemsLoadingState());
    cartUseCase.callAllCartItemsUseCase().then(
          (value) => value.fold(
              (l) => emit(
                    GetCartItemsFailedState(
                      error: l.error,
                    ),
                  ), (data) {
            cartItems = data;
            emit(
              GetCartItemsSuccessState(
                cartItems: data,
              ),
            );
          }),
        );
  }
}
