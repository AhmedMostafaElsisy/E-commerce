import 'package:captien_omda_customer/features/rating_feature/presentation/logic/rating_cubit_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Domain/model/store_rating_model.dart';
import '../../Domain/ues_cases/rating_ues_cases.dart';

class RatingCubit extends Cubit<RatingCubitStates> {
  RatingCubit(this._ratingUesCases) : super(RatingInitialStates());
  final RatingUesCases _ratingUesCases;

  static RatingCubit get(context) => BlocProvider.of(context);
int currentRating=0;
  List<StoreRatingModel> storeRatingList = [];

  ///pagination
  int page = 1;
  late ScrollController scrollController;
  bool hasMoreData = false;

  getRatingListListData() async {
    emit(RatingListLoadingStates());
    page = 1;
    var result = await _ratingUesCases.getRatingList(page: page);
    result.fold((error) => emit(RatingListFailedStates(error)), (data) {
      storeRatingList = data;
      if (storeRatingList.isEmpty) {
        emit(RatingListEmptyStates());
      } else {
        emit(RatingListSuccessStates());
      }
    });
  }

  void setupScrollController() {
    if (scrollController.offset >
        scrollController.position.maxScrollExtent - 200 &&
        scrollController.offset <= scrollController.position.maxScrollExtent) {
      if (state is! RatingListLoadingMoreDataStates && hasMoreData) {
        whenScrollRatingListPagination();
      }
    }
  }

  ///get request history pagination
  whenScrollRatingListPagination() async {
    emit(RatingListLoadingMoreDataStates());
    page = page + 1;
    var result = await _ratingUesCases.getRatingList(page: page);

    result.fold(
          (error) => emit(RatingListFailedMoreDataStates(error)),
          (data) {
        hasMoreData = data.length == 10;
        storeRatingList.addAll(data);
        emit(RatingListSuccessStates());
      },
    );
  }

  addRating(
      {required int orderId,
      required int rate,
      required String comment}) async {
    emit(RatingLoadingStates());
    var result = await _ratingUesCases.callAddRating(
       orderId: orderId, rate: rate, comment: comment);
    result.fold((error) => emit(RatingFailedStates(error)),
        (success) => emit(RatingSuccessStates()));
  }
  setRate(value){
    currentRating=value;
    emit(RatingInitialStates());
  }
}
