import 'package:captien_omda_customer/features/rating_feature/presentation/logic/rating_cubit_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Domain/ues_cases/rating_ues_cases.dart';

class RatingCubit extends Cubit<RatingCubitStates> {
  RatingCubit(this._ratingUesCases) : super(RatingInitialStates());
  final RatingUesCases _ratingUesCases;

  static RatingCubit get(context) => BlocProvider.of(context);
int currentRating=0;
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
