import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/general_product_feature/domain/use_case/product_use_case.dart';
import '../../../../../core/model/product_model.dart';
import 'product_details_states.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsStates> {
  GeneralProductUseCase productUseCase;
  late ProductModel product;

  ProductDetailsCubit(
    this.productUseCase,
  ) : super(ProductDetailsInitStates());

  getProductDetails({required String productId}) {
    emit(ProductDetailsLoadingStates());
    productUseCase.getProductDetailsUseCase(productId: productId).then(
          (value) => value.fold(
            (l) => emit(ProductDetailsFailedStates(error: l)),
            (productModel) {
              product = productModel;
              emit(ProductDetailsSuccessStates());
            },
          ),
        );
  }
}
