import 'package:captien_omda_customer/core/Helpers/shared_texts.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/model/product_model.dart';
import '../../../../../core/product_Feature/domain/use_case/product_use_case.dart';
import 'product_list_states.dart';

class ProductListCubitWithFilter extends Cubit<ProductListStates> {
  GeneralProductUseCase productUseCase;

  List<ProductModel> products = [];

  ProductListCubitWithFilter(
    this.productUseCase,
  ) : super(ProductListInitStates());

  ///pagination
  int page = 1;
  String? searchNameTemp;

  late ScrollController scrollController;
  bool hasMoreData = false;

  getProducts({
    String? searchName,
  }) {
    hasMoreData = true;
    page = 1;
    searchNameTemp = searchName;
    emit(ProductListLoadingStates());
    productUseCase
        .getProductWithFilterUseCase(
          page: page,
          searchName: searchName,
          categories: SharedText.filterModel?.categories,
          tags: SharedText.filterModel?.tags,
          cityId: SharedText.filterModel?.cityId,
          areaId: SharedText.filterModel?.areaId,
        )
        .then(
          (value) => value.fold(
            (l) => emit(ProductListFailedStates(error: l)),
            (productsList) {
              hasMoreData = productsList.length == 10;

              if (productsList.isEmpty) {
                products.clear();
                emit(ProductListEmptyStates());
              } else {
                products = productsList;
                emit(ProductListSuccessStates());
              }
            },
          ),
        );
  }

  void setupScrollController() {
    if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      if (state is! GetMoreProductListLoadingStates && hasMoreData) {
        whenScrollProductPagination();
      }
    }
  }

  ///get request history pagination
  whenScrollProductPagination() async {
    emit(GetMoreProductListLoadingStates());
    page = page + 1;
    var result = await productUseCase.getProductWithFilterUseCase(
      page: page,
      searchName: searchNameTemp,
      categories: SharedText.filterModel?.categories,
      tags: SharedText.filterModel?.tags,
      cityId: SharedText.filterModel?.cityId,
      areaId: SharedText.filterModel?.areaId,
    );

    result.fold(
      (error) => emit(GetMoreProductListFailedStates(error: error)),
      (data) {
        hasMoreData = data.length == 10;
        products.addAll(data);
        emit(GetMoreProductListSuccessStates());
      },
    );
  }
}
