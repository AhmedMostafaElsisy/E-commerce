import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/model/product_model.dart';
import '../../../../../core/product_Feature/domain/use_case/product_use_case.dart';
import 'home_product_states.dart';

class HomeProductCubit extends Cubit<HomeProductStates> {
  GeneralProductUseCase productUseCase;
  List<ProductModel> products = [];

  HomeProductCubit(
    this.productUseCase,
  ) : super(HomeProductInitStates());

  getHomeProducts() {
    emit(HomeProductLoadingStates());
    productUseCase.getHomePageProductUseCase().then(
          (value) => value.fold(
            (l) => emit(HomeProductFailedStates(error: l)),
            (productsList) {
              products = productsList;
              emit(HomeProductSuccessStates());
            },
          ),
        );
  }
}
