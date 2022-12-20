import 'package:captien_omda_customer/features/rating_feature/presentation/logic/rating_cubit_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Domain/ues_cases/rating_ues_cases.dart';

class RatingCubit extends Cubit<RatingCubitStates> {
  RatingCubit(this._ratingUesCases) : super(RatingInitialStates());
  final RatingUesCases _ratingUesCases;

  static RatingCubit get(context) => BlocProvider.of(context);

  addRating(
      {required int driverId,
      required int requestId,
      required int rate,
      required String comment}) async {
    emit(RatingLoadingStates());
    var result = await _ratingUesCases.callAddRating(
        driverId: driverId, requestId: requestId, rate: rate, comment: comment);
    result.fold((error) => emit(RatingFailedStates(error)),
        (success) => emit(RatingSuccessStates()));
  }
}
