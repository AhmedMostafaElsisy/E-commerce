import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/model/shop_model.dart';
import '../../../domain/ues_cases/general_stores_ues_cases.dart';
import 'general_stores_states.dart';

class GeneralStoresCubit extends Cubit<GeneralStoresStates> {
  GeneralStoresCubit(this.uesCase) : super(GeneralStoresInitialStates());

  final GeneralStoresUesCase uesCase;

  List<ShopModel> generalGeneralStoressList = [];

  ///pagination
  int page = 1;
  late ScrollController scrollController;
  bool hasMoreData = false;

  getGeneralStoresListData() async {
    emit(GeneralStoresLoadingStates());
    page = 1;
    var result = await uesCase.getGeneralShopList(page: page);
    result.fold((error) => emit(GeneralStoresFailedStates(error)), (data) {
      generalGeneralStoressList = data;
      if (generalGeneralStoressList.isEmpty) {
        emit(GeneralStoresEmptyStates());
      } else {
        emit(GeneralStoresSuccessStates());
      }
    });
  }

  void setupScrollController() {
    if (scrollController.offset >
            scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      if (state is! GeneralStoresLoadingMoreDataStates && hasMoreData) {
        whenScrollGeneralStoresPagination();
      }
    }
  }

  ///get request history pagination
  whenScrollGeneralStoresPagination() async {
    emit(GeneralStoresLoadingMoreDataStates());
    page = page + 1;
    var result = await uesCase.getGeneralShopList(page: page);

    result.fold(
      (error) => emit(GeneralStoresFailedMoreDataStates(error)),
      (data) {
        hasMoreData = data.length == 10;
        generalGeneralStoressList.addAll(data);
        emit(GeneralStoresSuccessStates());
      },
    );
  }
}
