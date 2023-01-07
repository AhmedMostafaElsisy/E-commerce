import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/model/product_model.dart';
import '../../../domain/ues_cases/ues_cases.dart';
import 'my_store_states.dart';

class MyStoreCubit extends Cubit<MyStoreStates> {
  MyStoreCubit(this.uesCase) : super(MyStoreInitialStates());

  static MyStoreCubit get(context) => BlocProvider.of(context);
  final StoreUesCase uesCase;

  List<ProductModel> productList = [];

  ///pagination
  int page = 1;
  late ScrollController scrollController;
  bool hasMoreData = false;

  getStoreProductList({required int shopID}) async {
    emit(MyStoreLoadingStates());
    page = 1;
    var result =
        await uesCase.getMyShopProductListList(shopId: shopID, page: page);
    result.fold((error) => emit(MyStoreFailedStates(error)), (data) {
      productList = data;
      if (productList.isEmpty) {
        emit(MyStoreEmptySuccessStates());
      } else {
        emit(MyStoreSuccessStates());
      }
    });
  }

  void setupScrollController({required int shopID}) {
    if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      if (state is! MyStoreLoadingMoreDataStates && hasMoreData) {
        whenScrollProductPagination(shopID: shopID);
      }
    }
  }

  whenScrollProductPagination({required int shopID}) async {
    emit(MyStoreLoadingMoreDataStates());
    page = page + 1;
    var result =
        await uesCase.getMyShopProductListList(shopId: shopID, page: page);

    result.fold(
      (error) => emit(MyStoreFailedLoadingMoreStates(error)),
      (data) {
        hasMoreData = data.length == 10;
        productList.addAll(data);
        emit(MyStoreSuccessStates());
      },
    );
  }
}
