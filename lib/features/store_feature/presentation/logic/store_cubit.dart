import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/model/shop_model.dart';
import '../../domain/ues_cases/ues_cases.dart';
import 'store_states.dart';

class StoreCubit extends Cubit<StoreStates> {
  StoreCubit(this.uesCase) : super(StoreInitialStates());

  static StoreCubit get(context) => BlocProvider.of(context);
  final StoreUesCase uesCase;

  List<ShopModel> myStoreList = [];

  ///pagination
  int page = 1;
  late ScrollController scrollController;
  bool hasMoreData = false;

  getMyStoreListData() async {
    emit(StoreLoadingStates());
    page = 1;
    var result = await uesCase.getMyShopList(page: page);
    result.fold((error) => emit(StoreFailedStates(error)), (data) {
      myStoreList = data;
      if (myStoreList.isEmpty) {
        emit(StoreEmptyStates());
      } else {
        emit(StoreSuccessStates());
      }
    });
  }

  void setupScrollController() {
    if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      if (state is! StoreLoadingMoreDataStates && hasMoreData) {
        whenScrollMyStorePagination();
      }
    }
  }

  ///get request history pagination
  whenScrollMyStorePagination() async {
    emit(StoreLoadingMoreDataStates());
    page = page + 1;
    var result = await uesCase.getMyShopList(page: page);

    result.fold(
      (error) => emit(StoreFailedMoreDataStates(error)),
      (data) {
        hasMoreData = data.length == 10;
        myStoreList.addAll(data);
        emit(StoreSuccessStates());
      },
    );
  }

}
